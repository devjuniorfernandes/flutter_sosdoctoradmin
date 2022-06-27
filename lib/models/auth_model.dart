class Auth {
  int? id;
  String? name;
  String? image;
  String? email;
  int? level;
  String? token;

  Auth({
    this.id,
    this.name,
    this.image,
    this.email,
    this.level,
    this.token,
  });
  
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      level: json['user']['level'],
      token: json['token'],
    );
  }

}