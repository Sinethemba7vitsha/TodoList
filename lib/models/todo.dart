import 'package:flutter/cupertino.dart';
import 'package:sqlite_provider_starter/models/user.dart';

final String todoTable = 'todo';

class TodoFields {
  static final String username = 'username';
  static final String title = 'title';
  static final String done = 'done';
  static final String created = 'created';
  static final List<String> allFields = [username, title, done, created];
}

class Todo {
  final String username;
  final String title;
  bool done;
  final DateTime created;

  Todo({
    required this.username,
    required this.title,
    this.done = false,
    required this.created,
  });

  Map<String, Object?> toJson() => {
        TodoFields.username: username,
        TodoFields.title: title,
        TodoFields.created: created.toIso8601String(),
        TodoFields.done: done ? 1 : 0,
      };

  static Todo fromJson(Map<String, Object?> json) => Todo(
        username: json[TodoFields.username] as String,
        title: json[TodoFields.title] as String,
        created: DateTime.parse(json[TodoFields.created] as String),
        done: json[TodoFields.done] == 1 ? true : false,
      );

  @override
  bool operator ==(covariant Todo todo) {
    return (this.username == todo.username) &&
        (this.title.toLowerCase().compareTo(todo.title.toLowerCase()) == 0);
  }

  int get hashcodeffs {
    return hashValues(username, title);
  }

  @override
  int get hashCode => super.hashCode;
}
