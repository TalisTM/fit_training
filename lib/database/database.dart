import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class Database {

  //SALVAR OS DANOS NO BANCO LOCAL
  static Future<void> save() async {
    final userStore = GetIt.I.get<UserStore>();
    var box = await Hive.openBox("box");
    await box.put("user", userStore.user.toJson());
  }

  //CARREGAR OS DADOS DO BANCO LOCAL
  static Future<void> load() async {
    final userStore = GetIt.I.get<UserStore>();
    
    var box = await Hive.openBox("box");

    try {
      await userStore.setUser(UserEntity.fromJson(await box.get("user", defaultValue: UserEntity().toJson())));
    } catch (e) {
      null;
    }
  }

}