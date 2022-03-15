import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training/database/database.dart';
import 'package:fit_training/models/training_entity.dart';
import 'package:fit_training/models/user_entity.dart';
import 'package:fit_training/utils/is_logged.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {

  //INSTANCIA DA ENDIDADE DO USUARIO
  @observable
  UserEntity user = UserEntity(
    training: ObservableList()
  );

  //SALVAR USUARIO
  @action
  setUser(UserEntity newUser) async {
    user = newUser;
    await Database.save();
  }

  //ADICIONAR MAIS UM NO CONTADOR DE TREINOS FEITOS
  @action
  addDone() async {
    if(user.done != null) {
      user = user.copyWith(done: user.done! + 1);
    } else {
      user = user.copyWith(done: 1);
    }
    await Database.save();
    saveFirebase();
  }

  //RESETAR O NUMERO DE TREINOS FEITOS
  @action
  resetDone() async {
    user = user.copyWith(done: 0);
    await Database.save();
    saveFirebase();
  }

  //ADICIONAR UM NOVO TREINO
  @action
  addTraining(TrainingEntity temp) async {
    user.training?.add(temp);
    await Database.save();
    saveFirebase();
  }

  //DELETAR UM TREINO EXISTENTE
  @action
  deleteTraining(int index) async {
    user.training?.removeAt(index);
    await Database.save();
    saveFirebase();
  }
  
  //EDITAR UM TREINO EXISTENTE
  @action
  editTraining(TrainingEntity temp, index) async {
    user.training?[index] = temp;
    await Database.save();
    saveFirebase();
  }

  
  //SALVAR OS DADOS NO FIREBASE
  Future<void> saveFirebase() async {
    user.lastDate = DateTime.now();
    await FirebaseFirestore.instance.collection("user").doc(user.uid).update(user.toMap());
  }

  //CARREGAR OS DADOS DO FIREBASE
  Future<void> loadFirebase(Map<String, dynamic> data) async {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(data["lastDate"]);
    if(!date.isAtSameMomentAs(user.lastDate!)) { //SE FOR DIFERENTE A DATA
      if(!isLogged() || date.isAfter(user.lastDate!)) { //CASO DA DATA RECEBIDA SER MAIS ATUAL OU USUARIO NÃO ESTEJA LOGADO
        setUser(UserEntity.fromMap(data));
      } else { //CASO A DATA RECEBIDA SEJA MAIS ANTIGA | IRÁ SALVAR OS DADOS NO FIREBASE
        await saveFirebase();
      }
    }
  }
}