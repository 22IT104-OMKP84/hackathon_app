import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = 'https://api.example.com'; // Replace with your actual API URL
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    // For now, we'll use static data
    _isInitialized = true;
  }

  Future<List<Map<String, dynamic>>> getHackathons() async {
    // Static data for now
    return [
      {
        'id': '1',
        'title': 'Flutter Hackathon 2023',
        'description': 'A hackathon focused on building Flutter applications',
        'imageUrl': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Flablab.ai%2Fevent%2Fgenerative-ai-hackathon&psig=AOvVaw1vJbmmqWhWzEOOM1UDWmlP&ust=1745516836534000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOjIg4nb7owDFQAAAAAdAAAAABAE',
        'location': 'Virtual',
        'startDate': DateTime(2023, 3, 1).toIso8601String(),
        'endDate': DateTime(2023, 3, 3).toIso8601String(),
        'maxTeamSize': 4,
        'isRegistrationOpen': true,
        'prizes': [
          'First Place: \$5,000',
          'Second Place: \$3,000',
          'Third Place: \$1,000',
        ],
        'rules': [
          'Teams must consist of 2-4 members',
          'All code must be written during the hackathon',
          'Projects must be built using Flutter',
        ],
      },
      {
        'id': '2',
        'title': 'AI Innovation Challenge',
        'description': 'Build innovative AI solutions',
        'imageUrl': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fedison365.com%2Fhow-do-hackathons-work%2F&psig=AOvVaw0LVS_geLyrIajTHbJPoWav&ust=1745516888868000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjE_aHb7owDFQAAAAAdAAAAABAE',
        'location': 'San Francisco',
        'startDate': DateTime(2023, 4, 1).toIso8601String(),
        'endDate': DateTime(2023, 4, 3).toIso8601String(),
        'maxTeamSize': 5,
        'isRegistrationOpen': true,
        'prizes': [
          'First Place: \$10,000',
          'Second Place: \$5,000',
          'Third Place: \$2,000',
        ],
        'rules': [
          'Teams must consist of 3-5 members',
          'Projects must incorporate AI/ML',
          'All code must be original',
        ],
      },
    ];
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    // Static data for now
    return {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'participationHistory': [
        {
          'hackathonId': '1',
          'hackathonTitle': 'Flutter Hackathon 2023',
          'teamName': 'Flutter Masters',
          'role': 'Team Lead',
          'participationDate': DateTime(2023, 3, 1).toIso8601String(),
          'projectName': 'Flutter E-commerce App',
          'projectDescription': 'A modern e-commerce app built with Flutter',
          'githubLink': 'https://github.com/example/flutter-ecommerce',
          'isWinner': true,
          'prize': 'First Place',
        },
      ],
    };
  }

  Future<void> createTeam(String hackathonId, String teamName) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> addParticipationHistory(String userId, Map<String, dynamic> history) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateUserProfile(String userId, String name, String email) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
  }
} 