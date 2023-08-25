import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/user/user_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/view/details_settings_view.dart';
import 'package:parking/view/profile/update_profile_view.dart';
import '../../controller/bottomSheet_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final UserController user = Get.put(UserController());
  final bottomSheet = Get.put(BottomSheetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parkit",
          style: TextStyle(
            fontFamily: 'Billabong',
            color: deepdarkblue,
            fontSize: 50,
            fontWeight: FontWeight.w500,
            height: 2,
          ),
        ),
        elevation: 1.5,
        backgroundColor: lightgreen,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: deepdarkblue,
            size: 45,
          ),
        ),
      ),
      body: Obx(
              () => Column(
                children: [
                  Container(
                    color: lightgreen,
                    height: 220,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 12),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: '${user.user.value.picture}',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 200,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.user.value.name} ${user.user.value.nickname}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: deepdarkblue),
                              ),
                              Text(
                                '${user.user.value.email}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birth Day : ${user.user.value.birth}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Phone Number : ${user.user.value.phone}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Balance : ${user.user.value.wallet?.price}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: deepdarkblue,
                          ),
                          onTap: () {
                            Get.to(UpdateProfileView(user: user.user.value));
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: deepdarkblue,
                          ),
                          leading: Icon(
                            Icons.notification_important,
                            color: darkblue,
                          ),
                          onTap: () {},
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Security',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: deepdarkblue,
                          ),
                          leading: Icon(
                            Icons.security,
                            color: darkblue,
                          ),
                          onTap: () {},
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Help',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: deepdarkblue,
                          ),
                          leading: Icon(
                            Icons.help,
                            color: darkblue,
                          ),
                          onTap: () {},
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: deepdarkblue,
                          ),
                          leading: Icon(
                            Icons.settings,
                            color: darkblue,
                          ),
                          onTap: () {
                            Get.to(DetailsSettingsView());
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color: red,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.exit_to_app,
                            color: red,
                          ),
                          leading: Icon(
                            Icons.fullscreen_exit,
                            color: red,
                          ),
                          onTap: () {
                            bottomSheet.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }
}
