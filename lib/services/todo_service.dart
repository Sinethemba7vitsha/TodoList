import 'package:flutter/material.dart';
import 'package:sqlite_provider_starter/database/todo_database.dart';
import 'package:sqlite_provider_starter/models/todo.dart';

class TodoService with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<String> getTodos(String username) async {
    try {
      await TodoDatabase.instance.getTodo(username);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'OK';
  }

  Future<String> deleteTodo(Todo todo) async {
    try {
      await TodoDatabase.instance.deleteTodo(todo);
    } catch (e) {
      e.toString();
    }

    String result = await getTodos(todo.username);
    return result;
  }

  Future<String> createTodo(Todo todo) async {
    try {
      await TodoDatabase.instance.createTodo(todo);
    } catch (e) {
      e.toString();
    }

    String result = await getTodos(todo.username);
    return result;
  }

  Future<String> toggleTodoDone(Todo todo) async {
    try {
      await TodoDatabase.instance.toggleTodo(todo);
    } catch (e) {
      e.toString();
    }

    String result = await getTodos(todo.username);
    return result;
  }
}
