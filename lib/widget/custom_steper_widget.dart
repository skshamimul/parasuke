import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum StepperState { inactive, active }

class CustomSteperWidget extends StatelessWidget {
  final StepperState stepOneStatus;
  final StepperState stepTwoStatus;
  final StepperState stepThreeStatus;
  const CustomSteperWidget({
    super.key,
    this.stepOneStatus = StepperState.inactive,
    this.stepTwoStatus = StepperState.inactive,
    this.stepThreeStatus = StepperState.inactive,
  });

  Color getColor(StepperState status) {
    return status == StepperState.inactive ? Colors.grey : Colors.black;
  }

  IconData getIcon(StepperState status) {
    return status == StepperState.inactive
        ? Icons.circle_outlined
        : Icons.circle;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                getIcon(stepOneStatus),
                color: getColor(stepOneStatus),
              ),
              Text(
                'STEP1\n利用者設定',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!
                    .copyWith(color: getColor(stepOneStatus)),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 2,
              color: getColor(stepTwoStatus),
            ),
          ),
          Column(
            children: [
              Icon(
                getIcon(stepTwoStatus),
                color: getColor(stepTwoStatus),
              ),
              Text(
                'STEP2\nメンバー設定',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!
                    .copyWith(color: getColor(stepTwoStatus)),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 2,
              color: getColor(stepThreeStatus),
            ),
          ),
          Column(
            children: [
              Icon(
                getIcon(stepThreeStatus),
                color: getColor(stepThreeStatus),
              ),
              Text(
                'STEP3\n利用開始',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!
                    .copyWith(color: getColor(stepThreeStatus)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
