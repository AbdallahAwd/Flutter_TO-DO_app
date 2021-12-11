import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learning/modules/search/search.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/compnents/component.dart';

/*خلي بالك من insert
دي بتتحط عند ال validation
و بعدين .then عشان future
و تنفذ اللي عايزوا جوا then
زي ال Navigator كدا
 */

class HomeLayout extends StatefulWidget
{


  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var taskController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var ScaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

      return BlocConsumer<AppCubit , AppStates>(
        listener: (context  , state) => {
          if(state is insertTODB_State)
            {
            Navigator.pop(context)
            }
        },
        builder: (context  , state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(
                 cubit.title[cubit.indexa],
              ),
              actions: [
                IconButton(onPressed: ()
                {
                  cubit.changeToDark();
                  print(cubit.isDark);
                },
                icon: Icon(Icons.brightness_4_outlined)),

              cubit.indexa == 3 ?  IconButton(onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen() ));
              },
                    icon: Icon(Icons.search)) : Container(),

              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(floating: true,),
                SliverList(delegate: SliverChildListDelegate(
                  [
                    cubit.screen[cubit.indexa],
                  ]
                ))
              ],),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.togleIcon),
              onPressed: () {
                if (cubit.isOpened) {
                  setState(() {
                    if (formKey.currentState.validate()) {
                      cubit.insertToDatabase(
                          title: taskController.text,
                          time: timeController.text
                          , date: dateController.text);
                      taskController.text = '';
                      timeController.text = '';
                      dateController.text = '';
                    }
                  });

                }
                else {
                  cubit.toggle(isShown: true , togIcon: Icons.add);

                  ScaffoldKey.currentState.showBottomSheet((context) =>
                      Container(
                        width: double.infinity,
                        color: cubit.isDark ? Colors.grey[800] : Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              defaultTextFormFeild(
                                HintText: 'Task',

                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Task required';
                                  }
                                },
                                pre: Icons.task_alt_outlined,
                                controller: taskController,
                                KeyType: TextInputType.text,
                              ),
                              SizedBox(height: 15.0,),
                              defaultTextFormFeild(
                                  HintText: 'Time',
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Time required';
                                    }
                                  },
                                  pre: Icons.watch_later_outlined,
                                  controller: timeController,
                                  KeyType: TextInputType.text,
                                  onTab: () {
                                    showTimePicker(context: context,
                                        initialTime: TimeOfDay.now()).then((value) =>
                                    {
                                      timeController.text =
                                      value.format(context).toString()
                                    });
                                  }
                              ),
                              SizedBox(height: 15.0,),
                              defaultTextFormFeild(
                                  HintText: 'Date',
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Date required';
                                    }
                                  },
                                  pre: Icons.calendar_today_outlined,
                                  controller: dateController,
                                  KeyType: TextInputType.datetime,
                                  onTab: () {
                                    showDatePicker(context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-10-10'),
                                    ).then((value) =>
                                    {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value).toString()
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      ),
                    elevation: 60.0,
                  ).closed.then((value) {
                    cubit.toggle(isShown: false , togIcon: Icons.edit_outlined);
                  });
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.indexa,
              onTap: (index)
              {
                cubit.indexe(index);
              },
              type: BottomNavigationBarType.fixed,
              items:
              [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.new_label_sharp),
                  label: 'News',
                ),
              ],
            ),
          );
        },
      );

  }
}


