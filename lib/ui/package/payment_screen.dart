import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/constant/ps_constants.dart';
import 'package:flutterbuyandsell/constant/route_paths.dart';
import 'package:flutterbuyandsell/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOutWebView extends StatefulWidget {
  const CheckOutWebView({required this.urlShipment});
  final String urlShipment;
  @override
  _CheckOutWebViewState createState() => _CheckOutWebViewState();
}

class _CheckOutWebViewState extends State<CheckOutWebView> {
  late WebViewController _controller;

  String? urlSuccess;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (urlSuccess!.contains('success')) {
          Navigator.pushNamed(context, RoutePaths.itemOfferEntry,
              arguments: ItemEntryIntentHolder(
                  flag: PsConst.ADD_NEW_ITEM, item: Product()));
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (urlSuccess!.contains('success')) {
                  Navigator.pushReplacementNamed(
                      context, RoutePaths.itemOfferEntry,
                      arguments: ItemEntryIntentHolder(
                          flag: PsConst.ADD_NEW_ITEM, item: Product()));
                } else {
                  Navigator.of(context).pop();
                }
              }),
        ),
        body: WebView(
          initialUrl: widget.urlShipment,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          debuggingEnabled: true,
          zoomEnabled: true,
          allowsInlineMediaPlayback: true,
          navigationDelegate: (NavigationRequest request) {
            urlSuccess = request.url;
            if (request.url.contains('success')) {
              Navigator.pushReplacementNamed(context, RoutePaths.itemOfferEntry,
                  arguments: ItemEntryIntentHolder(
                      flag: PsConst.ADD_NEW_ITEM, item: Product()));
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            urlSuccess = await _controller.currentUrl();
          },
        ),
      ),
    );
  }
}
