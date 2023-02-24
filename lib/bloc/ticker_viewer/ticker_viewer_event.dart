part of 'ticker_viewer_bloc.dart';

abstract class TickerViewerEvent extends Equatable {
  const TickerViewerEvent();

  @override
  List<Object> get props => [];
}

class TickerViewerSubscribeEvent extends TickerViewerEvent {}

class TickerViewerSearchEvent extends TickerViewerEvent {
  final String query;

  const TickerViewerSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
