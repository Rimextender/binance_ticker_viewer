import 'dart:async';

import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/ticker_repository.dart';

part 'ticker_viewer_event.dart';
part 'ticker_viewer_state.dart';

class TickerViewerBloc extends Bloc<TickerViewerEvent, TickerViewerState> {
  TickerRepository repository = TickerRepository();

  TickerViewerBloc(Set<String> symbols) : super(TickerViewerInitial(symbols)) {
    on<TickerViewerSearchEvent>(
      (event, emit) {
        if (event.query.isEmpty) {
          emit(TickerViewerSubscribedState(state.symbols));
        } else {
          emit(
            TickerViewerFilteredState(
              state.symbols,
              event.query,
            ),
          );
        }
      },
    );
  }
}
