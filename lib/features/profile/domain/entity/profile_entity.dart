class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address
  }) {
    return ProfileEntity(
      id: id ?? this.id, 
      email: email ?? this.email,
      name: name ?? this.name, 
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}