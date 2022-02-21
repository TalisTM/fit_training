// import 'package:fit_training/models/exercise_entity.dart';
// import 'package:fit_training/models/training_entity.dart';
// import 'package:mobx/mobx.dart';
// part 'training_store.g.dart';

// class TrainingStore = _TrainingStore with _$TrainingStore;

// abstract class _TrainingStore with Store {

//   @observable
//   TrainingEntity training = TrainingEntity(
//     name: "",
//     abstract: "",
//     exercises: ObservableList()
//   );

//   @action
//   clear() {
//     training = TrainingEntity(
//       name: "",
//       exercises: ObservableList()
//     );
//   }

//   @action
//   setTraining(TrainingEntity temp) {
//     training = temp;
//   }

//   @action
//   setName(String temp) {
//     training.name = temp;
//   }

//   @action
//   setAbstract(String temp) {
//     training.abstract = temp;
//   }
  
//   @action
//   addExercise(ExerciseEntity temp) {
//     training.exercises!.add(temp);
//   }

//   @action
//   editExercise(ExerciseEntity temp, index) {
//     training.exercises![index] = temp;
//   }

//   @action
//   removeExercise(int index) {
//     training.exercises!.removeAt(index);
//   }
// }

import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:mobx/mobx.dart';
part 'training_store.g.dart';

class TrainingStore = _TrainingStore with _$TrainingStore;

abstract class _TrainingStore with Store {

  @observable
  List<TrainingEntity> training = ObservableList();

  @action
  add(TrainingEntity temp) async {
    training.add(temp);
    await Database.saveTraining();
  }

  @action
  delete(int index) async {
    training.removeAt(index);
    await Database.saveTraining();
  }
  
  @action
  edit(TrainingEntity temp, index) async {
    training[index] = temp;
    await Database.saveTraining();
  }

  getTraining() {
    List listTraining = [];
    for (TrainingEntity t in training) {
      listTraining.add(t.toJson());
    }
    return listTraining;
  }

  @action
  setTraining(temp) {
    training.clear();
    for (var t in temp) {
      training.add(TrainingEntity.fromJson(t));
    }
  }
}