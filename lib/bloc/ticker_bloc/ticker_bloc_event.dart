part of 'ticker_bloc.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object> get props => [];
}

class TickerCreated extends TickerEvent {}

class TickerUpdateRecieved extends TickerEvent {
  final TickerEntryModel data;

  const TickerUpdateRecieved(this.data);
}
