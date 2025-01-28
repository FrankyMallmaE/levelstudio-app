class User {
  final String id;
  final String name;
  final String lastname;
  final String age;

  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.age,
  });

  // Método para crear un objeto User a partir de un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      age: json['age'] ?? '',
    );
  }

  // Método para convertir un objeto User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'age': age,
    };
  }
}