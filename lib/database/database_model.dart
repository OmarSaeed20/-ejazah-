// import 'package:ejazah/database/user_db.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class MyDatabase {
//   Future<Database> database() async {
//     return openDatabase(
//       join(await getDatabasesPath(), 'user_db.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE user(id INTEGER PRIMARY KEY, email TEXT, password TEXT, accountId TEXT)',
//         );
//       },
//       version: 2,
//     );
//   }

//   Future<void> insert(User user) async {
//     final Database db = await database();
//     await db.insert(
//       user.table(),
//       user.tomap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> update(User user) async {
//     final Database db = await database();
//     await db.update(
//       user.table(),
//       user.tomap(),
//       where: "id = ?",
//       whereArgs: [user.getId()],
//     );
//   }

//   Future<void> delete(int id) async {
//     final Database db = await database();
//     await db.delete(
//       'user',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

//   Future<List> getAll() async {
//     final Database db = await database();
//     return db.query('user');
//   }

//   Future<List> getRow(int id) async {
//     final Database db = await database();
//     return db.query('user', where: 'id = "$id"');
//   }
// }
