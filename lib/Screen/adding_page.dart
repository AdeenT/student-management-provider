// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_sample/Screen/home_screen.dart';
import 'package:hive_sample/db/model/data_model.dart';
import 'package:hive_sample/db/model/funcitons/db_functions.dart';

class AddingPage extends StatelessWidget {
  AddingPage({super.key});
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _register = TextEditingController();
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _age,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'age is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _register,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Register Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Register number is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addClick(context);
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addClick(BuildContext ctx) async {
    final name = _name.text.trim();
    final age = _age.text.trim();
    final register = _register.text.trim();
    final email = _email.text.trim();

    if (_formKey.currentState!.validate()) {
      final student = StudentModel(
        id: DateTime.now().millisecond.toString(),
        name: name,
        age: age,
        register: register,
        email: email,
      );

      await addStudent(student);

      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('data added successfully...')));
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return  HomeScreen();
          },
        ),
      );
    }
  }
}
