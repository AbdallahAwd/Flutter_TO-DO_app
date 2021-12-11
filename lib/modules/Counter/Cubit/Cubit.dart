import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/Counter/Cubit/states.dart';

class CounterCubit extends Cubit<CounterState>
{
  CounterCubit() : super(CounterBottomState());
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;
  void Minus()
  {
    counter-=10;
    emit(CounterMinusState(counter));
  } void Plus()
  {
    counter+=10;
    emit(CounterPlusState(counter));
  } void Bottom()
  {
    counter = 0;
    emit(CounterBottomState());
  }

}