import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:fit_training/models/training_entity.dart';

class UserEntity {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  int? done;
  DateTime? lastDate;
  List<TrainingEntity>? training;
  
  UserEntity({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.done,
    this.lastDate,
    this.training,
  });

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    int? done,
    DateTime? lastDate,
    List<TrainingEntity>? training,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      done: done ?? this.done,
      lastDate: lastDate ?? this.lastDate,
      training: training ?? this.training,
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
    result.addAll({'training': training?.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      done: map['done']?.toInt(),
      lastDate: map['lastDate'] is Timestamp ? map['lastDate'].toDate() : DateTime.fromMillisecondsSinceEpoch(map['lastDate']),
      training: List<TrainingEntity>.from(map['training']?.map((x) => TrainingEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl, done: $done, lastDate: $lastDate, training: $training)';
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
      other.lastDate == lastDate &&
      listEquals(other.training, training);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      done.hashCode ^
      lastDate.hashCode ^
      training.hashCode;
  }
}
