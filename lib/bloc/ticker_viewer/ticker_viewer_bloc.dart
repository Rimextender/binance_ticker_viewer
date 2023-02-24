import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticker_viewer_event.dart';
part 'ticker_viewer_state.dart';

class TickerViewerBloc extends Bloc<TickerViewerEvent, TickerViewerState> {
  TickerViewerBloc(Set<String> symbols) : super(TickerViewerInitial(symbols)) {
    add(TickerViewerSubscribeEvent());
  }

  @override
  Stream<TickerViewerState> mapEventToState(
    TickerViewerEvent event,
  ) async* {
    on<TickerViewerSubscribeEvent>((event, emit) => null);
  }
}
