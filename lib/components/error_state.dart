import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Что-то пошло не так.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}
