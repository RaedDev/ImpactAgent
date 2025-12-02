import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class EmptyPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: const Alignment(0.0, 0.0),
          children: [
            Text('hi),
          ],
        ),
      ),
    );
  }
}
