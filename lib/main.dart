import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/dio/dio.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/networking/lacal/sharedPerfrences.dart';

import 'layout/Home.dart';
import 'shared/block_observer.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getDate(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDateBase()..changeToDark(isAppear: isDark)..getData()..searchData(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 20.0,
                ),
                actionsIconTheme: IconThemeData(
                    color: Colors.white,
                    size: 30.0
                ),
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
              ),
            ),
            darkTheme:ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 20.0,
                ),
                actionsIconTheme: IconThemeData(
                    color: Colors.white,
                    size: 30.0
                ),
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.grey[800]
              ),
              textTheme:TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                ),bodyText2: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              ) ,
            ) ,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
