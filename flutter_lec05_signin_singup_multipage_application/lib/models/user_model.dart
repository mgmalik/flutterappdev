class UserModel {
  String name = "";
  String email = "";
  String password = "";

  UserModel() {
    name = "";
    email = "";
    password = "";
  }

  UserModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      email = json['email'] as String,
      password = json['password'] as String;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}
