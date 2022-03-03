import 'dart:async';


import 'package:flutter/material.dart';

class AudioCallView extends StatefulWidget {
  const AudioCallView({Key? key}) : super(key: key);

  @override
  _AudioCallViewState createState() => _AudioCallViewState();
}

class _AudioCallViewState extends State<AudioCallView> {


  // Build chat UI
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agora Audio quickstart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Speaking with Property Owner'),
        ),
        body: Center(
          child: Text('Audio Call Enabled'),
        ),
      ),
    );
  }
}
