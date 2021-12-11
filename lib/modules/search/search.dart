import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:learning/shared/compnents/component.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: defaultTextFormFeild(
                controller: controller,
                pre: Icons.search,
                HintText: 'Search',
                KeyType: TextInputType.text,
                onSubmit: (value)
                {
                  AppCubit.get(context).searchData(value: value);
                }
            ),
          ),
          body: ListCubitBuilder(cubit , isSearch: true),
        );
      },
    );
  }
}
