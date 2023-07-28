import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:intl/intl.dart';
import '../../core/constants/app_color.dart';
import 'model/event.dart';

@RoutePage<String>()
class CalendarDayScreen extends StatefulWidget {
  final DateTime date;
  final String calenderID;
  final List<Map<String, dynamic>> events;
  final List<String> titleColumn;
  const CalendarDayScreen(
      {super.key,
      required this.date,
      required this.calenderID,
      required this.titleColumn,
      required this.events});

  @override
  State<CalendarDayScreen> createState() => _CalendarDayScreenState();
}

class _CalendarDayScreenState extends State<CalendarDayScreen> {
  List<CalendarEventData<Event>> _events = [];
  @override
  void initState() {
    for (var i = 0; i < widget.events.length; i++) {
      final cal.EventDateTime _start =
          widget.events[i]['start'] as cal.EventDateTime;
      final cal.EventDateTime _end =
          widget.events[i]['end'] as cal.EventDateTime;

      log(DateFormat.Hms().format(_start.dateTime!),
          name: 'Start EventDateTime');
      log(DateFormat.Hms().format(_end.dateTime!), name: 'End EventDateTime');
      _events.add(CalendarEventData(
        date: _start.dateTime!,
        event: Event(title: '${widget.events[i]['summary']}'),
        title: '${widget.events[i]['summary']}',
        description: '${widget.events[i]['description']}',
        startTime: _start.dateTime,
        endTime: _end.dateTime,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _title = DateFormat.yMMMd().format(widget.date);

    CalendarControllerProvider.of<Event>(context).controller.addAll(_events);

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: Row(
              children: [
                const SizedBox(
                  height: 40,
                  width: 40,
                ),
                Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            widget.titleColumn.length,
                            (int index) => Container(
                                  margin: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  padding: const EdgeInsets.all(7),
                                  width: 80,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: index == 0
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15))
                                          : null,
                                      color: AppColor.cHeaderColor[index]),
                                  child: Text(widget.titleColumn[index],
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))))
              ],
            ),
          ),
          Expanded(
            child: DayView<Event>(
              safeAreaOption: SafeAreaOption(bottom: false, top: false),
              onEventTap: (events, date) {
                log(events[0].toJson().toString(), name: 'events');
                showEvenDetailsDialog(context, events);
              },
              eventTileBuilder:
                  (date, events, boundary, startDuration, endDuration) {
                if (events.isNotEmpty) {
                  return NewRoundedEventTile(
                    borderRadius: BorderRadius.circular(10.0),
                    title: events[0].title,
                    totalEvents: events.length - 1,
                    description: events[0].description,
                    padding: EdgeInsets.all(5.0),
                    backgroundColor: events[0].color,
                    margin: EdgeInsets.all(0.0),
                    titleStyle: events[0].titleStyle,
                    descriptionStyle: events[0].descriptionStyle,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              initialDay: widget.date,
              heightPerMinute: 2,
              //timeLineBuilder: _timeLineBuilder,
              hourIndicatorSettings: HourIndicatorSettings(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEvenDetailsDialog(
      BuildContext context, List<CalendarEventData<Event>> data) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.bodyLarge!;
    final TextStyle footerStyle = themeData.textTheme.bodySmall!;
    // final TextStyle linkStyle =
    //     themeData.textTheme.bodyLarge!.copyWith(color: themeData.primaryColor);

    showDialog<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return EventDetalis(
          data: data,
        );
      },
    );
  }

  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class EventDetalis extends StatelessWidget {
  final List<CalendarEventData<Event>> data;
  const EventDetalis({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return AlertDialog(
      title: Text(data[0].title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data[0].description),
          SizedBox(
            height: 10,
          ),
          Text(DateFormat('dd-MM-yyyy kk:mm:a').format(data[0].startTime!)),
          const SizedBox(
            height: 10,
          ),
          const Text('To'),
          const SizedBox(
            height: 10,
          ),
          Text(DateFormat('dd-MM-yyyy kk:mm:a').format(data[0].endTime!)),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

/// This class defines default tile to display in day view.
class NewRoundedEventTile extends StatelessWidget {
  /// Title of the tile.
  final String title;

  /// Description of the tile.
  final String description;

  /// Background color of tile.
  /// Default color is [Colors.blue]
  final Color backgroundColor;

  /// If same tile can have multiple events.
  /// In most cases this value will be 1 less than total events.
  final int totalEvents;

  /// Padding of the tile. Default padding is [EdgeInsets.zero]
  final EdgeInsets padding;

  /// Margin of the tile. Default margin is [EdgeInsets.zero]
  final EdgeInsets margin;

  /// Border radius of tile.
  final BorderRadius borderRadius;

  /// Style for title
  final TextStyle? titleStyle;

  /// Style for description
  final TextStyle? descriptionStyle;

  /// This is default tile to display in day view.
  const NewRoundedEventTile({
    Key? key,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.description = "",
    this.borderRadius = BorderRadius.zero,
    this.totalEvents = 1,
    this.backgroundColor = Colors.blue,
    this.titleStyle,
    this.descriptionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty)
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      fontSize: 16,
                      color: backgroundColor.accent,
                    ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          if (description.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  description,
                  style: descriptionStyle ??
                      TextStyle(
                        fontSize: 14,
                        color: backgroundColor.accent.withAlpha(200),
                      ),
                ),
              ),
            ),
          if (totalEvents > 1)
            Expanded(
              child: Text(
                "+${totalEvents - 1} more",
                style: (descriptionStyle ??
                        TextStyle(
                          color: backgroundColor.accent.withAlpha(200),
                        ))
                    .copyWith(fontSize: 17),
              ),
            ),
        ],
      ),
    );
  }
}
