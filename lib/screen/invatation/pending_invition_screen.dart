import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';

import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../../widget/async_value_widget.dart';

import '../../widget/button_widget.dart';
import 'invition_controller.dart';

@RoutePage<String>()
class PendingInvitionScreen extends ConsumerWidget {
  const PendingInvitionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

  
    final model = ref.watch(invitionProvider);
    final AsyncValue<List<Relation>> relationListAsync =
        ref.watch(relationsStreamProvider);
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text(
            'Invition',
          ),
          centerTitle: true,
          //actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
        ),
        body: model.isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : AsyncValueWidget<List<Relation>>(
                value: relationListAsync,
                data: (List<Relation> relationList) {
                  return ListView.builder(
                      itemCount: relationList.length,
                      itemBuilder: (context, index) {
                        Relation relation = relationList[index];
                        return ListTile(
                          title: Text(relation.name),
                          trailing: AppButtonWidget(
                            backgroundColor: relation.isAccepted
                                ? Colors.redAccent
                                : theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            text: relation.isAccepted ? 'Delete' : 'Accept',
                            onPressed: () async {
                              if (!relation.isAccepted) {
                                await model.insertIntoCalendarList(
                                    calenderId: relation.calenderId,
                                    id: relation.id,
                                    name: relation.name);
                              }else{
                                await model.deleteIntoCalendarList(
                                    calenderId: relation.calenderId,
                                    id: relation.id,
                                    name: relation.name);
                              }
                            },
                          ),
                        );
                      });
                },
              )
              
              );
  }
}
