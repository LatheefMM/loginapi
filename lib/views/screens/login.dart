import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_register_using_getx/views/screens/register.dart';
import 'package:http/http.dart' as http;
import 'homescreen.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // URL of the API endpoint
      const url = 'https://restful-booker.herokuapp.com/auth';

      try {
        // Make the HTTP request
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }),
        );

        // Check the status code for the result
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          print('Login successful: ${data.toString()}');
          Get.to(() => Homescreen());
        } else {
          // If the server did not return a 200 OK response,
          // throw an exception.
          print('Failed to login: ${response.body}');
          Get.snackbar('Error', 'Failed to login',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: CupertinoColors.white,
          );
        }
      } catch (e) {
        // Print the error for debugging
        print('Error during login: $e');
        Get.snackbar('Error', 'An error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: CupertinoColors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/parking2.png',
                    fit: BoxFit.cover,
                    height: 230,
                    width: 240,
                  ),
                ),
                SizedBox(height: 40),
                Text('Username', style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 18),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Enter username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Password', style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 18),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                           ),
                    hintText: 'Enter password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 55),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    height: 45,
                    width: 90,
                    child: Center(
                      child: InkWell(
                        onTap: _login,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => Registerpage());
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 12, color: Colors.lightBlueAccent),
                      ),
                    ),
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
