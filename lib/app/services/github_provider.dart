import 'package:github_clone/app/modules/home/models/profile_detail_response.dart';
import 'package:github_clone/app/services/api_end_points.dart';
import 'package:github_clone/app/services/base_provider.dart';
import 'package:github_clone/app/shared/shared_functions.dart';

class GithubProvider extends BaseProvider {
  Future<ProfileDetailResponse> fetchUserDetails() async {
    var token = fetchUserToken();
    try {
      final response = await get(ApiEndPoints.profileDetails, headers: {
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer $token"
      });
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return ProfileDetailResponse.fromJson(response.body);
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future fetchRepoList() async {
    var token = fetchUserToken();
    try {
      final response = await get(ApiEndPoints.repoList, headers: {
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer $token"
      });
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return response.body;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future getOrganizationRepositories() async {}
  Future getRepoDetail(request) async {
    var token = fetchUserToken();
    try {
      final response = await get(
          "${ApiEndPoints.branchList}${request["owner"]}/${request["repoName"]}/branches",
          headers: {
            "Accept": "application/vnd.github+json",
            "Authorization": "Bearer $token"
          });
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return response.body;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future getRepositoryContent(
      String owner, String repo, String branch, String path) async {
    var token = fetchUserToken();
    try {
      final response = await get(
          "${ApiEndPoints.branchList}$owner/$repo/contents/$path?ref=$branch",
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github+json',
          });
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return response.body;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future fetchLastCommit(String owner, String repo, String branch) async {
    var token = fetchUserToken();

    try {
      final response = await get(
          "${ApiEndPoints.branchList}$owner/$repo/commits?sha=$branch",
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github+json',
          });
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e);
    } finally {}
  }
}
