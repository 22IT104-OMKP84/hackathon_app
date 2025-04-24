class Hackathon {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> prizes;
  final List<String> rules;
  final int maxTeamSize;
  final String imageUrl;
  final bool isRegistrationOpen;

  Hackathon({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.prizes,
    required this.rules,
    required this.maxTeamSize,
    required this.imageUrl,
    required this.isRegistrationOpen,
  });

  factory Hackathon.fromJson(Map<String, dynamic> json) {
    return Hackathon(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      location: json['location'],
      prizes: List<String>.from(json['prizes']),
      rules: List<String>.from(json['rules']),
      maxTeamSize: json['maxTeamSize'],
      imageUrl: json['imageUrl'],
      isRegistrationOpen: json['isRegistrationOpen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'prizes': prizes,
      'rules': rules,
      'maxTeamSize': maxTeamSize,
      'imageUrl': imageUrl,
      'isRegistrationOpen': isRegistrationOpen,
    };
  }
} 