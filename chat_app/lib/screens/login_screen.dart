import 'package:chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';
import '../widgets/page_transitions.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> _checkUserData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');
    return email == storedEmail && password == storedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: 'hiLogo',
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.pink,
                            child: Text(
                              "hi!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32),
                        CustomButton(
                          text: "Login",
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final isValid = await _checkUserData(
                                _emailController.text,
                                _passwordController.text,
                              );
                              if (isValid) {
                                Navigator.of(context).pushReplacement(
                                  createRoute(HomeScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid email or password',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.grey[700],
                            ),),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  createRoute(SignupScreen()),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.pink),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
