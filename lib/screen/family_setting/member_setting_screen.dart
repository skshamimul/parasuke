// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';
import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../../widget/async_value_widget.dart';
import '../../widget/button_widget.dart';
import 'member_setting_controller.dart';

@RoutePage<String>()
class MemberSettingScreen extends ConsumerWidget {
  const MemberSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    final bool isLight = theme.brightness == Brightness.light;
    final model = ref.watch(memberSettingProvider);

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: const Text(
          'Member Setting',
        ),
        centerTitle: true,
        //actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You',
                style: theme.textTheme.labelLarge,
              ),
            ),
            ...model.calendarList.mapIndexed((i, e) {
              return e.id == model.profile.email
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: isLight ? Colors.white : Colors.black54),
                        child: ListTile(
                          leading: const Icon(Icons.person_3_outlined),
                          title: Text(e.id!),
                          trailing: TextButton(
                            onPressed: () async {
                              //await model.navToMemberSettingDetails(e);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Settings'),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Members',
                style: theme.textTheme.labelLarge,
              ),
            ),
            // ...model.calendarList.mapIndexed(
            //   (i, e) {
            //     if (e.id == model.profile.email) {
            //       return SizedBox();
            //     } else {
            //       return Padding(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //         child: DecoratedBox(
            //           decoration: BoxDecoration(
            //               color: isLight ? Colors.white : Colors.black54),
            //           child: ListTile(
            //             leading: const Icon(Icons.person_3_outlined),
            //             title: Text(e.summary!),
            //             trailing: TextButton(
            //               onPressed: () async {
            //                 await model.navToMemberSettingDetails(e);
            //               },
            //               child: const Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   Text('Settings'),
            //                   Icon(Icons.keyboard_arrow_right),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ).toList(),
            const OtherCalendarWidget(),
            Align(
              alignment: Alignment.center,
              child: AppButtonWidget(
                onPressed: () async {
                  await model.navToSetMyFamily();
                },
                backgroundColor: theme.primaryColor,
                text: 'Add member',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OtherCalendarWidget extends ConsumerWidget {
  const OtherCalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(memberSettingProvider);
    final AsyncValue<List<Relation>> relationListAsync =
        ref.watch(relationsStreamProvider);
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return model.isBusy
        ? const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : AsyncValueWidget<List<Relation>>(
            value: relationListAsync,
            data: (List<Relation> relationList) {
              return Column(
                children: relationList
                    .map((e) => e.isAccepted
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color:
                                      isLight ? Colors.white : Colors.black54),
                              child: ListTile(
                                leading: const Icon(Icons.person_3_outlined),
                                title: Text(e.name),
                                trailing: TextButton(
                                  onPressed: () async {
                                    await model.navToMemberSettingDetails(e);
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Settings'),
                                      Icon(Icons.keyboard_arrow_right),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink())
                    .toList(),
              );

              // return ListView.builder(
              //     itemCount: relationList.length,
              //     itemBuilder: (context, index) {
              //       Relation relation = relationList[index];
              //       return ListTile(
              //         title: Text(relation.name),
              //         trailing: AppButtonWidget(
              //           backgroundColor: relation.isAccepted
              //               ? Colors.redAccent
              //               : theme.colorScheme.primary,
              //           foregroundColor: Colors.white,
              //           text: relation.isAccepted ? 'Delete' : 'Accept',
              //           onPressed: () async {

              //           },
              //         ),
              //       );
              //     });
            },
          );
  }
}
