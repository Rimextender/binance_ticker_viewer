part of 'ticker_viewer_bloc.dart';

abstract class TickerViewerState extends Equatable {
  const TickerViewerState(this.symbols);
  final Set<String> symbols;

  @override
  List<Object> get props => [symbols];
}

class TickerViewerInitial extends TickerViewerState {
  const TickerViewerInitial(super.symbols);
}

class TickerViewerSubscribedState extends TickerViewerState {
  const TickerViewerSubscribedState(super.symbols);
}

class TickerViewerFilteredState extends TickerViewerState {
  const TickerViewerFilteredState(super.symbols, this.query);

  final String query;

  @override
  List<Object> get props => [symbols, query];
}

class TickerViewerErrorState extends TickerViewerState {
  const TickerViewerErrorState(super.symbols);
}
