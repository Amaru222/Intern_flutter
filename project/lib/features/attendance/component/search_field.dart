import 'package:flutter/material.dart';

Widget searchField() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF4F5F7),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.search,
          color: Colors.grey,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm theo tên',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
