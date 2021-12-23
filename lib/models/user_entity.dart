import 'dart:convert';

class UserEntity {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  
  UserEntity({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
  });

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(uid != null){
      result.addAll({'uid': uid});
    }
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
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserEntity &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoUrl.hashCode;
  }
}
