import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) => DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
