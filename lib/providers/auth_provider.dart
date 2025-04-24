import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isAuthenticated = false;
  String? _token;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  User? get user => _user;

  Future<void> initialize() async {
    await _apiService.initialize();
  }

  Future<void> login(String email, String password) async {
    // TODO: Replace with actual authentication
    final userData = await _apiService.getUser('1'); // Using static user for now
    if (userData != null) {
      _user = User.fromJson(userData);
      _isAuthenticated = true;
      _token = 'dummy_token';
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password, String name) async {
    // TODO: Implement actual signup
    _user = User(
      id: '1',
      name: name,
      email: email,
      participationHistory: [],
    );
    _isAuthenticated = true;
    _token = 'dummy_token';
    notifyListeners();
  }

  Future<void> updateProfile(String name, String email) async {
    if (_user != null) {
      await _apiService.updateUserProfile(_user!.id, name, email);
      _user = User(
        id: _user!.id,
        name: name,
        email: email,
        participationHistory: _user!.participationHistory,
      );
      notifyListeners();
    }
  }

  Future<void> addParticipationHistory(ParticipationHistory history) async {
    if (_user != null) {
      await _apiService.addParticipationHistory(_user!.id, history.toJson());
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        participationHistory: [..._user!.participationHistory, history],
      );
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _token = null;
    _user = null;
    notifyListeners();
  }
} 