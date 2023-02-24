import 'dart:convert';

import 'package:binance_ticker_viewer/data/data_provider/binance_data_provider.dart';

import '../models/ticker_data_model.dart';

class TickerRepository {
  final BinanceTickerDataProvider dataProvider = BinanceTickerDataProvider();

  void subscribeToTicker(String name) {
    dataProvider.subscribe(name);
  }

  void unsubscribeFromTicker(String name) {
    dataProvider.unsubscribe(name);
  }

  Stream<TickerDataModel> getTickerStream(String name) {
    return dataProvider.broadcastStream
        .where((event) => event is String)
        .map((event) => jsonDecode(event))
        .where((event) => (event.containsKey('s')
            ? (event['s'] ?? '')
                .toString()
                .toLowerCase()
                .contains(name.toLowerCase())
            : false))
        .map<TickerDataModel>((event) => TickerDataModel.fromJson(event));
  }

  void dispose() {
    dataProvider.unsubscribeFromAll();
    dataProvider.closeConnection();
  }
}
