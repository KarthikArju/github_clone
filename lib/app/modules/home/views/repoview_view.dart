// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:github_clone/app/modules/home/controllers/home_controller.dart';
import 'package:github_clone/app/shared/shared_variables.dart';
import 'package:github_clone/app/widgets/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../shared/shared_functions.dart';

class RepoviewView extends GetView<HomeController> {
  const RepoviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isRepoDetailPageLoading.value
          ? loader()
          : ListView(
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
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    )),
                                Text(
                                  "Projects",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        setHeight(24),
                        Row(
                          children: [
                            Image.network(
                              controller.selectedRepo["owner"]["avatar_url"],
                              height: 40,
                            ),
                            setWidth(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.selectedRepo["name"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${controller.selectedRepo["owner"]["login"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                (controller.commitDetails != [] &&
                                        controller.commitDetails != null &&
                                        controller.commitDetails[controller
                                                    .commitDetails.length -
                                                1]["commit"]["committer"] !=
                                            null &&
                                        controller.commitDetails[controller
                                                        .commitDetails.length -
                                                    1]["commit"]["committer"]
                                                ["date"] !=
                                            null)
                                    ? Text(
                                        "Last Updated : ${controller.commitDetails[controller.commitDetails.length - 1]["commit"]["committer"]["date"].toString().replaceRange(10, 20, "")}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                (controller.repoDetail != [] && controller.repoDetail != null)
                    ? Column(
                        children: [
                          setHeight(20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  itemCount: controller.repoDetail.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (c, i) {
                                    var detail = controller.repoDetail[i];
                                    return Obx(() => GestureDetector(
                                          onTap: () {
                                            controller.selectedBranch.value = i;
                                            controller.getBranchDetail(
                                                detail["name"]);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            decoration: BoxDecoration(
                                                color: controller.selectedBranch
                                                            .value ==
                                                        i
                                                    ? Color(0xff27274A)
                                                    : Color(0xffF3F4FF),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  detail["name"],
                                                  style: TextStyle(
                                                      color: controller
                                                                  .selectedBranch
                                                                  .value ==
                                                              i
                                                          ? Colors.white
                                                          : Color(0xff5F607E)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  }),
                            ),
                          ),
                          setHeight(24),
                          Obx(() => controller.isBranchLoading.value
                              ? loader()
                              : (controller.branchContents != [] &&
                                      controller.branchContents != null)
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.branchContents.length,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        var contentDetails =
                                            controller.branchContents[i];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Color(0xffF6F5FE),
                                                      width: 2))),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.fileImg,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${contentDetails["name"]}",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff27274A),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : const Center(
                                      child: Text(
                                        "No Files Found",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ))
                        ],
                      )
                    : const Center(
                        child: Text(
                          "No Branch Found",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                setHeight(24)
              ],
            )),
    );
  }
}
