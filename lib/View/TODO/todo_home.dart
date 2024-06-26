import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/todo/todo_controller.dart';
import 'package:smart_tourism/View/TODO/todo.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());
    todoController.getToDo();
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      body: Obx(() {
        if (todoController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (todoController.todos.isEmpty) {
          return Center(child: Text('No tasks available'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                final todo = todoController.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.content),
                  trailing: Obx(
                    () {
                      return IconButton(
                        icon: todoController.isDeleting.value
                            ? CircularProgressIndicator()
                            : Icon(Icons.delete),
                        onPressed: () {
                          todoController.isDeleting.value = true;
                          todoController.deleteToDo(todo.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddToDoScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
