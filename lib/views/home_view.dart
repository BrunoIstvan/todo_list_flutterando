import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/controllers/home_controller.dart';
import 'package:todo_list/models/todo_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: AnimatedBuilder(
        animation: _controller.state,
        builder: (ctx, child) {
          return stateManagement(_controller.state.value);
        },
      ),
    );
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  _start() {
    return Container();
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _success() {
    return ListView.builder(
      itemCount: _controller.todos?.length ?? 0,
      itemBuilder: (context, index) {
        TodoModel todo = _controller.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) {},
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  _error() {
    return Center(
      child: RaisedButton(
        child: Text('Tentar novamente'),
        onPressed: _controller.start,
      ),
    );
  }
}
