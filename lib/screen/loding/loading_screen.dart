import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Container(child: const Center(child: CircularProgressIndicator.adaptive(),),),);
  }
}