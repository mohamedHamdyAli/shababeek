import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/ps_constants.dart';
import 'package:flutterbuyandsell/constant/ps_dimens.dart';
import 'package:flutterbuyandsell/constant/route_paths.dart';
import 'package:flutterbuyandsell/provider/product/get_ads.dart';
import 'package:flutterbuyandsell/ui/common/ps_hero.dart';
import 'package:flutterbuyandsell/ui/common/ps_ui_widget.dart';
import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutterbuyandsell/viewobject/common/ps_value_holder.dart';
import 'package:flutterbuyandsell/viewobject/default_photo.dart';
import 'package:flutterbuyandsell/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import 'package:provider/provider.dart';

class AdsScreen extends StatelessWidget {
  AdsScreen({
    Key? key,
    required this.adsStatus,
    required this.title,
    this.coreTagKey,
    this.onTap,
    this.currentDefaultPhoto,
  }) : super(key: key);

  final String adsStatus;
  final String? coreTagKey;
  final Function? onTap;
  final String title;
  DefaultPhoto? currentDefaultPhoto;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return ChangeNotifierProvider<GetAdsProvider>(
        create: (BuildContext context) => GetAdsProvider()
          ..getAllItems(adsStatus: adsStatus, isConnectedToInternet: true),
        child: Consumer<GetAdsProvider>(
            builder: (BuildContext context, GetAdsProvider provider,
                    Widget? child) =>
                Scaffold(
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness:
                          Utils.getBrightnessForAppBar(context),
                    ),
                    backgroundColor: PsColors.backgroundColor,
                    iconTheme: Theme.of(context).iconTheme.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primaryDarkWhite),
                    title: Text(
                      Utils.getString(context, title),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Utils.isLightMode(context)
                              ? PsColors.primary500
                              : PsColors.primaryDarkWhite),
                    ),
                    elevation: 0,
                  ),
                  body: provider.isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: GridView.builder(
                          itemCount: provider.productListAdsItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.70,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                final ProductDetailIntentHolder holder =
                                    ProductDetailIntentHolder(
                                        productId: provider
                                            .productListAdsItems[index].id,
                                        heroTagImage: provider
                                                .productListAdsItems[index]
                                                .id! +
                                            PsConst.HERO_TAG__IMAGE,
                                        heroTagTitle: provider
                                                .productListAdsItems[index]
                                                .id! +
                                            PsConst.HERO_TAG__TITLE);
                                Navigator.pushNamed(
                                    context, RoutePaths.productDetail,
                                    arguments: holder);
                              },
                              child: GridTile(
                                header: Container(
                                  // height: 300,
                                  padding:
                                      const EdgeInsets.all(PsDimens.space8),
                                  child: Ink(
                                    color: PsColors.backgroundColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: PsDimens.space4,
                                      vertical: PsDimens.space8),
                                  decoration: BoxDecoration(
                                    color: PsColors.cardBackgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(PsDimens.space8)),
                                  ),

                                  // item data
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        if (valueHolder.isShowOwnerInfo!)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: PsDimens.space4,
                                              top: PsDimens.space4,
                                              right: PsDimens.space12,
                                              bottom: PsDimens.space4,
                                            ),

                                            //user name and date
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: PsDimens.space40,
                                                  height: PsDimens.space40,
                                                  child:
                                                      PsNetworkCircleImageForUser(
                                                    photoKey: '',

                                                    imagePath: provider
                                                        .productListAdsItems[
                                                            index]
                                                        .user
                                                        ?.userProfilePhoto,
                                                    // width: PsDimens.space40,
                                                    // height: PsDimens.space40,
                                                    boxfit: BoxFit.cover,
                                                    onTap: null,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width: PsDimens.space8),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .only(
                                                        bottom: PsDimens.space8,
                                                        top: PsDimens.space8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                  provider.productListAdsItems[index].user?.userName ==
                                                                          ''
                                                                      ? Utils.getString(
                                                                          context,
                                                                          'default__user_name')
                                                                      : '${provider.productListAdsItems[index].user?.userName}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1),
                                                            ),
                                                            if (provider
                                                                    .productListAdsItems[
                                                                        index]
                                                                    .user
                                                                    ?.isVerifyBlueMark ==
                                                                PsConst.ONE)
                                                              Container(
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    left: PsDimens
                                                                        .space2),
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: PsColors
                                                                      .bluemarkColor,
                                                                  size: valueHolder
                                                                      .bluemarkSize,
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                        if (provider
                                                                .productListAdsItems[
                                                                    index]
                                                                .paidStatus ==
                                                            PsConst
                                                                .PAID_AD_PROGRESS)
                                                          Text(
                                                              Utils.getString(
                                                                  context, 'paid_ad__sponsor'),
                                                              textAlign: TextAlign
                                                                  .start,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      color: PsColors
                                                                          .primary500))
                                                        else
                                                          Text('${provider.productListAdsItems[index].addedDateStr}',
                                                              textAlign: TextAlign
                                                                  .start,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        else
                                          Container(),
                                        SizedBox(
                                          height: 100,
                                          width: double.infinity,
                                          child: Stack(
                                            children: <Widget>[
                                              // item image
                                              Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          PsDimens.space6),
                                                  child: PsNetworkImage(
                                                    photoKey:
                                                        '$coreTagKey${PsConst.HERO_TAG__IMAGE}',
                                                    defaultPhoto: provider
                                                        .productListAdsItems[
                                                            index]
                                                        .defaultPhoto,
                                                    boxfit: BoxFit.cover,
                                                    height: PsDimens.space300,
                                                    width: double.infinity,
                                                    imageAspectRation:
                                                        PsConst.Aspect_Ratio_2x,
                                                    onTap: null,
                                                  ),
                                                ),
                                              ),
                                              // sold out container
                                              Positioned(
                                                  bottom: 1,
                                                  child: provider
                                                              .productListAdsItems[
                                                                  index]
                                                              .isSoldOut ==
                                                          '1'
                                                      ? Container(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right:
                                                                          20),
                                                              child: Text(
                                                                  Utils.getString(
                                                                      context,
                                                                      'dashboard__sold_out'),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                          color:
                                                                              PsColors.white)),
                                                            ),
                                                          ),
                                                          height: 30,
                                                          width:
                                                              PsDimens.space180,
                                                          decoration: BoxDecoration(
                                                              color: PsColors
                                                                  .soldOutUIColor),
                                                        )
                                                      : Container()),
                                            ],
                                          ),
                                        ),
                                        // item details
                                        Container(
                                          height: 88,
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space8,
                                              left: PsDimens.space8,
                                              right: PsDimens.space8,
                                              bottom: PsDimens.space4),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              // item name
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: PsHero(
                                                      tag:
                                                          '$coreTagKey$PsConst.HERO_TAG__TITLE',
                                                      child: Text(
                                                        provider
                                                            .productListAdsItems[
                                                                index]
                                                            .title!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  if (Utils.showUI(valueHolder
                                                      .conditionOfItemId))
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: PsDimens
                                                                  .space4,
                                                              right: PsDimens
                                                                  .space8),
                                                      child: Text(
                                                        '${provider.productListAdsItems[index].conditionOfItem!.name}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: PsColors
                                                                .textColor1),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              // item price
                                              Row(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      PsHero(
                                                        tag:
                                                            '$coreTagKey$PsConst.HERO_TAG__UNIT_PRICE',
                                                        flightShuttleBuilder: Utils
                                                            .flightShuttleBuilder,
                                                        child: Material(
                                                          type: MaterialType
                                                              .transparency,
                                                          child: Text(
                                                              provider.productListAdsItems[index].discountRate ==
                                                                          '0' ||
                                                                      provider.productListAdsItems[index].discountRate ==
                                                                          ''
                                                                  ? provider.productListAdsItems[index].price !=
                                                                              '0' &&
                                                                          provider.productListAdsItems[index].price !=
                                                                              ''
                                                                      ? '${provider.productListAdsItems[index].itemCurrency!.currencySymbol}${Utils.getPriceFormat(provider.productListAdsItems[index].price!, valueHolder.priceFormat!)}'
                                                                      : ''
                                                                  : '${provider.productListAdsItems[index].itemCurrency!.currencySymbol}${Utils.getPriceFormat(provider.productListAdsItems[index].discountedPrice!, valueHolder.priceFormat!)}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                      color: PsColors
                                                                          .textColor1,
                                                                      fontSize:
                                                                          16)),
                                                        ),
                                                      ),
                                                      Visibility(
                                                          maintainAnimation:
                                                              true,
                                                          maintainSize: true,
                                                          maintainState: true,
                                                          visible: provider
                                                                  .productListAdsItems[
                                                                      index]
                                                                  .discountRate !=
                                                              '0',
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '  ${provider.productListAdsItems[index].itemCurrency!.currencySymbol}${Utils.getPriceFormat(provider.productListAdsItems[index].price!, valueHolder.priceFormat!)}  ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2!
                                                                    .copyWith(
                                                                        color: Utils.isLightMode(context)
                                                                            ? PsColors
                                                                                .textPrimaryLightColor
                                                                            : PsColors
                                                                                .primaryDarkGrey,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                              const SizedBox(
                                                                  width: PsDimens
                                                                      .space6),
                                                              Text(
                                                                '-${provider.productListAdsItems[index].discountRate}%',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2!
                                                                    .copyWith(
                                                                        color: Utils.isLightMode(context)
                                                                            ? PsColors
                                                                                .textPrimaryLightColor
                                                                            : PsColors
                                                                                .primaryDarkGrey,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // item  location
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'assets/images/baseline_pin_black_24.png',
                                                          width:
                                                              PsDimens.space10,
                                                          height:
                                                              PsDimens.space10,
                                                          fit: BoxFit.contain,
                                                          color: PsColors
                                                              .textColor2,
                                                          // ),
                                                        ),
                                                        Expanded(
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left:
                                                                        PsDimens
                                                                            .space8,
                                                                    right: PsDimens
                                                                        .space8),
                                                                child: Text(
                                                                    valueHolder
                                                                                .isSubLocation ==
                                                                            PsConst
                                                                                .ONE
                                                                        ? (provider.productListAdsItems[index].itemLocationTownship!.townshipName != '' &&
                                                                                provider.productListAdsItems[index].itemLocationTownship!.townshipName !=
                                                                                    null)
                                                                            ? // check optional township is empty
                                                                            '${provider.productListAdsItems[index].itemLocationTownship!.townshipName}'
                                                                            : '${provider.productListAdsItems[index].itemLocation!.name}'
                                                                        : '${provider.productListAdsItems[index].itemLocation!.name}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption!
                                                                        .copyWith(
                                                                            color: PsColors.textColor3)))),
                                                      ],
                                                    ),
                                                  ),
                                                  if (Utils.showUI(
                                                      valueHolder.typeId))
                                                    Flexible(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left:
                                                                PsDimens.space8,
                                                          ),
                                                          child: Text(
                                                              '${provider.productListAdsItems[index].itemType!.name}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: PsColors
                                                                        .textColor2,
                                                                  ))),
                                                    )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                )));
  }
}
