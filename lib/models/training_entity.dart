import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fit_training/models/exercise_entity.dart';

class TrainingEntity {
  String? name;
  List<ExerciseEntity>? exercises;
  TrainingEntity({
    this.name,
    this.exercises,
  });

  TrainingEntity copyWith({
    String? name,
    List<ExerciseEntity>? exercises,
  }) {
    return TrainingEntity(
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
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
      name: map['name'],
      exercises: map['exercises'] != null ? List<ExerciseEntity>.from(map['exercises']?.map((x) => ExerciseEntity.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingEntity.fromJson(String source) => TrainingEntity.fromMap(json.decode(source));

  @override
  String toString() => 'TrainingEntity(name: $name, exercises: $exercises)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TrainingEntity &&
      other.name == name &&
      listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode => name.hashCode ^ exercises.hashCode;
}
