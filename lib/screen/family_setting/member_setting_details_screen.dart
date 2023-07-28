// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../core/constants/app_color.dart';
import '../../core/constants/app_const.dart';
import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../../widget/async_value_widget.dart';
import '../../widget/button_widget.dart';
import 'member_setting_controller.dart';

@RoutePage<String>()
class MemberSettingDetailsScreen extends ConsumerWidget {
  final Relation relation;

  const MemberSettingDetailsScreen({super.key, required this.relation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    final bool isLight = theme.brightness == Brightness.light;
    final model = ref.watch(memberSettingProvider);
    final AsyncValue<Relation> relationAsync =
        ref.watch(relationStreamProvider(relation.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          relation.name,
        ),
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            label: Text('return')),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      backgroundColor: AppColor.bgColor,
      body: AsyncValueWidget<Relation>(
        value: relationAsync,
        data: (Relation data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                decoration: BoxDecoration(
                    color: isLight ? Colors.white : Colors.black54),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calendar linkage',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(data.name),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AppButtonWidget(
                        isLoading: model.isBusy,
                        onPressed: () async {
                          final bool isMain = data.email == model.profile.email;
                          final String? result = await showDialog<String?>(
                              context: context,
                              useRootNavigator: false,
                              builder: (BuildContext context) => _AlertDialogWidget(
                                  isMain
                                      ? 'You Can Not Unlink Your Main Calendar'
                                      : 'メンバーを含め、全ての予定が表示されなく\nなります。連携を解除しますか？',
                                  data.email,
                                  isMain));
                          if (result != null) {
                            await model.popDetailsScreen();
                          }
                        },
                        backgroundColor: theme.primaryColor,
                        text: 'Unlink',
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  decoration: BoxDecoration(
                      color: isLight ? Colors.white : Colors.black54),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Settings',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Table(
                        border: TableBorder.all(
                            width: 0.0,
                            color: isLight ? Colors.white : Colors.black54),
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                              ),
                            ),
                            children: <Widget>[
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Name',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.name,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                              ),
                            ),
                            children: <Widget>[
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Display',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppConst.display[data.display],
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                              ),
                            ),
                            children: <Widget>[
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Birthday',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.birthday.year == 1970
                                        ? 'Not set yet'
                                        : '${data.birthday}',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                              ),
                            ),
                            children: <Widget>[
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Role',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppConst.role[data.role],
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade600),
                              ),
                            ),
                            children: <Widget>[
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Occupation ',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppConst.occupation[data.occupation],
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                     const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AppButtonWidget(
                          onPressed: () async {
                            await model.navToEditDetails(data);
                          },
                          backgroundColor: theme.primaryColor,
                          text: 'Edit',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AlertDialogWidget extends ConsumerWidget {
  final String msg;
  final String calId;
  final bool isMain;
  const _AlertDialogWidget(this.msg, this.calId, this.isMain);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(memberSettingProvider);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outlined,
            color: Colors.red,
            size: 25,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  text: '抜けない',
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              if (!isMain) ...[
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: AppButtonWidget(
                    text: '抜ける',
                    onPressed: () async {
                      await model.unLinkCalender(calId);
                    },
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}
