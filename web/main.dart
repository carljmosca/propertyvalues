// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:PropertyValues/nav_menu.dart';
import 'package:PropertyValues/rate_calculator.dart';
import 'package:PropertyValues/net_proceeds.dart';
import 'package:route_hierarchical/client.dart';

void main() {
  initNavMenu();
  initCalculator();
  initNetProceeds();

  // Webapps need routing to listen for changes to the URL.
  var router = new Router();
  router.root
    ..addRoute(name: 'about', path: '/about', enter: showAbout)
    ..addRoute(name: 'netproceeds', path: '/netproceeds', enter: showNetProceeds)
    ..addRoute(name: 'home', defaultRoute: true, path: '/', enter: showHome);
  router.listen();
}

void showAbout(RouteEvent e) {
  // Extremely simple and non-scalable way to show different views.
  querySelector('#home').style.display = 'none';
  querySelector('#netproceeds').style.display = 'none';
  querySelector('#about').style.display = '';
}

void showNetProceeds(RouteEvent e) {
  querySelector('#home').style.display = 'none';
  querySelector('#about').style.display = 'none';
  querySelector('#netproceeds').style.display = '';
}

void showHome(RouteEvent e) {
  querySelector('#netproceeds').style.display = 'none';
  querySelector('#home').style.display = '';
  querySelector('#about').style.display = 'none';
}
