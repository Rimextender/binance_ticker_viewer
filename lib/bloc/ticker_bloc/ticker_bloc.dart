import 'package:binance_ticker_viewer/data/models/ticker_data_model.dart';
import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';
import 'package:binance_ticker_viewer/data/repository/ticker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticker_bloc_event.dart';
part 'ticker_bloc_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final TickerRepository repository;

  TickerBloc(String base, String quote, this.repository)
      : super(
          TickerInitial(
            TickerEntryModel(base: base, quote: quote, hasData: false),
          ),
        ) {
    on<TickerCreated>((event, emit) async {
      await emit.onEach<TickerDataModel>(
        repository.getTickerStream(state.data.name),
        onData: (data) {
          add(TickerUpdateRecieved(data));
        },
      );
    });
    on<TickerUpdateRecieved>((event, emit) {
      emit(TickerWithData(
        state.data.copyWith(
          open: event.data.openPrice,
          close: event.data.closePrice,
          volume: event.data.totalTradedBaseAssetVolume,
          hasData: true,
        ),
      ));
    });
    add(TickerCreated());
  }
}
