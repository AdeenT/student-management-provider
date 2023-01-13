import 'package:flutter/material.dart';
import 'package:hive_sample/Screen/home_screen.dart';
import 'package:hive_sample/db/model/data_model.dart';
import 'package:hive_sample/db/model/funcitons/db_functions.dart';
import 'package:hive_sample/provider/db_provider.dart';
import 'package:provider/provider.dart';

class UpdateStudent extends StatelessWidget {
  UpdateStudent({
    Key? key,
    required this.model,
  }) : super(key: key);

  final StudentModel model;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => Provider.of<DataBaseProvider>(context, listen: false)
          .updateStudent(model),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Update Student Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Consumer<DataBaseProvider>(
          builder: (context, values, child) => Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: values.name,
                    decoration: const InputDecoration(
                      labelText: 'Enter Student Name',
                      border: OutlineInputBorder(),
                    ),
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
                    controller: values.age,
                    decoration: const InputDecoration(
                      labelText: 'Enter Student age',
                      border: OutlineInputBorder(),
                    ),
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
                    controller: values.register,
                    decoration: const InputDecoration(
                      labelText: 'Enter Student place',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'register number is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: values.email,
                    decoration: const InputDecoration(
                      labelText: 'Enter Student standard',
                      border: OutlineInputBorder(),
                    ),
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
                        if (_formKey.currentState!.validate()) {
                          update(values, context);
                        }
                      },
                      child: const Text('Add'))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<void> update(DataBaseProvider values, ctx) async {
    final names = values.name.text.trim();
    final ages = values.age.text.trim();
    final register = values.register.text.trim();
    final email = values.email.text.trim();

    final student = StudentModel(
      id: model.id,
      name: names,
      age: ages,
      register: register,
      email: email,
    );
    updateStudent(student);

    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('data updated successfully...')));
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) {
      return  HomeScreen();
    }));
  }
}
