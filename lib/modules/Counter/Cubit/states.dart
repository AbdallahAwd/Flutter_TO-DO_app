abstract class CounterState{}
class CounterPlusState extends CounterState
{
  final int counter;

  CounterPlusState(this.counter);
}
class CounterMinusState extends CounterState
{
  final int counter;

  CounterMinusState(this.counter);
}
class CounterBottomState extends CounterState{}