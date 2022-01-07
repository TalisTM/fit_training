import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fit_training/models/exercise_entity.dart';

class TrainingEntity {
  String? name;
  String? abstract;
  List<ExerciseEntity>? exercises;
  TrainingEntity({
    this.name,
    this.abstract,
    this.exercises,
  });

  TrainingEntity copyWith({
    String? name,
    String? abstract,
    List<ExerciseEntity>? exercises,
  }) {
    return TrainingEntity(
      name: name ?? this.name,
      abstract: abstract ?? this.abstract,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(abstract != null){
      result.addAll({'abstract': abstract});
    }
    if(exercises != null){
      result.addAll({'exercises': exercises!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory TrainingEntity.fromMap(Map<String, dynamic> map) {
    return TrainingEntity(
      name: map['name'],
      abstract: map['abstract'],
      exercises: map['exercises'] != null ? List<ExerciseEntity>.from(map['exercises']?.map((x) => ExerciseEntity.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingEntity.fromJson(String source) => TrainingEntity.fromMap(json.decode(source));

  @override
  String toString() => 'TrainingEntity(name: $name, abstract: $abstract, exercises: $exercises)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TrainingEntity &&
      other.name == name &&
      other.abstract == abstract &&
      listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode => name.hashCode ^ abstract.hashCode ^ exercises.hashCode;
}
