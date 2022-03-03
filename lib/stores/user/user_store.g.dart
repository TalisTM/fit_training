// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  UserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$setUserAsyncAction = AsyncAction('_UserStore.setUser');

  @override
  Future setUser(UserEntity newUser) {
    return _$setUserAsyncAction.run(() => super.setUser(newUser));
  }

  final _$addDoneAsyncAction = AsyncAction('_UserStore.addDone');

  @override
  Future addDone() {
    return _$addDoneAsyncAction.run(() => super.addDone());
  }

  final _$resetDoneAsyncAction = AsyncAction('_UserStore.resetDone');

  @override
  Future resetDone() {
    return _$resetDoneAsyncAction.run(() => super.resetDone());
  }

  final _$addTrainingAsyncAction = AsyncAction('_UserStore.addTraining');

  @override
  Future addTraining(TrainingEntity temp) {
    return _$addTrainingAsyncAction.run(() => super.addTraining(temp));
  }

  final _$deleteTrainingAsyncAction = AsyncAction('_UserStore.deleteTraining');

  @override
  Future deleteTraining(int index) {
    return _$deleteTrainingAsyncAction.run(() => super.deleteTraining(index));
  }

  final _$editTrainingAsyncAction = AsyncAction('_UserStore.editTraining');

  @override
  Future editTraining(TrainingEntity temp, dynamic index) {
    return _$editTrainingAsyncAction.run(() => super.editTraining(temp, index));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
