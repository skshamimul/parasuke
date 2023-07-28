import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';
import '../../generated/locale_keys.g.dart';
import 'onboard_controller.dart';

@RoutePage<String>()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/images/calender_img.png',
    'assets/images/onboard_two_bg.png',
    'assets/images/onboard_img_3.png',
  ];

  final List<String> _descriptions = [
    LocaleKeys.onboarding_screen_onboarding_txt1,
    LocaleKeys.onboarding_screen_onboarding_txt2,
    LocaleKeys.onboarding_screen_onboarding_txt3,
  ];

  @override
  Widget build(BuildContext context) {
    final OnboardController model = ref.watch(onboardingProvider);
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? AppColor.bgColor : Colors.black,
        noAppBar: true,
        invertStatusIcons: false,
      ),
      child: Scaffold(
        backgroundColor: isLight ? AppColor.bgColor : Colors.black,
        body: SafeArea(
          left: false,
          right: false,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 450,
                            viewportFraction: 1.0,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (int index, _) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: _imagePaths.map((String imagePath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Image.asset(
                                          'assets/images/bgPattern.png',
                                          opacity:
                                              const AlwaysStoppedAnimation(1.5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Image.asset(
                                        'assets/images/dummyImg.png',
                                        fit: BoxFit.cover,
                                        opacity:
                                            const AlwaysStoppedAnimation(0.7),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _imagePaths.length,
                              (int index) => buildDot(index, context),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(26),
                            child: FilledButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(230, 48)),
                              ),
                              onPressed: () async {
                                if (_currentIndex < _imagePaths.length - 1) {
                                  setState(() {
                                    _currentIndex++;
                                  });
                                } else {
                                  await model.setOnboardingComplete();
                                }
                              },
                              child: const Text('はじめる'),
                            )),
                      ],
                    ),
                    Positioned(
                      top: 280,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 30,
                          ),
                          child: Text(
                            _descriptions[_currentIndex].tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      right: 25,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton(
                            onPressed: () async {
                              await model.setOnboardingComplete();
                            },
                            child: const Text(
                              'スキップ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }
}
