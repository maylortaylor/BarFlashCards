import 'package:barflashcards/models/log.dart';
import 'package:barflashcards/utils/database_constants.dart';
import 'package:intl/intl.dart';

String formatTimeStamp(DateTime timeStamp, String dateFormat) {
  return new DateFormat(dateFormat).format(timeStamp);
}

Log getLog(String transaction) {
  Log log = new Log();
  DateTime dateTime = DateTime.now();
  log.column_timestamp = dateTime.millisecondsSinceEpoch.toString();
  log.column_date = formatTimeStamp(dateTime, LogTableTransactions.DATE_FORMAT);
  log.column_transaction = transaction;
  return log;
}