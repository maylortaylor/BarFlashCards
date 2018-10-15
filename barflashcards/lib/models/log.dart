import 'dart:async';

import 'package:barflashcards/utils/database_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable()
class Log extends Object with _$LogSerializerMixin {
  String column_timestamp;
  String column_transaction;
  String column_date;

  Log({this.column_timestamp, this.column_transaction, this.column_date});

  static Future<List<Log>> fromLogsJson(List<dynamic> json) async {
    List<Log> logs = new List<Log>();
    for (var log in json) {
      logs.add(new Log(
        column_timestamp: log['column_timestamp'],
        column_transaction: log['column_transaction'],
        column_date: log['column_date'],
      ));
    }
    return logs;
  }

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map toMap() {
    Map<String, dynamic> contactMap = <String, dynamic>{
      LogsTable.COLUMN_TIMESTAMP: column_timestamp,
      LogsTable.COLUMN_DATE: column_date,
      LogsTable.COLUMN_TRANSACTION: column_transaction,
    };

    return contactMap;
  }

  static Log fromMap(Map map) {
    return new Log(
      column_timestamp: map[LogsTable.COLUMN_TIMESTAMP],
      column_date: map[LogsTable.COLUMN_DATE],
      column_transaction: map[LogsTable.COLUMN_TRANSACTION],
    );
  }
}