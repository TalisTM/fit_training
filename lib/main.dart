import 'package:fit_training/stores/training/training_store.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/app_widget.dart';

void main() {
  try {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<TrainingStore>(TrainingStore());
    
  } catch (e) {
    null;
  }

  runApp(const AppWidget());
}
