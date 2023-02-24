import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

const String _apiEndpointUri = 'wss://stream.binance.com:443/ws/usdt@ticker';

class BinanceTickerDataProvider {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(_apiEndpointUri));

  Set<String> subscribedPairs = {};

  Stream getStream() => channel.stream.asBroadcastStream();

  String subscribe(String tickerName) {
    String subscribtionKey = '$tickerName@miniticker';
    subscribedPairs.add(subscribtionKey);
    Map payload = {
      "method": "SUBSCRIBE",
      "params": [subscribtionKey],
      "id": 1,
    };
    channel.sink.add(json.encode(payload));
    return subscribtionKey;
  }

  void unsubscribe(String tickerName) {
    String subscribtionKey = '$tickerName@miniticker';
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
      "params": subscribedPairs.toList(),
      "id": 1
    };
    channel.sink.add(json.encode(data));
    subscribedPairs.clear();
  }

  void closeConnection() {
    channel.sink.close();
  }
}
