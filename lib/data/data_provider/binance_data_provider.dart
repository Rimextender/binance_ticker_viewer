import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

const String _apiEndpointUri = 'wss://stream.binance.com:443/ws/usdt@ticker';

class BinanceTickerDataProvider {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(_apiEndpointUri));
  late final Stream broadcastStream;

  BinanceTickerDataProvider() {
    broadcastStream = channel.stream.asBroadcastStream(
      onCancel: (sub) => sub.cancel(),
    );
  }

  Set<String> subscribedPairs = {};

  Future<void> subscribe(String tickerName) async {
    String subscribtionKey = '$tickerName@miniTicker';
    subscribedPairs.add(subscribtionKey);
    Map payload = {
      "method": "SUBSCRIBE",
      "params": [subscribtionKey],
      "id": 1,
    };
    channel.sink.add(json.encode(payload));
  }

  void unsubscribe(String tickerName) {
    String subscribtionKey = '$tickerName@miniTicker';
    Map data = {
      "method": "UNSUBSCRIBE",
      "params": [subscribtionKey],
      "id": 1
    };
    channel.sink.add(json.encode(data));
    subscribedPairs.remove(subscribtionKey);
  }

  void unsubscribeFromAll() {
    Map data = {
      "method": "UNSUBSCRIBE",
      "params": subscribedPairs.map((e) => '$e@miniTicker').toList(),
      "id": 1
    };
    channel.sink.add(json.encode(data));
    subscribedPairs.clear();
  }

  void closeConnection() {
    channel.sink.close();
  }
}
