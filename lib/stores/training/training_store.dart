import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:mobx/mobx.dart';
part 'training_store.g.dart';

class TrainingStore = _TrainingStore with _$TrainingStore;

abstract class _TrainingStore with Store {

  @observable
  TrainingEntity training = TrainingEntity(
    name: "",
    exercises: []
  );

  @action
  setTraining(TrainingEntity temp) {
    training = temp;
  }

  @action
  addTraining(ExerciseEntity temp) {
    training.exercises!.add(temp);
  }
}