class DrinksTable {
  static String TABLE_NAME = "Drinks";
  static String ID = "id";
  static String NAME = "name";
  static String DESCRIPTION = "description";
  static String DATE_ADDED = "dateAdded";
  static String CATEGORY = "category";
}

class LogsTable {
  static String TABLE_NAME = "Logs";
  static String COLUMN_TRANSACTION = "column_transaction";
  static String COLUMN_TIMESTAMP = "column_timestamp";
  static String COLUMN_DATE = "column_date";
}

class LogTableTransactions {
  static const String READING_DRINKS =
      "Reading All the Drinks Available In Database.";
  static const String CREATING_DRINK =
      "A New Drink is Being Inserted in Drinks Table.";
  static const String READING_DELETED_DRINKS =
      "Reading all the Deleted Drinks from Database.";
  static const String CREATING_DELETED_DRINK =
      "Creating a Drink in Deleted Drinks Table.";
  static const String UPDATING_DRINK = "Updating a Drink in Database.";
  static const String DELETING_DRINK = "Deleting a Drink from Database.";
  static const String SEARCHING_DRINK = "Searching a Drink in Database.";
  static const String DATE_FORMAT = "MM/dd/yyyy kk:mm:s a";
}

// TABLE QUERIES
class CreateTableQueries {
  static String CREATE_DRINKS_TABLE = "CREATE TABLE " +
      DrinksTable.TABLE_NAME +
      "(" +
      DrinksTable.ID +
      " INTEGER PRIMARY KEY AUTOINCREMENT," +
      DrinksTable.NAME +
      " TEXT NOT NULL," +
      DrinksTable.DESCRIPTION +
      " TEXT NOT NULL," +
      DrinksTable.DATE_ADDED +
      " TEXT NOT NULL," +
      DrinksTable.CATEGORY +
      " TEXT NOT NULL);";

  static String CREATE_LOGS_TABLE = "CREATE TABLE " +
      LogsTable.TABLE_NAME +
      "(" +
      LogsTable.COLUMN_TIMESTAMP +
      " TEXT NOT NULL," +
      LogsTable.COLUMN_TRANSACTION +
      " TEXT NOT NULL," +
      LogsTable.COLUMN_DATE +
      " TEXT NOT NULL);";
}
