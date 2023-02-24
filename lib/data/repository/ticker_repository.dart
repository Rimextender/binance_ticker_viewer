import 'package:binance_ticker_viewer/data/data_provider/binance_data_provider.dart';
import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';

class TickerRepository {
  final BinanceTickerDataProvider dataProvider = BinanceTickerDataProvider();

  Stream<TickerEntryModel> subscribeToTicker(TickerEntryModel ticker) {
    dataProvider.subscribe(ticker.name);
    return dataProvider
        .getStream()
        .where((event) => event['s'] == ticker.name)
        .map(
          (event) => ticker.copyWith(
            open: double.tryParse(event['o']) ?? 0,
            close: double.tryParse(event['o']) ?? 0,
            volume: double.tryParse(event['o']) ?? 0,
          ),
        );
  }
}
