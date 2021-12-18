import 'dart:convert';

class UserEntity {
  String? name;
  String? email;
  String? photoUrl;
  UserEntity({
    this.name,
    this.email,
    this.photoUrl,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(photoUrl != null){
      result.addAll({'photoUrl': photoUrl});
    }
  
    return result;
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  @override
  String toString() => 'UserEntity(name: $name, email: $email, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserEntity &&
      other.name == name &&
      other.email == email &&
      other.photoUrl == photoUrl;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ photoUrl.hashCode;
}
