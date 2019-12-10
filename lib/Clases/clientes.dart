class Cliente{
  final int id;
  final String name;
  final String phones;
  final String celphone;
  final bool active;
  final String avatar;

  Cliente({this.id, this.name, this.phones, this.celphone, this.active, this.avatar, });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      active: json['active'] as bool,
      id: json['id'] as int,
      name: json['name'] as String,
      phones: json['phones'] as String,
      celphone: json['cel_phone'] as String,
      avatar: json['avatar'] as String
    );
  }  
}