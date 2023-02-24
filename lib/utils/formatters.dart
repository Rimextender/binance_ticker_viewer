import 'dart:math';

import 'package:intl/intl.dart';

enum NumberFormatOrders {
  n(1),
  k(1000),
  m(1000000);

  const NumberFormatOrders(this.value);
  final num value;
}

abstract class Formatters {
  static String largeNumToShortString(num number, {int decimals = 2}) {
    String result = '';
    int numberLength = number.floor().toString().length;
    NumberFormatOrders order = NumberFormatOrders.values[
        ((numberLength - 1) ~/ 3)
            .clamp(0, NumberFormatOrders.values.length - 1)];
    if (order == NumberFormatOrders.n) {
      result =
          (number / order.value).toStringAsFixed(decimals).replaceAll('.', ',');
    } else {
      number = number / order.value;
      int wholeNumber = number.floor();
      double fraction = (number - number.floor()).toDouble();
      String wholeNumberPart, fractionalPart;
      wholeNumberPart = wholeNumber.toString().substring(0, numberLength % 3) +
          wholeNumber
              .toString()
              .substring(numberLength % 3)
              .replaceAllMapped(RegExp('\\d{3}'), (match) => ' ${match[0]}');
      fractionalPart = (fraction * pow(10, decimals))
          .round()
          .toString()
          .padRight(decimals, '0');
      result =
          '${wholeNumberPart.trim()},$fractionalPart${order.name.toUpperCase()}';
    }
    return result;
  }

  static String displayChange(num number, {int decimals = 2}) {
    final String prefix = number > 0
        ? '+'
        : number < 0
            ? '-'
            : ' ';
    final String formattedNumber =
        number.toStringAsFixed(decimals).replaceAll('.', ',');
    return '$prefix$formattedNumber %';
  }

  static String displayPrice(num number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals).replaceAll('.', ',');
  }
}
