import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/dio/dio.dart';
import 'package:learning/modules/News/NewsApp.dart';
import 'package:learning/modules/Tasks/new_tasks.dart';
import 'package:learning/modules/archived/archived.dart';
import 'package:learning/modules/done/done.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/networking/lacal/sharedPerfrences.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var indexa = 0;
  IconData togleIcon = Icons.edit_outlined;
  bool isOpened = false;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database database;

  List<Widget> screen = [
    newTasksScreen(),
    doneTasksScreen(),
    archivedTasksScreen(),
    NewsScreen(),
  ];
  List<String> title = [
    'Tasks',
    'Done',
    'Archived',
    'NewsApp',
  ];

  void indexe(int index) {
    indexa = index;
    emit(btonNavBar());
  }

  void toggle({IconData togIcon, bool isShown}) {
    isOpened = isShown;
    togleIcon = togIcon;
    emit(togIcons());
  }

  void createDateBase() {
    openDatabase('todo.db', version: 1, onCreate: (datebase, version) {
      datebase
          .execute(
              'CREATE TABLE Tasks(id INTEGER PRIMARY KEY , time TEXT , title TEXT , date TEXT , status TEXT)')
          .then((value) {
        print('Created successfully');
      }).catchError((onError) =>
              {print('Error while Creating ${onError as String}')});
    }, onOpen: (database) {
      getDatabase(database);
      print('Database opened');
    }).then((value) {
      database = value;
      emit(createDB_State());
    });
  }

  void insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks (time  , date , title , status) VALUES ("$time","$date","$title","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(insertTODB_State());
        getDatabase(database);
        emit(getFromDB_State());
      }).catchError((onError) {
        print('Error while inserting ${onError.toString()}');
      });
      return null;
    });
  }

    void getDatabase(database)
    {
       newTasks = [];
       doneTasks = [];
       archivedTasks = [];
      database.rawQuery('SELECT * FROM Tasks').then((value) {
        value.forEach((element) {
          if(element['status'] == 'new')
            newTasks.add(element);
          else if(element['status'] == 'done')
            doneTasks.add(element);
          else archivedTasks.add(element);
        });
        emit(getFromDB_State());
      });
    }

  void updateDB({
    @required String status,
    @required int id,
  }) async {
    await database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value)
    {
      getDatabase(database);
      emit(upadteDB_State());
    });
  }
  void deleteDB({@required int id})
  {
     database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value)
     {
       getDatabase(database);
       emit(deleteDB_State());
       emit(getFromDB_State());
     });

  }
  bool isDark = false;
  void changeToDark({bool isAppear})
  {
    if(isAppear != null)
      {
        isDark = isAppear;
        emit(DarkModeState());
      }else
        {
      isDark = !isDark;
      CacheHelper.setDate(key: 'isDark', value: isDark).then((value) {
        emit(DarkModeState());
      });
       }
  }
  List <dynamic> news =[];
  void getData()
  {
    emit(LoadingNewsState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'us',
          'category':'business',
          'apiKey':'1920d52d24304e8da5ed7d321c68be2d',

        }).then((value) {
      news = value.data['articles'];
      emit(GetNewsState());
    }).catchError((onError)
    {
      print('Errrrrrrrrrror!!!!!! is ${onError}');
    });
  }
  List <dynamic> search =[];
  void searchData({value})
  {
    emit(LoadingNewsState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'q':'$value',
          'apiKey':'1920d52d24304e8da5ed7d321c68be2d',

        }).then((value) {
      search = value.data['articles'];
      emit(GetNewsState());
    }).catchError((onError)
    {
      print('Errrrrrrrrrror!!!!!! is ${onError}');
    });
  }

}
