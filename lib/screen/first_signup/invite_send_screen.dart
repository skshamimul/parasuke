import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/locale_keys.g.dart';

import '../../router/app_route.dart';
import '../../router/app_route.gr.dart';
import '../../service/setup_services.dart';

@RoutePage<String>()
class InviteSendScreen extends StatefulWidget {
  const InviteSendScreen({
    super.key,
  });

  @override
  _InviteSendScreenState createState() => _InviteSendScreenState();
}

class _InviteSendScreenState extends State<InviteSendScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? Colors.white : Colors.white,
        noAppBar: true,
        invertStatusIcons: false,
      ),
      child: Scaffold(
        backgroundColor: isLight ? Colors.black : Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 200,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.close_rounded,
                                color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      LocaleKeys.invite_screen_sent1.tr() +
                          LocaleKeys.invite_screen_sent2.tr(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(230, 48)),
                        ),
                        onPressed: () {
                          getIt<AppRouter>().replace( AddMemberRoute(calendarName: ''));
                        },
                        child: Text(
                          LocaleKeys.sent_invite_set_next.tr(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(230, 48)),
                        ),
                        onPressed: () {
                           getIt<AppRouter>().pop();
                        },
                        child: Text(
                          LocaleKeys.sent_invite_complete_setup.tr(),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      LocaleKeys.sent_invite_note.tr(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
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
}
