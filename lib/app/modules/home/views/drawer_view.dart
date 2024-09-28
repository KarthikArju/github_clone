import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_clone/app/modules/home/controllers/home_controller.dart';
import 'package:github_clone/app/shared/shared_functions.dart';
import 'package:github_clone/app/shared/shared_variables.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          setHeight(24),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: appColor),
            child: Row(
              children: [
                Image.network(
                  controller.profileDetails.avatarUrl!,
                  height: 40,
                  width: 40,
                ),
                setWidth(12),
                Column(
                  children: [
                    Text(
                      controller.profileDetails.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      "Followers : ${controller.profileDetails.followers!}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Text(
                      "Following : ${controller.profileDetails.following!}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            onTap: (){
              controller.doLogout();
              Navigator.pop(context);
            },
            leading: IconButton(
                onPressed: () {
                  controller.doLogout();
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: appColor,
                )),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
