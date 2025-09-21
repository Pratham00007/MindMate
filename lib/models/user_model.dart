class UserModel {
  final String uid;
  final String email;
  final String realName;
  final String anonymousUsername;
  final String? phone;
  final DateTime? dob;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelation;
  final int totalSessions;
  final int currentStreak;
  final String currentMood;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.realName,
    required this.anonymousUsername,
    this.phone,
    this.dob,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelation,
    this.totalSessions = 0,
    this.currentStreak = 0,
    this.currentMood = 'Good',
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      realName: map['realName'] ?? '',
      anonymousUsername: map['anonymousUsername'] ?? '',
      phone: map['phone'],
      dob: map['dob'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dob']) : null,
      emergencyContactName: map['emergencyContactName'],
      emergencyContactPhone: map['emergencyContactPhone'],
      emergencyContactRelation: map['emergencyContactRelation'],
      totalSessions: map['totalSessions'] ?? 0,
      currentStreak: map['currentStreak'] ?? 0,
      currentMood: map['currentMood'] ?? 'Good',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'realName': realName,
      'anonymousUsername': anonymousUsername,
      'phone': phone,
      'dob': dob?.millisecondsSinceEpoch,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'emergencyContactRelation': emergencyContactRelation,
      'totalSessions': totalSessions,
      'currentStreak': currentStreak,
      'currentMood': currentMood,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? realName,
    String? anonymousUsername,
    String? phone,
    DateTime? dob,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelation,
    int? totalSessions,
    int? currentStreak,
    String? currentMood,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      realName: realName ?? this.realName,
      anonymousUsername: anonymousUsername ?? this.anonymousUsername,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      emergencyContactRelation: emergencyContactRelation ?? this.emergencyContactRelation,
      totalSessions: totalSessions ?? this.totalSessions,
      currentStreak: currentStreak ?? this.currentStreak,
      currentMood: currentMood ?? this.currentMood,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}