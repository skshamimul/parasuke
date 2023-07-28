import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../router/app_route.dart';
import '../../../router/app_route.gr.dart';
import '../../../service/setup_services.dart';

class StepTwoWidget extends StatefulWidget {
  const StepTwoWidget({super.key});

  @override
  State<StepTwoWidget> createState() => _StepTwoWidgetState();
}

class _StepTwoWidgetState extends State<StepTwoWidget> {
  final String _name = '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            LocaleKeys.add_member_set_member.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Image.asset(
                height: 280,
                width: double.infinity,
                'assets/images/step-2.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/images/dummyImg.png',
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.7),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FilledButton(
                style: FilledButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    elevation: 8),
                onPressed: () async{
                 await getIt<AppRouter>().push( AddMemberRoute(calendarName: ''));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.add_member_set_member.tr(),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
