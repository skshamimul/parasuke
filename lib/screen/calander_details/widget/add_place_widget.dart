import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:parasuke_app/widget/text_field_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_const.dart';
import '../../../router/app_route.dart';
import '../../../service/setup_services.dart';
import '../calendar_details_controller.dart';

/// Main home page
@RoutePage<String>()
class AddLocationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  late String _sessionToken;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();

    _sessionToken = uuid.v4();

    _controller.addListener(() {
      getSuggestion(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  void getSuggestion(String input) async {
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=${AppConst.INITIAL_API_KEY}&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _placeList =
              json.decode(response.body)['predictions'] as List<dynamic>;
        });
      }
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final CalanderDetailsController model = ref.watch(calanderDetailsProvider);
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
                  margin: const EdgeInsets.only(top: 25),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              getIt<AppRouter>().pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {}, child: const Text('Edit Icon')),
                        TextButton(
                            onPressed: () {
                              getIt<AppRouter>().pop(_controller.text);
                            },
                            child: Text(
                              'Keep',
                              style: theme.textTheme.labelLarge!
                                  .copyWith(color: Colors.blue.shade900),
                            )),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FBTextField(
                        controller: _controller,
                        name: 'localtion',
                        hintText: 'Search Localtion',
                        prefixIcon: Icons.location_pin,
                        suffixIcon: Icons.question_mark_outlined,
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
                        final String description =
                            _placeList[index]["description"] as String;
                        return DecoratedBox(
                          decoration: BoxDecoration(
                              color: isLight ? Colors.white : Colors.black54),
                          child: ListTile(
                            onTap: () async {
                              await model.setLocation(description);
                            },
                            leading: Icon(Icons.location_pin),
                            title: Text(description),
                          ),
                        );
                      },
                    ))
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
