import 'package:dio/dio.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoRepository {
  Dio _dio;

  TodoRepository([Dio client]) : _dio = client ?? Dio();

  final url = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final list = response.data as List;
        return list.map((json) => TodoModel.fromJson(json)).toList();
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
