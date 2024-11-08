// models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String profilePicUrl;
  final List<String> friends;

  UserModel({
    required this.id,
    required this.name,
    required this.profilePicUrl,
    required this.friends,
  });

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
      id: doc['id'],
      name: doc['name'],
      profilePicUrl: doc['profilePicUrl'],
      friends: List<String>.from(doc['friends'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePicUrl': profilePicUrl,
      'friends': friends,
    };
  }
}
