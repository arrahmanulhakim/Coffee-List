import 'package:flutter/material.dart';

InputDecoration inpDecor = InputDecoration(
  hintText: 'Email',
  filled: true,
  fillColor: Colors.grey[300],
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: const EdgeInsets.only(left: 14, top: 8, bottom: 6),
);
