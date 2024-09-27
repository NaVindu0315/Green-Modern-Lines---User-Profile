import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

/*
Future<void> Add_ProfileInformation_Function({
  required BuildContext context,
  required File imageFile,
  required String phone,
  required String gender,
  required String birthdate,
  required String grade,
  required String name,
  required String imagename,
}) async {
  final url = 'http://165.22.58.114/mybooks/admin/api/profile.php';

  //final url = Uri.parse(baseurl);
/*
  final headers = {
    'Authorization': 'Bearer $accessTokenPub',
  };
*/
  var request = http.MultipartRequest('POST', Uri.parse(url));
  // request.headers['Authorization'] = 'Bearer $accessTokenPub';
  request.headers['Content-Type'] = 'multipart/form-data';

  request.fields['name'] = name;
  request.fields['phone_number'] = phone;
  request.fields['gender'] = gender;
  request.fields['birth_date'] = birthdate;
  request.fields['grade'] = grade;

  request.files.add(
    http.MultipartFile.fromBytes(
      'profile_photo',
      imageFile.readAsBytesSync(),
      filename: imagename,
    ),
  );

  var response = await request.send();

  print(request);
  if (response.statusCode == 200) {
    print('Profile created successfully '
        '${response.statusCode}');
    await response.stream.bytesToString().then((String responseBody) {
      print('Response body: $responseBody');
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text("Details Added Succesfully !"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  } else {
    print('error '
        '${response.statusCode}');
    await response.stream.bytesToString().then((String responseBody) {
      print('Response body: $responseBody');
    });

    /* showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Failed"),
          content: Text("Please try again"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );*/
  }
}
*/
Future<void> FetchProfile(String phone) async {
  final url =
      'http://165.22.58.114/mybooks/admin/api/profile.php?phone_number=$phone';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Failed to load data');
  }
}

Future<void> Add_ProfileInformation_Function({
  required BuildContext context,
  required File imageFile,
  required String phone,
  required String gender,
  required String birthdate,
  required String grade,
  required String name,
  required String imagename,
}) async {
  final url = 'http://165.22.58.114/mybooks/admin/api/profile.php';

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Content-Type'] = 'multipart/form-data';

  request.fields['name'] = name;
  request.fields['phone_number'] = phone;
  request.fields['gender'] = gender;
  request.fields['birth_date'] = birthdate;
  request.fields['grade'] = grade;

  try {
    var bytes = await imageFile.readAsBytes();
    request.files.add(
      http.MultipartFile.fromBytes(
        'profile_photo',
        bytes,
        filename: imagename,
      ),
    );
  } catch (e) {
    print('Error reading image file: $e');
    return;
  }

  try {
    var response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      print('Profile created successfully '
          '${response.statusCode}');
      await response.stream.bytesToString().then((String responseBody) {
        print('Response body: $responseBody');
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success"),
            content: Text("Details Added Succesfully !"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      print('error '
          '${response.statusCode}');
      await response.stream.bytesToString().then((String responseBody) {
        print('Response body: $responseBody');
      });
    }
  } catch (e) {
    print('Error sending request: $e');
  }
}
