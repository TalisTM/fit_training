// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fit_training/database/database.dart';
// import 'package:fit_training/models/training_entity.dart';
// import 'package:fit_training/stores/user/user_store.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mobx/mobx.dart';
// part 'training_store.g.dart';

// class TrainingStore = _TrainingStore with _$TrainingStore;

// abstract class _TrainingStore with Store {

//   final userStore = GetIt.I.get<UserStore>();

//   Future<void> saveFirebase() async {
//     userStore.user.lastDate = DateTime.now();
//     await FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).update(
//       {
//         "training": getTraining(),
//         "lastDate": userStore.user.lastDate
//       }
//     );
//   }

//   Future<void> loadFirebase() async {
//     await FirebaseFirestore.instance.collection("user").doc(userStore.user.uid).get().then((user) async {
//       DateTime date = user.data()!["lastDate"].toDate();
//       print(date.isAfter(userStore.user.lastDate!));
//         if(date.isAfter(userStore.user.lastDate!)) {
//           print(user.data()!["training"]);
//           setTraining(user.data()!["training"]);
//           userStore.user.lastDate = date;
//           await Database.saveTraining();
//         } else {
//           await saveFirebase();
//         }
//     });
//   }

//   @observable
//   List<TrainingEntity> training = ObservableList();

//   @action
//   add(TrainingEntity temp) async {
//     training.add(temp);
//     await Database.saveTraining();
//     saveFirebase();
//   }

//   @action
//   delete(int index) async {
//     training.removeAt(index);
//     await Database.saveTraining();
//     saveFirebase();
//   }
  
//   @action
//   edit(TrainingEntity temp, index) async {
//     training[index] = temp;
//     await Database.saveTraining();
//     saveFirebase();
//   }

//   getTraining() {
//     List listTraining = [];
//     for (TrainingEntity t in training) {
//       listTraining.add(t.toJson());
//     }
//     return listTraining;
//   }

//   @action
//   setTraining(temp) {
//     training.clear();
//     for (var t in temp) {
//       training.add(TrainingEntity.fromJson(t));
//     }
//   }
// }