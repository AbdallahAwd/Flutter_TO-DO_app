import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/compnents/component.dart';

class doneTasksScreen extends StatelessWidget
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

              itemBuilder: (context , index) => ListItems(cubit.doneTasks[index] , context),
              separatorBuilder: (context , index) => Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1.0,
              ),
              itemCount: cubit.doneTasks.length),
          condition: cubit.doneTasks.length > 0 ,
          fallback: (context) => whenEmpty(),
        );
      },
    );
  }
}
