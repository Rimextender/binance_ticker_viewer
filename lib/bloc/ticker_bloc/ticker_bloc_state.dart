part of 'ticker_bloc.dart';

abstract class TickerState extends Equatable {
  const TickerState(this.data);
  final TickerEntryModel data;

  @override
  List<Object> get props => [data];
}

class TickerInitial extends TickerState {
  const TickerInitial(super.data);
}

class TickerWithData extends TickerState {
  const TickerWithData(super.data);
}
