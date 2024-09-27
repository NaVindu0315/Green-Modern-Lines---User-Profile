import 'package:flutter/material.dart';

import 'Views/ProfileView.dart';

void main() {
  runApp(const MYApp());
}

class MYApp extends StatefulWidget {
  const MYApp({Key? key}) : super(key: key);

  @override
  State<MYApp> createState() => _MYAppState();
}

class _MYAppState extends State<MYApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile_View(),
    );
  }
}
