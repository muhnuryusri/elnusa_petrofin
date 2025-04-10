import 'package:elnusa_petrofin/core/dependency/dependency.dart';
import 'package:elnusa_petrofin/presentation/views/home/home.dart';
import 'package:elnusa_petrofin/presentation/views/home/controller/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  DependencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      initialBinding: HomeBinding(),
      home: Home(),
    );
  }
}