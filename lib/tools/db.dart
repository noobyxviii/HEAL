import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

dynamic readDB() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "appData.db");
  Database database = await openDatabase(path);
  List<Map<String, Object?>> result =
      await database.rawQuery("SELECT * FROM USER");
  return result;
}

void updateDB(value, newValue) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "appData.db");
  Database database = await openDatabase(path);
  database.rawUpdate("UPDATE USER SET $value = ?", [newValue]);
}

void deleteJournal(index) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "appData.db");
  Database database = await openDatabase(path);
  database.execute("ALTER TABLE USER DROP COLUMN journal${index + 1}");
}

void addJournal(feeling, journal, currentTime) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "appData.db");
  Database database = await openDatabase(path);
  dynamic dbData = await readDB();
  database.execute(
      "ALTER TABLE USER ADD COLUMN journal${dbData[0]["journals"] + 1} TEXT");
  final newJournalData = jsonEncode([feeling, journal, currentTime]);
  updateDB("journal${dbData[0]["journals"] + 1}", newJournalData);
  updateDB("journals", dbData[0]["journals"] + 1);
}
