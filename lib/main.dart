import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_sample/Screen/home_screen.dart';
import 'package:hive_sample/db/model/data_model.dart';
import 'package:hive_sample/provider/db_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => DataBaseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomeScreen(),
      ),
    );
  }
}
