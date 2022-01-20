import 'dart:convert';

class ExerciseEntity {
  String? name;
  int? serie;
  String? repeat;
  bool? check;
  String? weight;
  
  ExerciseEntity({
    this.name,
    this.serie,
    this.repeat,
    this.check,
    this.weight,
  });

  ExerciseEntity copyWith({
    String? name,
    int? serie,
    String? repeat,
    bool? check,
    String? weight,
  }) {
    return ExerciseEntity(
      name: name ?? this.name,
      serie: serie ?? this.serie,
      repeat: repeat ?? this.repeat,
      check: check ?? this.check,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(serie != null){
      result.addAll({'serie': serie});
    }
    if(repeat != null){
      result.addAll({'repeat': repeat});
    }
    if(check != null){
      result.addAll({'check': check});
    }
    if(weight != null){
      result.addAll({'weight': weight});
    }
  
    return result;
  }

  factory ExerciseEntity.fromMap(Map<String, dynamic> map) {
    return ExerciseEntity(
      name: map['name'],
      serie: map['serie']?.toInt(),
      repeat: map['repeat'],
      check: map['check'],
      weight: map['weight'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseEntity.fromJson(String source) => ExerciseEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExerciseEntity(name: $name, serie: $serie, repeat: $repeat, check: $check, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExerciseEntity &&
      other.name == name &&
      other.serie == serie &&
      other.repeat == repeat &&
      other.check == check &&
      other.weight == weight;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      serie.hashCode ^
      repeat.hashCode ^
      check.hashCode ^
      weight.hashCode;
  }
}
