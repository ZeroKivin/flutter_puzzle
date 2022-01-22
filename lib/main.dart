import 'package:flutter/material.dart';
import 'package:flutter_puzzle/ui/app/app.dart';
import 'package:flutter_puzzle/ui/app/app_dependencies.dart';

void main() {
  runApp(
    const AppDependencies(
      app: App(),
    ),
  );
}
