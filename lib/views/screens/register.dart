import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_register_using_getx/views/screens/login.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _regController = TextEditingController();


  register(){
    if(_formKey.currentState!.validate()){
      Get.to(Loginscreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.activeBlue,
      body: SafeArea(child: SingleChildScrollView(
        child:Padding(padding:
        EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child:Form(key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text('Register New User',style:
                TextStyle(fontSize: 25,color: Colors.white),),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                  hintText: 'Enter your Username'
                ),

              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _nameController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                    hintText: 'Enter your Name'
                ),


              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _emailController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                    hintText: 'Enter your E-mail'
                ),

                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter the email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  }

              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _contactController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                    hintText: 'Enter your Contact'
                ),
                validator: (value){
                if(value == null || value.isEmpty){
                  return 'cannot be empty';
                }else if(!RegExp(r'^\d{10}$').hasMatch(value)){
                  return 'contact number should be 10 digits';
                }else{
                  return null;
                }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _passwordController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                    hintText: 'Enter your password',

                ),
                obscureText: true,
                validator: (value){
                if(value == null || value.isEmpty){
                  return 'Password cannot be Empty';
                }else{
                  return null;
                }
                }
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _cpasswordController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                    hintText: 'Confirm your Password',

                ),
                obscureText: true,
                validator: (value){
                if(value == null || value.isEmpty){
                  return 'password cannot be empty';
                }else if(value == _passwordController.text){
                  return null;
                }else{
                  return 'password is mismatched';
                }
                }

              ),
          SizedBox(
            height: 55,
          ),

              Container(width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),color: CupertinoColors.white
                  ),
                  child:
              TextButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  register();
                }
              }, child: Text('Register')
              )
              )
          ]
          ),
        ),

      ))
    ));
  }
}
