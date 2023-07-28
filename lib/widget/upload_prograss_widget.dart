import 'package:flutter/material.dart';

import 'liquid_circular_progress_indicator.dart';

class UploadPrograssWidget extends StatelessWidget {
  final double progress;
  const UploadPrograssWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 375),
        child:LiquidCircularProgressIndicator(
                value: progress / 100,
                valueColor: const AlwaysStoppedAnimation(Colors.pinkAccent),
                backgroundColor: Theme.of(context).primaryColor,
                direction: Axis.vertical,
                center: Text(
                  'Uploading \n ${progress.round()}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
