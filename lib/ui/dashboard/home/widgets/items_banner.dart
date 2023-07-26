import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/route_paths.dart';
import 'package:flutterbuyandsell/model/ads_model.dart';
import 'package:flutterbuyandsell/provider/gallery/gallery_provider.dart';
import 'package:flutterbuyandsell/provider/product/get_ads.dart';
import 'package:flutterbuyandsell/provider/product/product_provider.dart';
import 'package:flutterbuyandsell/repository/product_repository.dart';
import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutterbuyandsell/viewobject/common/ps_value_holder.dart';
import 'package:flutterbuyandsell/viewobject/holder/product_parameter_holder.dart';
import 'package:provider/provider.dart';

class ItemsBanner extends StatefulWidget {
  const ItemsBanner();

  @override
  State<ItemsBanner> createState() => _ItemsBannerState();
}

class _ItemsBannerState extends State<ItemsBanner> {
  late final GalleryProvider? galleryProvider;
  final ProductParameterHolder holder =
      ProductParameterHolder().getLatestParameterHolder();
  ProductRepository? productRepo;
  bool showEditButton = true;
  ItemDetailProvider? itemDetailProvider;
  late final ItemDetailProvider itemDetail;
  AnimationController? animationController;
  String appBarTitleName = '';
  String? appBarTitle = 'Home';
  PsValueHolder? valueHolder;
  Future<void> updateSelectedIndexWithAnimation(
      String? title, int? index) async {
    await animationController?.reverse().then<dynamic>((void data) {
      if (!mounted) {
        return;
      }

      setState(() {
        appBarTitleName = '';
        appBarTitle = title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    return ChangeNotifierProvider<GetAdsProvider>(
        create: (BuildContext context) => GetAdsProvider(),
        child: Consumer<GetAdsProvider>(
          builder:
              (BuildContext context, GetAdsProvider provider, Widget? child) =>
                  Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                    onTap: () async {
                      print(valueHolder!.loginUserId);
                      Navigator.pushNamed(
                        context,
                        RoutePaths.adsItemsList,
                        arguments:
                            Ads('1', Utils.getString(context, 'offers_items')),
                      );
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/home_icon/Group_9968.png',
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 25,
                            child: Text(
                              Utils.getString(context, 'dashboard__offerss'),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.textColor4
                                          : PsColors.primaryDarkWhite,
                                      fontSize: 15),
                            ),
                          ),
                        ])),
                GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.adsItemsList,
                        arguments: Ads('0',
                            Utils.getString(context, 'advertisments_items')),
                      );
                    },
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/home_icon/Group_9967.png',
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 25,
                            child: Text(
                              Utils.getString(
                                  context, 'dashboard__advertisments'),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.textColor4
                                          : PsColors.primaryDarkWhite,
                                      fontSize: 15),
                            ),
                          ),
                        ])),
              ],
            ),
          ),
        ));
  }
}
