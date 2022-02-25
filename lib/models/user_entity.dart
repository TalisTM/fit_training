import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  int? done;
  DateTime? lastDate;
  
  UserEntity({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.done,
    this.lastDate,
  });

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    int? done,
    DateTime? lastDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      done: done ?? this.done,
      lastDate: lastDate ?? this.lastDate,
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
    if(done != null){
      result.addAll({'done': done});
    }
    if(lastDate != null){
      result.addAll({'lastDate': lastDate!.millisecondsSinceEpoch});
    }
  
    return result;
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      done: map['done']?.toInt(),
      lastDate:  map['lastDate'] is Timestamp ? map['lastDate'].toDate() : DateTime.fromMillisecondsSinceEpoch(map['lastDate'])
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl, done: $done, lastDate: $lastDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserEntity &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.photoUrl == photoUrl &&
      other.done == done &&
      other.lastDate == lastDate;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      done.hashCode ^
      lastDate.hashCode;
  }
}
