import 'package:flutter/material.dart';
import 'package:cg_fourth_lab/widgets/animated_figure.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourth CG lab'),
      ),
      body: const Center(
        child: AnimatedFigure(),
      ),
    );
  }
}
