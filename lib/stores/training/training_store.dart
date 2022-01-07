import 'package:fit_training/models/exercise_entity.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:mobx/mobx.dart';
part 'training_store.g.dart';

class TrainingStore = _TrainingStore with _$TrainingStore;

abstract class _TrainingStore with Store {

  @observable
  TrainingEntity training = TrainingEntity(
    name: "",
    abstract: "",
    exercises: ObservableList()
  );

  @action
  clear() {
    training = TrainingEntity(
      name: "",
      exercises: ObservableList()
    );
  }

  @action
  setTraining(TrainingEntity temp) {
    training = temp;
  }

  @action
  setName(String temp) {
    training.name = temp;
  }

  @action
  setAbstract(String temp) {
    training.abstract = temp;
  }
  
  @action
  addExercise(ExerciseEntity temp) {
    training.exercises!.add(temp);
  }

  @action
  editExercise(ExerciseEntity temp, index) {
    training.exercises![index] = temp;
  }

  @action
  removeExercise(int index) {
    training.exercises!.removeAt(index);
  }
}