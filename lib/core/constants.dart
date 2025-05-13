import 'package:flutter/material.dart';

const elevatedButtonStyle = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
    minimumSize: MaterialStatePropertyAll(Size(double.infinity, 48)),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    )));
