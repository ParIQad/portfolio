class UserModel {
  final String token;
  final String username;
  final String firstName;

  UserModel({
    required this.token,
    required this.username,
    required this.firstName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      username: json['username'],
      firstName: json['firstName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'firstName': firstName,
    };
  }
}