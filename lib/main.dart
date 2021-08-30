import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  bool isDone = false;
  String title;

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[];

  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할일 '),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                    ),
                  ),
                  ElevatedButton(
                    child: Text('추가'),
                    onPressed: () => _addTodo(Todo(_todoController.text)),
                  ),
              ],

              ),
              Expanded(
                child: ListView(
                  children: _items.map((todo) =>
                  _buildItemWidget(todo)).toList(),
                ),
              )
            ],
          ),
      ),
    );
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo),
      title: Text(
        todo.title,
        style: todo.isDone ? TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        ) : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(todo),
      ),
    );
  }
  
  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
    });
  }
  
  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }
  
  void _toggleTodo(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  
}
