import 'package:flutter/foundation.dart';
import '../models/hackathon.dart';
import '../models/team.dart';
import '../services/api_service.dart';

class HackathonProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Hackathon> _hackathons = [];
  List<Team> _teams = [];
  bool _isLoading = false;
  String? _error;

  List<Hackathon> get hackathons => _hackathons;
  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Dummy data for testing
  void _initializeDummyData() {
    _hackathons = [
      Hackathon(
        id: '1',
        title: 'Flutter Hackathon 2024',
        description: 'A hackathon focused on building amazing Flutter applications.',
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2024, 3, 3),
        location: 'Virtual',
        prizes: ['\$1000', 'Flutter Swag', 'Mentorship'],
        rules: [
          'Teams of 2-4 members',
          'Use Flutter for the project',
          'Submit before deadline',
        ],
        maxTeamSize: 4,
        imageUrl: 'https://picsum.photos/200',
        isRegistrationOpen: true,
      ),
      Hackathon(
        id: '2',
        title: 'AI Innovation Challenge',
        description: 'Build innovative solutions using AI and machine learning.',
        startDate: DateTime(2024, 4, 1),
        endDate: DateTime(2024, 4, 3),
        location: 'Hybrid',
        prizes: ['\$2000', 'AI Tools Subscription', 'Workshop Access'],
        rules: [
          'Teams of 1-3 members',
          'Focus on AI/ML solutions',
          'Open source preferred',
        ],
        maxTeamSize: 3,
        imageUrl: 'https://picsum.photos/201',
        isRegistrationOpen: true,
      ),
    ];
  }

  Future<void> initialize() async {
    await _apiService.initialize();
    await loadHackathons();
  }

  Future<void> loadHackathons() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final hackathonData = await _apiService.getHackathons();
      _hackathons = hackathonData.map((data) => Hackathon.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to load hackathons: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTeam(String hackathonId, String teamName) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.createTeam(hackathonId, teamName);
    } catch (e) {
      _error = 'Failed to create team: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinTeam(String teamId, String userId, String userName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final team = _teams.firstWhere((t) => t.id == teamId);
      final updatedMembers = List<TeamMember>.from(team.members)
        ..add(TeamMember(
          userId: userId,
          name: userName,
          role: 'Member',
        ));
      
      _teams = _teams.map((t) {
        if (t.id == teamId) {
          return Team(
            id: t.id,
            name: t.name,
            hackathonId: t.hackathonId,
            members: updatedMembers,
            projectName: t.projectName,
            projectDescription: t.projectDescription,
            githubLink: t.githubLink,
          );
        }
        return t;
      }).toList();
    } catch (e) {
      _error = 'Failed to join team: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 