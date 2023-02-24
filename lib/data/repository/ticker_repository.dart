import 'dart:convert';

import 'package:binance_ticker_viewer/data/data_provider/binance_data_provider.dart';
import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';

import '../models/ticker_data_model.dart';

class TickerRepository {
  final BinanceTickerDataProvider dataProvider = BinanceTickerDataProvider();

  void subscribeToTicker(String name) {
    dataProvider.subscribe(name);
  }

  Stream<TickerDataModel> getTickerStream(String name) {
    return dataProvider.getStream().where((event) {
      return event.containsKey('s') ? event['s'].toLowerCase() == name : false;
    }).map((event) => TickerDataModel.fromJson(event));
  }
}
