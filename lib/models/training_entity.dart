import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fit_training/models/exercise_entity.dart';

class TrainingEntity {
  String? id;
  String? name;
  List<ExerciseEntity>? exercises;
  TrainingEntity({
    this.id,
    this.name,
    this.exercises,
  });

  TrainingEntity copyWith({
    String? id,
    String? name,
    List<ExerciseEntity>? exercises,
  }) {
    return TrainingEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(exercises != null){
      result.addAll({'exercises': exercises!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory TrainingEntity.fromMap(Map<String, dynamic> map) {
    return TrainingEntity(
      id: map['id'],
      name: map['name'],
      exercises: map['exercises'] != null ? List<ExerciseEntity>.from(map['exercises']?.map((x) => ExerciseEntity.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingEntity.fromJson(String source) => TrainingEntity.fromMap(json.decode(source));

  @override
  String toString() => 'TrainingEntity(id: $id, name: $name, exercises: $exercises)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TrainingEntity &&
      other.id == id &&
      other.name == name &&
      listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ exercises.hashCode;
}
