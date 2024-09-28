// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_clone/app/modules/auth/views/auth_view.dart';
import 'package:github_clone/app/modules/home/models/profile_detail_response.dart';
import 'package:github_clone/app/routes/app_pages.dart';
import 'package:github_clone/app/services/github_provider.dart';
import 'package:github_clone/app/shared/shared_functions.dart';
import 'package:github_clone/main.dart';

class HomeController extends GetxController {
  GithubProvider githubProvider = GithubProvider();
  ProfileDetailResponse profileDetails = ProfileDetailResponse();

  var repoList;
  var repoDetail;
  var branchContents;
  var commitDetails;
  var selectedRepo;

  RxBool isPageLoading = true.obs;
  RxBool isRepoDetailPageLoading = true.obs;
  RxBool isBranchLoading = true.obs;
  RxInt selectedBranch = 0.obs;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  fetchUserDetails() async {
    isPageLoading.value = true;
    await githubProvider.fetchUserDetails().then((val) {
      profileDetails = val;
      getRepoLists();
    }).catchError((e) {
      toastify(e);
    });
  }

  getOrganisationList() async {}
  getRepoLists() async {
    await githubProvider.fetchRepoList().then((value) {
      repoList = value;
      isPageLoading.value = false;
    }).catchError((e) {
      // toastify(e);
    });
  }

  goto(details) async {
    Get.toNamed(Routes.REPODETAIL);
    getRepoDetail(details);
  }

  getRepoDetail(detail) async {
    selectedRepo = detail;
    selectedBranch.value = 0;
    var request = {
      "owner": detail["owner"]["login"],
      "repoName": detail["name"]
    };
    await githubProvider.getRepoDetail(request).then((value) {
      repoDetail = value;
      getBranchDetail(repoDetail[0]["name"]);
      isRepoDetailPageLoading.value = false;
      toastify("Repo Details Fetched Successfully");
    }).catchError((e) {
      toastify(e.toString());
    });
  }

  getBranchDetail(branchName) async {
    isBranchLoading.value = true;
    String ownerName = selectedRepo["owner"]["login"];
    String repoName = selectedRepo["name"];
    String branch = branchName;

    await githubProvider
        .getRepositoryContent(ownerName, repoName, branch, "/")
        .then((val) {
      branchContents = val;
      fetchCommit(branch);
    });
  }

  fetchCommit(branchName) async {
    isBranchLoading.value = true;
    String ownerName = selectedRepo["owner"]["login"];
    String repoName = selectedRepo["name"];
    String branch = branchName;

    await githubProvider
        .fetchLastCommit(ownerName, repoName, branch)
        .then((val) {
      commitDetails = val;
      isBranchLoading.value = false;
    });
  }

  doLogout() async {
    await storage.remove("token");
    Get.offUntil(
      MaterialPageRoute(builder: (context) => AuthView()),
      ModalRoute.withName('/auth'),
    );
    toastify("Logged Out Successfully");
  }
}
