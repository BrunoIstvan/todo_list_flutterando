import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/controllers/home_controller.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/todo_repository.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

main() {
  final repository = TodoRepositoryMock();

  test('deve preencher variavel todos', () async {
    final controller = HomeController(repository);
    when(repository.fetchTodos()).thenAnswer((_) async => [TodoModel()]);
    expect(controller.state.value, HomeState.start);
    await controller.start();
    expect(controller.state.value, HomeState.success);
    expect(controller.todos.isNotEmpty, true);
  });

  test('deve modificar o estado para error se a requisicao falhar', () async {
    final controller = HomeController(repository);
    when(repository.fetchTodos()).thenThrow(Exception());
    expect(controller.state.value, HomeState.start);
    await controller.start();
    expect(controller.state.value, HomeState.error);
    expect(controller.todos.isEmpty, true);
  });
}
