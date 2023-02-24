import 'package:equatable/equatable.dart';

class TickerEntryModel extends Equatable {
  final String base;
  final String quote;
  final double open;
  final double close;
  final double volume;
  final bool isHidden;

  double get volumeopen => volume * close;
  double get change => (close - open) / open * 100;
  String get name => '$base$quote'.toLowerCase();

  const TickerEntryModel({
    required this.base,
    required this.quote,
    this.open = 0,
    this.volume = 0,
    this.close = 0,
    this.isHidden = false,
  });

  @override
  List<Object?> get props => [base, quote, open, volume, close];

  TickerEntryModel copyWith({
    String? base,
    String? quote,
    double? open,
    double? close,
    double? volume,
    bool? isHidden,
  }) {
    return TickerEntryModel(
      base: base ?? this.base,
      quote: quote ?? this.quote,
      open: open ?? this.open,
      close: close ?? this.close,
      volume: volume ?? this.volume,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
