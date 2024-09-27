import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_modern_lines/Widgets/CustomButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Services/Add_ProfileInformation.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/SubTitleRow.dart';
import '../Widgets/TitleRow.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class Profile_View extends StatefulWidget {
  const Profile_View({Key? key}) : super(key: key);

  @override
  State<Profile_View> createState() => _Profile_ViewState();
}

class _Profile_ViewState extends State<Profile_View> {
  final _namecontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();

  String namehinttext = 'Name';
  String phonehinttext = 'Mobile';

  String _selectedGender = 'notselected';

  String _Selectedgrade = 'notselected';

  DateTime startdate = DateTime.now();
  String _displayStartdate = "Birth Date";
  File? _image;
  String newpickedimage = 'assets/empty.png';
  String _Selectedimage =
      'https://firebasestorage.googleapis.com/v0/b/navindu-69.appspot.com/o/test%2Fempty.png?alt=media&token=b0b1fb5d-e892-414b-91c3-b1911e6cc5d8';
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        newpickedimage = pickedImage.path;
        _Selectedimage = pickedImage.path;
        print('Image selected: $newpickedimage');
      });
    } else {
      print('No image selected');
    }
  }

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubtitleRow(
                        text: 'Dont Worry,only you can see your personal'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubtitleRow(
                        text: 'data, No one else will be able to see it'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40.0,
                    child: _image != null
                        ? Image.file(_image!)
                        : Image.network(_Selectedimage),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const FieldName(text: 'Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: namehinttext,
                  controller: _namecontroller,
                ),
                const SizedBox(
                  height: 25,
                ),
                const FieldName(text: 'Phone Number'),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) async {
                            final url =
                                'http://165.22.58.114/mybooks/admin/api/profile.php?phone_number=$value';
                            final response = await http.get(Uri.parse(url));

                            if (response.statusCode == 200) {
                              final jsonData = jsonDecode(response.body);
                              if (jsonData['status'] == 'success') {
                                setState(() {
                                  _Selectedimage =
                                      'http://165.22.58.114/mybooks/admin/api/${jsonData['profile']['profile_photo']}';
                                  _selectedGender =
                                      jsonData['profile']['gender'];
                                  _displayStartdate =
                                      jsonData['profile']['birth_date'];
                                  _namecontroller.text =
                                      jsonData['profile']['name'];
                                  _Selectedgrade = jsonData['profile']['grade'];
                                });
                              } else {
                                print('Failed to load data');
                              }
                            } else {
                              print('Failed to load data');
                            }
                          },
                          controller:
                              _phonenumbercontroller, // replace with your controller
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                phonehinttext, // replace with your hint text
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const FieldName(text: 'Gender'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value:
                                _selectedGender, // use the local variable as the initial value
                            hint: const Text('Select gender'),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'notselected',
                                child: Text('Select your gender'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Male',
                                child: Text('Male'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Female',
                                child: Text('Female'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Other',
                                child: Text('Other'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                // update the local variable when the user selects a new option
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const FieldName(text: 'Birth Date'),
                const SizedBox(
                  height: 10,
                ),
                DatePickerField(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: startdate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final String formattedDate = formatter.format(pickedDate);
                      setState(() {
                        startdate = pickedDate;
                        _displayStartdate = formattedDate;
                      });
                    }
                  },
                  labelText: _displayStartdate,
                ),
                const SizedBox(
                  height: 25,
                ),
                const FieldName(text: 'Grade'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value:
                                _Selectedgrade, // use the local variable as the initial value
                            hint: Text('Select Your Grade'),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'notselected',
                                child: Text('Select your Grade'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade1',
                                child: Text('Grade 1'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade2',
                                child: Text('Grade 2'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade3',
                                child: Text('Grade 3'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade4',
                                child: Text('Grade 4'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade5',
                                child: Text('Grade 5'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade6',
                                child: Text('Grade 6'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade7',
                                child: Text('Grade 7'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade8',
                                child: Text('Grade 8'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade9',
                                child: Text('Grade 9'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade10',
                                child: Text('Grade 10'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade11',
                                child: Text('Grade 11'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade12',
                                child: Text('Grade 12'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'grade13',
                                child: Text('Grade 13'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                // update the local variable when the user selects a new option
                                _Selectedgrade = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomLongButton(
                  text: 'Save',
                  onTap: () {
                    if (_image != null) {
                      print(newpickedimage);
                      Add_ProfileInformation_Function(
                        context: context,
                        imageFile: File(newpickedimage),
                        phone: _phonenumbercontroller.text,
                        gender: _selectedGender,
                        birthdate: _displayStartdate,
                        grade: _Selectedgrade,
                        name: _namecontroller.text,
                        imagename: newpickedimage,
                      );
                      setState(() {
                        _phonenumbercontroller.clear();
                        _namecontroller.clear();
                        namehinttext = 'Name';
                        phonehinttext = 'Mobile';

                        _selectedGender = 'notselected';

                        _Selectedgrade = 'notselected';

                        startdate = DateTime.now();
                        _displayStartdate = "Birth Date";
                        _image = null;
                        newpickedimage = '';
                        _Selectedimage =
                            'https://firebasestorage.googleapis.com/v0/b/navindu-69.appspot.com/o/test%2Fempty.png?alt=media&token=b0b1fb5d-e892-414b-91c3-b1911e6cc5d8';
                      });
                    } else {
                      print('Please select an image');
                    }
                  },
                ),
                /*  CustomLongButton(
                    text: 'Save',
                    onTap: () {
                      Add_ProfileInformation_Function(
                          context: context,
                          imageFile: _image!,
                          phone: _phonenumbercontroller.text,
                          gender: _selectedGender,
                          birthdate: _displayStartdate,
                          grade: _Selectedgrade,
                          name: _namecontroller.text,
                          imagename: newpickedimage);

                      /*   setState(() {
                        _phonenumbercontroller.clear();
                        _namecontroller.clear();
                        namehinttext = 'Name';
                        phonehinttext = 'Mobile';

                        _selectedGender = 'notselected';

                        _Selectedgrade = 'notselected';

                        startdate = DateTime.now();
                        _displayStartdate = "Birth Date";
                        _image = null;
                        newpickedimage = '';
                        _Selectedimage =
                            'https://firebasestorage.googleapis.com/v0/b/navindu-69.appspot.com/o/test%2Fempty.png?alt=media&token=b0b1fb5d-e892-414b-91c3-b1911e6cc5d8';
                      });*/
                    }),*/
                SizedBox(
                  height: 20,
                ),
                /*      CustomLongButton(
                    text: 'Test',
                    onTap: () {
                      FetchProfile('0876715356');
                    })*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
