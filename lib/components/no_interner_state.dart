import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Нет соединения с интернетом.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}
