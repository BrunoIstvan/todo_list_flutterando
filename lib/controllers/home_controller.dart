import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];

  final TodoRepository _repository;

  final state = ValueNotifier<HomeState>(HomeState.start);

  HomeController([TodoRepository repo])
      : _repository = repo ?? TodoRepository();

  Future start() async {
    state.value = HomeState.loading;

    try {
      todos = await _repository.fetchTodos();

      state.value = HomeState.success;
    } catch (_) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
