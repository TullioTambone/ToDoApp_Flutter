// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> _todos = [];

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = "";
        return AlertDialog(
          title: Text("Add new Todo"),
          backgroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: TextField(
            onChanged: (value) {
              newTodo = value;
            },
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                setState(() {
                  if (newTodo.isNotEmpty) {
                    _todos.add(newTodo);
                  }
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.black),
                ),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedTodo = _todos[index];
        return AlertDialog(
          title: Text("Edit Todo"),
          backgroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: TextField(
            controller: TextEditingController(text: editedTodo),
            onChanged: (value) {
              editedTodo = value;
            },
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                setState(() {
                  _todos[index] = editedTodo;
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Save Changes",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.greenAccent,
            child: ListTile(
              title: Text(
                _todos[index],
                style: TextStyle(fontSize: 16),
              ),
              onTap: (){_editTodo(index);},
              trailing: IconButton(
                icon: Icon(Icons.delete,),
                onPressed: () {
                  setState(() {
                    _todos.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: const Color.fromARGB(255, 155, 239, 199),
        child: Icon(Icons.add),
      ),
    );
  }
}