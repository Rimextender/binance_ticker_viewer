import 'dart:async';

import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';
import 'package:binance_ticker_viewer/data/repository/ticker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticker_bloc_event.dart';
part 'ticker_bloc_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  TickerRepository repository = TickerRepository();

  TickerBloc(String base, String quote)
      : super(
          TickerInitial(
            TickerEntryModel(
              base: base,
              quote: quote,
            ),
          ),
        ) {
    on<TickerCreated>((event, emit) {
      emit.onEach<TickerEntryModel>(repository.subscribeToTicker(state.data),
          onData: (data) {
        add(TickerUpdateRecieved(data));
      });
    });
    on<TickerUpdateRecieved>((event, emit) {
      emit(TickerWithData(event.data));
    });
    add(TickerCreated());
  }
}
