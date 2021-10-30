import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:cumposter/screens/home.dart';
import 'package:cumposter/screens/managed_groups.dart';
import 'package:cumposter/utilities/credentials.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthState createState() => AuthState();
}

class AuthState extends State<AuthScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  // late StreamSubscription onDestroy;
  late StreamSubscription<String> onUrlChanged;
  // late StreamSubscription<WebViewStateChanged> onStateChanged;
  final vkAuthUrl =
      'https://oauth.vk.com/authorize?client_id=7920916&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=groups,wall,photos,offline&response_type=token&v=5.131&controllers=1';
  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    // onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    //   print("destroy");
    // });

    // onStateChanged =
    //     flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged controllers) {
    //   print("onStateChanged: ${controllers.type} ${controllers.url}");
    // });

    onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String oauthUrl) async {
      if (oauthUrl.contains('user_denied')) {
        flutterWebviewPlugin.close();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
      if (oauthUrl.contains('access_token=')) {
        var authParams = AuthParams.getFromOauthUrl(oauthUrl);

        var accessToken = authParams['access_token'];
        await AccessToken.set(accessToken);

        var userId = authParams['user_id'];
        await UserId.set(userId);

        flutterWebviewPlugin.close();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // onDestroy.cancel();
    onUrlChanged.cancel();
    // onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: vkAuthUrl,
        appBar: AppBar(
          title: Text('Авторизация ВК'),
        ));
  }
}
