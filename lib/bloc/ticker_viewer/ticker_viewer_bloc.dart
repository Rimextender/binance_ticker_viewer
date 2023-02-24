import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/ticker_repository.dart';

part 'ticker_viewer_event.dart';
part 'ticker_viewer_state.dart';

const String quote = 'usdt';

class TickerViewerBloc extends Bloc<TickerViewerEvent, TickerViewerState> {
  final TickerRepository repository;

  TickerViewerBloc(Set<String> symbols, this.repository)
      : super(TickerViewerInitial(symbols)) {
    on<TickerViewerCreatedEvent>(
      (event, emit) {
        for (var symbol in symbols) {
          repository.subscribeToTicker('$symbol$quote'.toLowerCase());
        }
      },
    );
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
    add(const TickerViewerCreatedEvent());
  }
}
