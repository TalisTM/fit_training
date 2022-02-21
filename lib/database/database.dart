import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class Database {

  static Future<void> saveUser() async {
    final userStore = GetIt.I.get<UserStore>();
    var box = await Hive.openBox("box");
    await box.put("user", userStore.user.toJson());
  }

  static Future<void> saveTraining() async {
    final trainingStore = GetIt.I.get<TrainingStore>();
    var box = await Hive.openBox("box");
    await box.put("training", trainingStore.getTraining());
  }
  
  static Future<void> loadDatas() async {
    final userStore = GetIt.I.get<UserStore>();
    final trainingStore = GetIt.I.get<TrainingStore>();

    var box = await Hive.openBox("box");

    userStore.setUser(UserEntity.fromJson(await box.get("user", defaultValue: UserEntity())));
    trainingStore.setTraining(await box.get("training", defaultValue: []));
  }

}