import 'dart:convert';
import 'package:farmerapp/authpage/farmerregister.dart';
import 'package:farmerapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:farmerapp/authpage/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  bool _isNotValidate = false;
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginuser() async {
  if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
    var reqBody = {
      "phoneNumberOrEmail": _loginController.text,
      "password": _passwordController.text
    };

    try {
      var response = await http.post(
        Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse); 

      if (jsonResponse['success'] == "Login Successful") {
        
        
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(token: myToken,)),
        );
        ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Welcome Cheif'),
        ));
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unexpected error: ${jsonResponse['error']}'),
        ),
      );
        
        print("Something went wrong: ${jsonResponse['error']}");
      }
    } catch (e) {
      print("Error during login: $e");
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.2,
                child: Image.network('https://th.bing.com/th?id=OIP.csokY42_Ig_LiVhlugzvVgHaFL&w=298&h=209&c=8&rs=1&qlt=90&o=6&cb=13&dpr=1.3&pid=3.1&rm=2'),
              ),
              SizedBox(height: screenHeight * 0.05),

              TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  labelText: 'Email/Phone',
                  errorText: _isNotValidate ? "Enter a valid Gmail address" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _isNotValidate ? "Enter Info Properly" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isNotValidate = false;
                    });
                    loginuser();
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.pacifico(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have An Account?! "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                    },
                    child: Text("Sign Up🫰", style: GoogleFonts.pacifico(color: Colors.green, fontWeight: FontWeight.bold)),
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
