import 'package:flutter/material.dart';
import 'package:hive_sample/Screen/adding_page.dart';
import 'package:hive_sample/Screen/update.dart';
import 'package:hive_sample/db/model/data_model.dart';
import 'package:hive_sample/db/model/funcitons/db_functions.dart';
import 'package:hive_sample/provider/db_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) =>
          Provider.of<DataBaseProvider>(context, listen: false).getAllStudent(),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Data Book"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<DataBaseProvider>(
          builder: (context, value, child) {
            return value.studentList.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      final data = value.studentList[index];

                      return ListTile(
                        title: Text(data.name),
                        subtitle: Text(data.age),
                        trailing: IconButton(
                          onPressed: () {
                            showAlertDialog(context, data);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateStudent(model: data),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: value.studentList.length,
                  )
                : const Center(
                    child: Text("No Data Found"),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddingPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showAlertDialog(BuildContext context, StudentModel data) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        deleteStudent(context, data.id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete?"),
      content:
          const Text("Are you sure you want to delete this student's data?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
