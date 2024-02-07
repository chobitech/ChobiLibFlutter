
/*
enum ChobiSQLiteDataType {

  integer, text, real, blob;


  String getNameAndTypeString(String colName, {bool isPrimaryKey = false, bool isAutoIncrement = false,}) {
    return '$colName ${getTypeString(isPrimaryKey: isPrimaryKey, isAutoIncrement: isAutoIncrement)}';
  }

  String getTypeString({bool isPrimaryKey = false, bool isAutoIncrement = false,}) {
    String str;

    switch (this) {
      case ChobiSQLiteDataType.integer:
        str = 'INTEGER';
        break;

      case ChobiSQLiteDataType.text:
        str = 'TEXT';
        break;

      case ChobiSQLiteDataType.real:
        str = 'REAL';
        break;

      case ChobiSQLiteDataType.blob:
        str = 'BLOB';
        break;
    }

    if (isPrimaryKey) {
      str += ' PRIMARY KEY';
    }

    if (isAutoIncrement) {
      str += ' AUTOINCREMENT';
    }

    return str;
  }

}
*/
