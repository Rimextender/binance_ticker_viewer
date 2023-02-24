class TickerDataModel {
  final String eventType;
  final String symbol;
  final int eventTime;
  final double closePrice;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double totalTradedBaseAssetVolume;
  final double totalTradedQuoteAssetVolume;

  TickerDataModel({
    required this.eventType,
    required this.symbol,
    required this.eventTime,
    required this.closePrice,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.totalTradedBaseAssetVolume,
    required this.totalTradedQuoteAssetVolume,
  });

  factory TickerDataModel.fromJson(Map json) {
    return TickerDataModel(
      eventType: json["e"] ?? '',
      eventTime: json["E"] ?? 0,
      symbol: json["s"] ?? '',
      closePrice: double.tryParse(json["c"]) ?? 0,
      openPrice: double.tryParse(json["o"]) ?? 0,
      highPrice: double.tryParse(json["h"]) ?? 0,
      lowPrice: double.tryParse(json["l"]) ?? 0,
      totalTradedBaseAssetVolume: double.tryParse(json["v"]) ?? 0,
      totalTradedQuoteAssetVolume: double.tryParse(json["q"]) ?? 0,
    );
  }
}
