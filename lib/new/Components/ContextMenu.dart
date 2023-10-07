import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shakosh/main.dart';
import 'package:universal_html/html.dart' as html;

import 'package:shakosh/new/Config/Translations/Translation.dart';

Future<void> onPointerDown(PointerDownEvent event, String link) async {
  // Check if right mouse button clicked
  if (event.kind == PointerDeviceKind.mouse &&
      event.buttons == kSecondaryMouseButton) {
    final overlay = Overlay.of(navigatorKey.currentContext!)
        .context
        .findRenderObject() as RenderBox;
    final menuItem = await showMenu<int>(
        context: navigatorKey.currentContext!,
        items: [
          PopupMenuItem(
              height: 30, child: Text('copy-link-address'.tr), value: 1),
          PopupMenuItem(enabled: false, height: 10, child: Divider(), value: 0),
          PopupMenuItem(
              height: 30, child: Text('open-in-new-tab'.tr), value: 2),
        ],
        position: RelativeRect.fromSize(
            event.position & Size(48.0, 48.0), overlay.size));
    // Check if menu item clicked
    switch (menuItem) {
      case 1:
        await Clipboard.setData(ClipboardData(text: link));
        break;
      case 2:
        html.window.open(link, 'new tab');
        break;
      default:
    }
  }
}