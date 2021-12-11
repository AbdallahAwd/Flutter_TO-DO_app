import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/compnents/component.dart';

class newTasksScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => ListView.separated(

              itemBuilder: (context , index) => ListItems(cubit.newTasks[index] , context),
              separatorBuilder: (context , index) => Divider(height: 1,endIndent: 20.0,indent: 20.0,color: Colors.grey,),
              itemCount: cubit.newTasks.length),
          condition: cubit.newTasks.length > 0 ,
          fallback: (context) => whenEmpty(),
        );
      },
    );
  }
}
