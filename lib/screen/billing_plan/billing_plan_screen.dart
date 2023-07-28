// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widget/button_widget.dart';

@RoutePage<String>()
class BillingplanScreen extends ConsumerStatefulWidget {
  BillingplanScreen({super.key});

  @override
  ConsumerState<BillingplanScreen> createState() => _BillingplanScreenState();
}

class _BillingplanScreenState extends ConsumerState<BillingplanScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    final bool isLight = theme.brightness == Brightness.light;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        leadingWidth: 50,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          'アップグレード',
        ),
        centerTitle: true,
        //ß actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: double.maxFinite,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/billingh_bg_01.png'),
                ),
                Container(
                  height: 250,
                  width: double.maxFinite,
                  color: Colors.white.withOpacity(.5),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: FlutterLogo(
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'アップグレードすると、\n以下のことができるようになります。',
                textAlign: TextAlign.center,
                style:
                    theme.textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            tileColor: Color(0xFF122034),
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            textColor: Colors.white,
            title: Text.rich(
              TextSpan(
                text: '5 or more users ',
                style: TextStyle(fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                      text: '  ',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      )),
                  TextSpan(
                      text: '*Up to 10 users',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      )),
                  // can add more TextSpans here...
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: Color(0xFF122034),
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            textColor: Colors.white,
            title: Text('2 or more camera syncs'),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'About upgrade',
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: AppButtonWidget(
                onPressed: () {},
                text: 'Upgrade (¥490/month)',
                foregroundColor: Colors.white,
                backgroundColor: Colors.red.shade900,
              )),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Restore purchases',
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
