import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  
  static String format(
    double amount, {
    String locale = 'en_US',
    String symbol = '\$',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
    );

    return formatter.format(amount);
  }

  
  static String formatNumber(
    double amount, {
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(amount);
  }

  
  static String formatSigned(
    double amount, {
    String locale = 'en_US',
    String symbol = '\$',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
    );

    return amount >= 0
        ? '+ ${formatter.format(amount)}'
        : '- ${formatter.format(amount.abs())}';
  }
}
