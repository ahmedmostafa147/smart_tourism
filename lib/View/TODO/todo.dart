import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/todo/todo_controller.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class AddToDoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());
    TextEditingController taskTitleController = TextEditingController();
    TextEditingController taskContentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // شارك الملاحظة
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // حذف الملاحظة
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: taskTitleController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a task title' : null,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: taskContentController,
                    decoration: InputDecoration(
                      hintText: 'Start typing',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(
                          () => CustomMaterialButton(
                            onPressed: () {
                              if (taskTitleController.text.isNotEmpty &&
                                  taskContentController.text.isNotEmpty) {
                                todoController.postToDo(
                                  taskTitleController.text,
                                  taskContentController.text,
                                );
                                taskTitleController.clear();
                                taskContentController.clear();
                                Get.back();
                              }
                            },
                            buttonText: todoController.isLoading.value
                                ? 'Loading...'
                                : 'Add',
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
