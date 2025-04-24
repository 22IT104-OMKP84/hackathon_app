import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoService {
  static final MongoService _instance = MongoService._internal();
  factory MongoService() => _instance;
  MongoService._internal();

  late Db _db;
  late DbCollection _hackathonsCollection;
  late DbCollection _usersCollection;
  late DbCollection _teamsCollection;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<void> connect() async {
    try {
      await dotenv.load();
      final password = dotenv.env['MONGODB_PASSWORD'] ?? '';
      final connectionString = 'mongodb+srv://harsh:$password@cluster0.hvxt9hj.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
      
      _db = await Db.create(connectionString);
      await _db.open();
      _isConnected = true;
      
      _hackathonsCollection = _db.collection('hackathons');
      _usersCollection = _db.collection('users');
      _teamsCollection = _db.collection('teams');
      
      print('Successfully connected to MongoDB');
    } catch (e) {
      _isConnected = false;
      print('Error connecting to MongoDB: $e');
      rethrow;
    }
  }

  Future<void> initializeStaticData() async {
    // Initialize hackathons
    await _hackathonsCollection.insertMany([
      {
        '_id': ObjectId(),
        'id': '1',
        'title': 'Flutter Hackathon 2023',
        'description': 'A hackathon focused on building Flutter applications',
        'imageUrl': 'https://example.com/flutter-hackathon.jpg',
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
        '_id': ObjectId(),
        'id': '2',
        'title': 'AI Innovation Challenge',
        'description': 'Build innovative AI solutions',
        'imageUrl': 'https://example.com/ai-hackathon.jpg',
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
    ]);

    // Initialize a sample user
    final userId = ObjectId();
    await _usersCollection.insertOne({
      '_id': userId,
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
    });
  }

  Future<List<Map<String, dynamic>>> getHackathons() async {
    return await _hackathonsCollection.find().toList();
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    return await _usersCollection.findOne(where.eq('id', id));
  }

  Future<void> createTeam(String hackathonId, String teamName) async {
    await _teamsCollection.insertOne({
      '_id': ObjectId(),
      'hackathonId': hackathonId,
      'teamName': teamName,
      'members': [],
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> addParticipationHistory(String userId, Map<String, dynamic> history) async {
    await _usersCollection.update(
      where.eq('id', userId),
      modify.push('participationHistory', history),
    );
  }

  Future<void> updateUserProfile(String userId, String name, String email) async {
    await _usersCollection.update(
      where.eq('id', userId),
      modify.set('name', name).set('email', email),
    );
  }

  Future<void> close() async {
    await _db.close();
  }
} 