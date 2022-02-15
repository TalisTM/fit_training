// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrainingStore on _TrainingStore, Store {
  final _$trainingAtom = Atom(name: '_TrainingStore.training');

  @override
  List<TrainingEntity> get training {
    _$trainingAtom.reportRead();
    return super.training;
  }

  @override
  set training(List<TrainingEntity> value) {
    _$trainingAtom.reportWrite(value, super.training, () {
      super.training = value;
    });
  }

  final _$_TrainingStoreActionController =
      ActionController(name: '_TrainingStore');

  @override
  dynamic add(TrainingEntity temp) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.add');
    try {
      return super.add(temp);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic delete(int index) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.delete');
    try {
      return super.delete(index);
    } finally {
      _$_TrainingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic edit(TrainingEntity temp, dynamic index) {
    final _$actionInfo = _$_TrainingStoreActionController.startAction(
        name: '_TrainingStore.edit');
    try {
      return super.edit(temp, index);
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
