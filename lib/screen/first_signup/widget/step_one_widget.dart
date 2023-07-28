import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../repository/profile/domain/profile_model.dart';
import '../first_signup_controller.dart';

class StepOneWidget extends ConsumerStatefulWidget {
  final Profile profile;
  const StepOneWidget({super.key, required this.profile});

  @override
  ConsumerState<StepOneWidget> createState() => _StepOneWidgetState();
}

class _StepOneWidgetState extends ConsumerState<StepOneWidget> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    //final AsyncValue<Profile> profileAsync = ref.watch(profileStreamProvider(widget.profile.id));
    final FirstSignUpsScreenController model =
        ref.watch(firstSignUpsScreenProvider);
    // return AsyncValueWidget<Profile>(
    //   value: profileAsync,
    //   data: (Profile profile) {

    //   },
    // );
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            LocaleKeys.add_member_set_member.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Image.asset(
                height: 280,
                width: double.infinity,
                'assets/images/step-2.png',
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
            height: 10,
          ),
          // const Text(
          //   'Set up Your Profile Info',
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          //   textAlign: TextAlign.center,
          // ),
          // model.isShowPrograss
          //     ? UploadPrograssWidget(
          //         progress: model.prograss,
          //       )
          //     : ProfilePictureWidget(
          //         imagePath: profile.pictureUrl,
          //         isEdit: true,
          //         onClicked: () async {
          //           await model.pickProfileImage(context, profile);
          //         },
          //       ),
          // const SizedBox(height: 24),
          // TextField(
          //   controller: TextEditingController(text: profile.name),
          //   onChanged: (String text) {},
          //   key: const Key('name'),
          //   decoration: const InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: 'Enter Full Name',
          //     labelText: 'Full Name',
          //     prefixIcon: Icon(Icons.person),
          //     suffixIcon: Icon(Icons.edit),
          //     errorText: null,
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // const DropDownButtonFormFieldWidget(
          //   label: "Gender",
          //   selectedItem: 'Male',
          //   itemList: ['Male', 'Female', 'Others'],
          //   explainUsage: true,
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          // TextField(
          //   keyboardType: TextInputType.multiline,
          //   minLines: 2,
          //   maxLines: 5,
          //   onChanged: (String text) {},
          //   key: const Key('des'),
          //   decoration: const InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: 'Write Someting About You...',
          //     labelText: 'About You',
          //     prefixIcon: Icon(Icons.person),
          //     suffixIcon: Icon(Icons.edit),
          //     errorText: null,
          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
        ],
      ),
    );
  }
}
