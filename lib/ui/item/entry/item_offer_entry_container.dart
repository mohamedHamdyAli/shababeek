import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/config/ps_config.dart';
import 'package:flutterbuyandsell/constant/route_paths.dart';
import 'package:flutterbuyandsell/ui/item/entry/item_offer_entry_view.dart';
import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutterbuyandsell/viewobject/common/ps_value_holder.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';
import 'package:provider/provider.dart';

class ItemOfferEntryContainerView extends StatefulWidget {
  const ItemOfferEntryContainerView({
    required this.flag,
    required this.item,
  });
  final String flag;
  final Product? item;
  @override
  ItemEntryContainerViewState createState() => ItemEntryContainerViewState();
}

class ItemEntryContainerViewState extends State<ItemOfferEntryContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutePaths.home);
              },
              icon: Icon(Icons.arrow_back_ios)),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          backgroundColor: PsColors.backgroundColor,
          iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.primary500
                  : PsColors.primaryDarkWhite),
          title: Text(
            Utils.getString(context, 'item_entry__listing_entry_offer'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                color: Utils.isLightMode(context)
                    ? PsColors.primary500
                    : PsColors.primaryDarkWhite),
          ),
          elevation: 0,
        ),
        body: ItemOfferEntryView(
          animationController: animationController,
          flag: widget.flag,
          item: widget.item,
          maxImageCount: psValueHolder.maxImageCount,
        ),
      ),
    );
  }
}
