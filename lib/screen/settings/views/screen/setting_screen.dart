// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../widget/dropdown_widget.dart';
import '../../../../widget/switch_widget.dart';

@RoutePage<String>()
class SettingScreen extends ConsumerStatefulWidget {
  SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    final bool isLight = theme.brightness == Brightness.light;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: Text(
          '設定',
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    color: isLight ? Colors.white : Colors.black54),
                child: const FBSwitchWidget(
                  name: 'holiday_display',
                  hint: '日本の祝日表示',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              const FbDropDownWidget(
                name: 'language',
                hintText: '言語',
                valueList: ['日本語', '英語'],
                prefixIcon: Icons.language,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
