import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';

class StepThreeWidget extends StatelessWidget {
  const StepThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 72,
            width: 327,
            child: Card(
              color: const Color.fromARGB(255, 237, 207, 205),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/icon_note.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.max_screen_max_invited1.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade900,
                            ),
                          ),
                          Text(
                            LocaleKeys.max_screen_max_invited2.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        LocaleKeys.max_screen_max_invited3.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            'dammy@gmail.com ${LocaleKeys.max_screen_if_accept.tr()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Image.asset(
                height: 280,
                width: double.infinity,
                'assets/images/bgPattern2.png',
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/calender3.png',
                height: 280,
                width: 300,
                alignment: Alignment.centerRight,
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
            height: 15,
          )
        ],
      ),
    );
  }
}
