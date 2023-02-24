part of 'ticker_viewer_bloc.dart';

abstract class TickerViewerEvent extends Equatable {
  const TickerViewerEvent();

  @override
  List<Object> get props => [];
}

class TickerViewerSubscribeEvent extends TickerViewerEvent {
  final Set<String> symbols;

  const TickerViewerSubscribeEvent(this.symbols);

  @override
  List<Object> get props => [symbols];
}

class TickerViewerSearchEvent extends TickerViewerEvent {
  final String query;

  const TickerViewerSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
