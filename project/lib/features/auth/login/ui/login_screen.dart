import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width + 0.8,
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xfffcd2a8), fontSize: 20),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffffdbd2),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            hintText: 'Nhập email hoặc số điện thoại',
                            hintStyle:
                                const TextStyle(color: Color(0xfff2b87d))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Color(0xfff2b87d), fontSize: 20),
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffffdbd2),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none),
                                hintText: 'Mật khẩu',
                                hintStyle:
                                    const TextStyle(color: Color(0xfff2b87d))),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfffcd2a8),
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      20), // Adjust the height of the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          child: const Text('ĐĂNG NHẬP',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
