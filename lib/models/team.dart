class TeamMember {
  final String userId;
  final String name;
  final String role;

  TeamMember({
    required this.userId,
    required this.name,
    required this.role,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      userId: json['userId'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'role': role,
    };
  }
}

class Team {
  final String id;
  final String name;
  final String hackathonId;
  final List<TeamMember> members;
  final String? projectName;
  final String? projectDescription;
  final String? githubLink;

  Team({
    required this.id,
    required this.name,
    required this.hackathonId,
    required this.members,
    this.projectName,
    this.projectDescription,
    this.githubLink,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      hackathonId: json['hackathonId'],
      members: (json['members'] as List)
          .map((member) => TeamMember.fromJson(member))
          .toList(),
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      githubLink: json['githubLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hackathonId': hackathonId,
      'members': members.map((member) => member.toJson()).toList(),
      'projectName': projectName,
      'projectDescription': projectDescription,
      'githubLink': githubLink,
    };
  }
} 