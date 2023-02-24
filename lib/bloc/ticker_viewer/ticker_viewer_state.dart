part of 'ticker_viewer_bloc.dart';

abstract class TickerViewerState extends Equatable {
  const TickerViewerState(this.symbols);
  final Set<String> symbols;

  @override
  List<Object> get props => [];
}

class TickerViewerInitial extends TickerViewerState {
  const TickerViewerInitial(super.symbols);
}

class TickerViewerSubscribedState extends TickerViewerState {
  const TickerViewerSubscribedState(super.symbols);
}

class TickerViewerFilteredState extends TickerViewerState {
  const TickerViewerFilteredState(super.symbols, this.filteredSymbols);

  final Set<String> filteredSymbols;
}

class TickerViewerErrorState extends TickerViewerState {
  const TickerViewerErrorState(super.symbols);
}
