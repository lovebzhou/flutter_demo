import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null) return;

    PageRoute route;
    if (Platform.isAndroid) {
      route = MaterialPageRoute(builder: (c) => page);
    } else {
      route = CupertinoPageRoute(builder: (c) => page);
    }

    Navigator.push(context, route);
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
