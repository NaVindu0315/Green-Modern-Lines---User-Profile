import 'package:flutter/material.dart';

import '../Widgets/SubTitleRow.dart';
import '../Widgets/TitleRow.dart';

class Profile_View extends StatefulWidget {
  const Profile_View({Key? key}) : super(key: key);

  @override
  State<Profile_View> createState() => _Profile_ViewState();
}

class _Profile_ViewState extends State<Profile_View> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complete Your Profile'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubtitleRow(
                        text: 'Dont Worry,only you can see your personal'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubtitleRow(
                        text: 'data, No one else will be able to see it'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
