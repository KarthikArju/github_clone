// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_clone/app/modules/home/views/drawer_view.dart';
import 'package:github_clone/app/shared/shared_functions.dart';
import 'package:github_clone/app/shared/shared_variables.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      key: controller.drawerKey,
      drawer: DrawerView(),
      body: Obx(() => controller.isPageLoading.value
          ? loader()
          : RefreshIndicator(
              onRefresh: () async {
                controller.fetchUserDetails();
              },
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, top: 24, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      controller.drawerKey.currentState!.openDrawer();
                                    },
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                  setWidth(8),
                                  Text(
                                    "Github",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              )
                            ],
                          ),
                          setHeight(24),
                          Text(
                            "Hi ${controller.profileDetails.name!}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          setHeight(20)
                        ],
                      ),
                    ),
                  ),
                  setHeight(24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Projects",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                     controller.repoList!=[] &&controller.repoList!=null ?   ListView.builder(
                            itemCount: controller.repoList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              var details = controller.repoList[i];
                              return GestureDetector(
                                onTap: () {
                                  controller.goto(details);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 12,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16,
                                          top: 16,
                                          bottom: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              details["owner"]["avatar_url"] !=
                                                      null
                                                  ? Image.network(
                                                      details["owner"]
                                                          ["avatar_url"],
                                                      height: 40,
                                                    )
                                                  : const SizedBox(),
                                              setWidth(16),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    details["name"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      details["owner"]["login"])
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_right_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }) : const Center(
                        child: Text(
                          "No Repository Found",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      )
                      ],
                    ),
                  ),
                  setHeight(24)
                ],
              ),
            )),
    );
  }
}
