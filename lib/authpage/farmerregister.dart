// // ignore_for_file: prefer_const_constructors

// import 'dart:convert';
// import 'dart:io';
// import 'package:farmerapp/authpage/farmerlogin.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:http/http.dart' as http;
// import 'package:farmerapp/config.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
  
//    bool _isNotValidate=false;
//  final  TextEditingController _emailController=TextEditingController();
//    final  TextEditingController _passwordController = TextEditingController();
//     final   TextEditingController _phoneNumberController=TextEditingController();
//  final  TextEditingController _usernameController=TextEditingController();




//   void registerUser() async{
//    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _usernameController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty){
//     var regBody={
//       "username":_usernameController.text,
//       "email":_emailController.text,
//       "phoneNumber":_phoneNumberController.text,
//       "password":_passwordController.text
//     };
//    try {
//       var response = await http.post(Uri.parse(registration),
//           headers: {"Content-Type": "application/json"}, 
//           body: jsonEncode(regBody));

//       // Process successful response (check status code, etc.)

//     } on SocketException catch (e) {
//       // Handle network error (e.g., show a message to the user)
//       print("Network error: $e");
//     } on HttpException catch (e) {
//       // Handle HTTP error (e.g., check status code and display error message)
//       print("HTTP error: $e");
//     } catch (e) {
//       // Handle other unexpected errors
//       print("Unexpected error: $e");
//     }
//    }else{
//     setState(() {
//       _isNotValidate=true;
//     });
//    }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo Image
//               Image.network(
//                 'https://th.bing.com/th?id=OIP.csokY42_Ig_LiVhlugzvVgHaFL&w=298&h=209&c=8&rs=1&qlt=90&o=6&cb=13&dpr=1.3&pid=3.1&rm=2', // Replace with your logo path
//                 width: screenWidth * 0.5,
//                 height: screenHeight * 0.2,
//               ),
//               SizedBox(height: screenHeight * 0.05),

//               // Username Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: _usernameController,
                  
//                   decoration: InputDecoration(
//                     errorText: _isNotValidate ? "Enter Info Properly":null,
//                     labelText: 'Username',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),

//               // Email Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//               errorText: _isNotValidate ? "Enter Info Properly":null,
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (!EmailValidator.validate(value!)) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),

//               // Phone Number Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: _phoneNumberController,
//                   decoration: InputDecoration(
//                      errorText: _isNotValidate ? "Enter Info Properly":null,
                   
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),

//               // Password Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     errorText: _isNotValidate ? "Enter Info Properly":null,

//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),

//               // Signup Button
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: const Color.fromRGBO(67, 160, 71, 1),
//                 ),
//                 child: MaterialButton(
//                   onPressed: registerUser, 
//                   child: Text('Register'),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already Have An Account?! "),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const LoginPage()),
//                       );
//                     },
//                     child: Text("Login🫰", style: GoogleFonts.pacifico(color: Colors.green, fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:farmerapp/authpage/farmerlogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:farmerapp/authpage/config.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isNotValidate=false;

  void clearTextFields() {
  _usernameController.clear();
  _emailController.clear();
  _phoneNumberController.clear();
  _passwordController.clear();
}


 void registerUser() async {
  if (_emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty) {
    var regBody = {
      "username": _usernameController.text,
      "email": _emailController.text,
      "phoneNumber": _phoneNumberController.text,
      "password": _passwordController.text
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody)
          );

      // Log the status code for debugging
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 201) {
        // Successful registration
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
          ),
        );

         clearTextFields(); // Clear all text fields

        // Navigate to the Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );


      } else if (response.statusCode == 400) {
        // Handle duplicate email/phone number error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body), // Display the specific error message from the backend
          ),
        );
      } else {
        // Handle unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
          ),
        );
      }
    } on SocketException {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error: Please check your internet connection.'),
        ),
      );
    } on HttpException catch (e) {
      // Handle other HTTP errors (e.g., 500 Internal Server Error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('HTTP error: ${e.message}'),
        ),
      );
    } catch (e) {
      // Handle other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unexpected error: ${e.toString()}'),
        ),
      );
    }
  } else {
    setState(() {
      _isNotValidate = true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image
              Image.network(
                'https://th.bing.com/th?id=OIP.csokY42_Ig_LiVhlugzvVgHaFL&w=298&h=209&c=8&rs=1&qlt=90&o=6&cb=13&dpr=1.3&pid=3.1&rm=2', // Replace with your logo path
                width: screenWidth * 0.5,
                height: screenHeight * 0.2,
              ),
              SizedBox(height: screenHeight * 0.05),

              // Username Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    errorText: _isNotValidate ? "Enter Info Properly" : null,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Email Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    errorText: _isNotValidate ? "Enter Info Properly" : null,
                  ),
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Phone Number Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    errorText: _isNotValidate ? "Enter Info Properly" : null,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    errorText: _isNotValidate ? "Enter Info Properly" : null,
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Signup Button
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(67, 160, 71, 1),
                ),
                child: MaterialButton(
                  onPressed: registerUser,
                  child: Text('Register'),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have An Account?! "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text("Login🫰", style: GoogleFonts.pacifico(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}