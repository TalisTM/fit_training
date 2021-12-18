import 'package:fit_training/stores/user/user_store.dart';
import 'package:get_it/get_it.dart';

bool isLogged() {
  final userStore = GetIt.I.get<UserStore>();

  if(userStore.user.name != null && userStore.user.name!.isNotEmpty) {
    return true;
  }
  return false;
}