import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

const String _apiEndpointUri = 'wss://stream.binance.com:443/ws/usdt@ticker';

class BinanceTickerDataProvider {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(_apiEndpointUri));

  Set<String> subscribedPairs = {};

  Stream getStream() =>
      channel.stream.map((event) => jsonDecode(event)).asBroadcastStream();

  String subscribe(String tickerName) {
    String subscribtionKey = '$tickerName@miniTicker';
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
