import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_provider_starter/models/todo.dart';
import 'package:sqlite_provider_starter/models/user.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;
  TodoDatabase._init();

  Future _onCreate(Database db, int version) async {
    final userUserNameType = 'Primary Key Is Not Null';
    final Texttype = 'Text is not null ';
    final boolType = 'bool not null';

    db.execute(
        '''create Table $userTable(${UserFields.username} $userUserNameType,
        {$UserFields.name} $Texttype)

     ''');
    db.execute('''Create Table $todoTable(${TodoFields.username} $Texttype,
        ${TodoFields.title} $Texttype,${TodoFields.created} $boolType,
        ${TodoFields.done} $boolType)
         Primary Key $todoTable(${TodoFields.username})  Reference $userTable(${UserFields.username})''');
  }

  Future _onConfig(Database db) async {
    await db.execute('PRAGM foreign_Key = ON');
  }

  Future<Database> _initDB(String fileName) async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfig,
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('todo.db');
      return _database;
    }
  }




//CRUD FOR THE USER
  Future<User> createUser(User user) async {
    final db = await instance.database;
    db!.insert(userTable, user.toJson());
    return user;
  }

  Future<User> getUser(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      userTable,
      columns: UserFields.allFields,
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw FormatException('$username is not found');
    }
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db!.update(userTable, user.toJson(),
        where: '${UserFields.username}', whereArgs: [user.username]);
  }

  Future<int> deleteUser(String username) async {
    final db = await instance.database;
    return db!.delete(userTable,
        where: '${UserFields.username}', whereArgs: [username]);
  }

  //Crud For Todo

  Future<Todo> createTodo(Todo todo) async {
    final db = await instance.database;
    await db!.insert(todoTable, todo.toJson());
    return todo;
  }

  Future<int> toggleTodo(Todo todo) async {
    final db = await instance.database;
    todo.done = !todo.done;

    return db!.update(todoTable, todo.toJson(),
        where: '${TodoFields.title}= ? AND ${TodoFields.username} = ?',
        whereArgs: [todo.title, todo.username]);
  }

  Future<List<Todo>> getTodo(String username) async {
    final db = await instance.database;

    final results = await db!.query(todoTable,
        orderBy: '${TodoFields.created} DESC ',
        where: '${TodoFields.username} = ?',
        whereArgs: [username]);
    return results.map((e) => Todo.fromJson(e)).toList();
  }

  Future<int> deleteTodo(Todo todo) async {
    final db = await instance.database;
    return db!.delete(todoTable,
        where: '${TodoFields.title} = ? AND ${TodoFields.username} = ?',
        whereArgs: [todo.title, todo.username]);
  }
}
