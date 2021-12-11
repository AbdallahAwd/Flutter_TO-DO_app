import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:sqflite/sqflite.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/states.dart';



class Counters extends StatelessWidget {

  Database databasee;
  List<Map> counters = [];
  @override
  Widget build(BuildContext context) {


          return  BlocProvider(
            create: (BuildContext context) => CounterCubit(),
            child: BlocConsumer<CounterCubit ,CounterState >(
              listener: (context , state) =>
              {
                if(state is CounterMinusState) print('Counter Minus State ${state.counter}'),
                if(state is CounterPlusState) print('Counter Plus State ${state.counter}'),
              },
              builder: (context , state) =>  Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber,
                  title: Text(
                    'سبح يابني',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  centerTitle: true,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: ()
                        {
                          CounterCubit.get(context).Minus();
                        },
                          child: Text   (
                            '10 -',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                              color: Colors.amber,
                            ),
                          ),),
                        SizedBox(width: 33.0,),
                        Text('${CounterCubit.get(context).counter}',
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 33.0,),
                        TextButton(onPressed: ()
                        {
                          CounterCubit.get(context).Plus();
                        },
                          child: Text(
                            '+ 10',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                              color: Colors.amber,
                            ),
                          ),),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Container(
                      decoration:BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(30.0),
                      ) ,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: MaterialButton(onPressed: ()
                      {
                        CounterCubit.get(context).Bottom();
                      },
                        child: Text(
                          'Back Default',
                        ),

                      ),
                    ),
                  ],
                ),

              ),

            ),
          );
  }

  }
