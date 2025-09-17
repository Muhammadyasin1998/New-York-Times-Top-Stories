// features/auth/data/models/user_model.dart
import 'package:nyt_top_stories/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String name,
  }) : super(id: id, email: email, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
    };
  }
}
