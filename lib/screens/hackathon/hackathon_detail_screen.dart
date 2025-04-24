import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/hackathon.dart';
import '../../providers/hackathon_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';

class HackathonDetailScreen extends StatelessWidget {
  final String hackathonId;

  const HackathonDetailScreen({
    super.key,
    required this.hackathonId,
  });

  @override
  Widget build(BuildContext context) {
    final hackathon = context.read<HackathonProvider>().hackathons
        .firstWhere((h) => h.id == hackathonId);
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(hackathon.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/hacathon.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  print('Stack trace: $stackTrace');
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 50),
                        const SizedBox(height: 8),
                        Text(
                          'Image not found at: assets/images/hacathon.png',
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hackathon.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoSection(context, hackathon),
            const SizedBox(height: 16),
            _buildPrizesSection(context, hackathon),
            const SizedBox(height: 16),
            _buildRulesSection(context, hackathon),
            const SizedBox(height: 24),
            if (hackathon.isRegistrationOpen && authProvider.isAuthenticated)
              ElevatedButton(
                onPressed: () => _showTeamDialog(context, hackathon),
                child: const Text('Register for Hackathon'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Hackathon hackathon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildInfoRow('Location', hackathon.location),
            _buildInfoRow('Start Date', hackathon.startDate.toString()),
            _buildInfoRow('End Date', hackathon.endDate.toString()),
            _buildInfoRow('Max Team Size', '${hackathon.maxTeamSize} members'),
          ],
        ),
      ),
    );
  }

  Widget _buildPrizesSection(BuildContext context, Hackathon hackathon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prizes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...hackathon.prizes.map((prize) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events, size: 16),
                      const SizedBox(width: 8),
                      Text(prize),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRulesSection(BuildContext context, Hackathon hackathon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rules',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...hackathon.rules.map((rule) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.rule, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(rule)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _showTeamDialog(BuildContext context, Hackathon hackathon) {
    final teamNameController = TextEditingController();
    final projectNameController = TextEditingController();
    final projectDescriptionController = TextEditingController();
    final githubLinkController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            const Text('Team Registration'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: teamNameController,
                decoration: const InputDecoration(
                  labelText: 'Team Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your team name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: projectNameController,
                decoration: const InputDecoration(
                  labelText: 'Project Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your project name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: projectDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Project Description',
                  border: OutlineInputBorder(),
                  hintText: 'Describe your project',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: githubLinkController,
                decoration: const InputDecoration(
                  labelText: 'GitHub Repository Link',
                  border: OutlineInputBorder(),
                  hintText: 'https://github.com/username/repo',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Note: You can update project details later',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (teamNameController.text.isNotEmpty) {
                final authProvider = context.read<AuthProvider>();
                final hackathonProvider = context.read<HackathonProvider>();

                // Create team
                await hackathonProvider.createTeam(
                  hackathon.id,
                  teamNameController.text,
                );

                // Add to user's participation history
                if (authProvider.user != null) {
                  await authProvider.addParticipationHistory(
                    ParticipationHistory(
                      hackathonId: hackathon.id,
                      hackathonTitle: hackathon.title,
                      teamName: teamNameController.text,
                      role: 'Team Lead',
                      participationDate: DateTime.now(),
                      projectName: projectNameController.text.isNotEmpty
                          ? projectNameController.text
                          : null,
                      projectDescription:
                          projectDescriptionController.text.isNotEmpty
                              ? projectDescriptionController.text
                              : null,
                      githubLink: githubLinkController.text.isNotEmpty
                          ? githubLinkController.text
                          : null,
                    ),
                  );
                }

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Team created successfully!'),
                    ),
                  );
                }
              }
            },
            child: const Text('Create Team'),
          ),
        ],
      ),
    );
  }
} 