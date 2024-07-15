class User {
  final String email;
  final String name;
  final String phone;
  final String id;
  final String role;
  final String classInfo;
  final String nameRole;
  User({
    required this.email,
    required this.name,
    required this.phone,
    required this.id,
    required this.role,
    required this.classInfo,
    required this.nameRole,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      email: data['data']['record']['email'],
      name: data['data']['record']['name'],
      phone: data['data']['record']['phone'],
      id: data['data']['record']['id'],
      role: data['data']['record']['roleInfo']['role'],
      classInfo: data['data']['record']['teacher']['class']['name'],
      nameRole: data['data']['record']['roleInfo']['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'id': id,
      'role': role,
      'classInfo': classInfo,
      'nameRole': nameRole,
    };
  }
}
