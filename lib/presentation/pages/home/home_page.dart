import 'package:fit_training/presentation/pages/home/widgets/training_tile.dart';
import 'package:fit_training/presentation/pages/home/widgets/zoom_container.dart';
import 'package:fit_training/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'widgets/app_bar_home.dart';
import 'package:animated_card/animated_card.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final userStore = GetIt.I.get<UserStore>();

  late final AnimationController _animatedContainer;

  bool isDarkMode = false;
  
  @override
  void initState() {
    super.initState();

    var brightness = SchedulerBinding.instance?.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;

    _animatedContainer = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))..forward();
  }

  @override
  void dispose() {
    _animatedContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: const AppBarHome(),
          body: Observer(
            builder: (context) {
              if(userStore.user.training!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Nenhum treino cadastrado",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ); 
              } else {
                return AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  duration: const Duration(milliseconds: 400),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: userStore.user.training!.length,
                    itemBuilder: (context, index) {
                      return TrainingTile(userStore.user.training![index]);
                    },
                  ),
                );
              }
            },
          ),
        ),
        IgnorePointer(
          child: ZoomContainer(controller: _animatedContainer, isDarkMode: isDarkMode)
        )
      ],
    );
  }
}