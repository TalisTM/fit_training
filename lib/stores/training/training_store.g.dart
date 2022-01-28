// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrainingStore on _TrainingStore, Store {
  final _$trainingAtom = Atom(name: '_TrainingStore.training');

  @override
  TrainingEntity get training {
    _$trainingAtom.reportRead();
    return super.training;
  }

  @override
  set training(TrainingEntity value) {
    _$trainingAtom.reportWrite(value, super.training, () {
      super.training = value;
    });
  }

  final _$_TrainingStoreActionController =
      ActionController(name: '_TrainingStore');

  @override
  dynamic clear() {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.clear');
    try {
      return super.clear();
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTraining(TrainingEntity temp) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.setTraining');
    try {
      return super.setTraining(temp);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setName(String temp) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.setName');
    try {
      return super.setName(temp);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAbstract(String temp) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.setAbstract');
    try {
      return super.setAbstract(temp);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addExercise(ExerciseEntity temp) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.addExercise');
    try {
      return super.addExercise(temp);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editExercise(ExerciseEntity temp, dynamic index) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.editExercise');
    try {
      return super.editExercise(temp, index);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeExercise(int index) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.removeExercise');
    try {
      return super.removeExercise(index);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
training: ${training}
    ''';
  }
}
