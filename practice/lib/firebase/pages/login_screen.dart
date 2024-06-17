import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.showRegisterPage});
  final VoidCallback showRegisterPage;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width + 0.8,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1614368558214-f8922bd49987?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    opacity: 0.7,
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Welcome to', style: TextStyle(fontSize: 40)),
                    Image.network('https://i.imgur.com/Shu2fPn.png'),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // height: MediaQuery.of(context).size.height * 0.8,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Email'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // height: MediaQuery.of(context).size.height * 0.8,
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Password'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffed9937),
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      20), // Adjust the height of the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          child: const Text('Sign In',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('OR continue with'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                    icon: Icon(
                      MdiIcons.google,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(
                      Icons.apple,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(
                      Icons.facebook,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 5),
                ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have Account?',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                            width:
                                2), // Add space between the text and the button
                        TextButton(
                          onPressed: () {
                            // Handle TextButton press
                          },
                          child: GestureDetector(
                            onTap: widget.showRegisterPage,
                            child: const Text(
                              'create Account',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xffed9937)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
