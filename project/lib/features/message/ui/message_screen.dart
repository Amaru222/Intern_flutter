import 'package:flutter/material.dart';
import 'package:project/component/bottomnavigationbar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('message'),
      bottomNavigationBar: BottomBar(currentIndex: 2),
    );
  }
}
