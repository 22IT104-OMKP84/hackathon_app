class ParticipationHistory {
  final String hackathonId;
  final String hackathonTitle;
  final String teamName;
  final String role;
  final DateTime participationDate;
  final String? projectName;
  final String? projectDescription;
  final String? githubLink;
  final bool isWinner;
  final String? prize;

  ParticipationHistory({
    required this.hackathonId,
    required this.hackathonTitle,
    required this.teamName,
    required this.role,
    required this.participationDate,
    this.projectName,
    this.projectDescription,
    this.githubLink,
    this.isWinner = false,
    this.prize,
  });

  factory ParticipationHistory.fromJson(Map<String, dynamic> json) {
    return ParticipationHistory(
      hackathonId: json['hackathonId'],
      hackathonTitle: json['hackathonTitle'],
      teamName: json['teamName'],
      role: json['role'],
      participationDate: DateTime.parse(json['participationDate']),
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      githubLink: json['githubLink'],
      isWinner: json['isWinner'] ?? false,
      prize: json['prize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hackathonId': hackathonId,
      'hackathonTitle': hackathonTitle,
      'teamName': teamName,
      'role': role,
      'participationDate': participationDate.toIso8601String(),
      'projectName': projectName,
      'projectDescription': projectDescription,
      'githubLink': githubLink,
      'isWinner': isWinner,
      'prize': prize,
    };
  }
} 