import 'package:http/http.dart' as http;
import 'package:vk_group_admin/utilities/credentials.dart';

class VkHttp {
  get(url, params) async {
    var token = await AccessToken.get();
    var endpointUrl = 'http://10.0.2.2:3000/api/vk';
    var currentUrl = endpointUrl + url;
    Map<String, String> queryParams = {
      'access_token': token!,
    };
    queryParams.addAll(params);
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = currentUrl + '?' + queryString;
    return http.get(Uri.parse(requestUrl));
  }
  delete(url, params) async {
    var token = await AccessToken.get();
    var endpointUrl = 'http://10.0.2.2:3000/api/vk';
    var currentUrl = endpointUrl + url;
    Map<String, String> queryParams = {
      'access_token': token!,
    };
    queryParams.addAll(params);
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = currentUrl + '?' + queryString;
    return http.delete(Uri.parse(requestUrl));
  }
}
