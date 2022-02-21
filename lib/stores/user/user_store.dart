import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/user_entity.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {

  @observable
  UserEntity user = UserEntity();

  @action
  setUser(UserEntity newUser) async {
    user = newUser;
    await Database.saveUser();
  }

  @action
  addDone() async {
    if(user.done != null) {
      user = user.copyWith(done: user.done! + 1);
    } else {
      user = user.copyWith(done: 1);
    }
    await Database.saveUser();
  }

  @action
  resetDone() async {
    user = user.copyWith(done: 0);
    await Database.saveUser();
  }
}