import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutterbuyandsell/api/common/ps_resource.dart';
import 'package:flutterbuyandsell/api/common/ps_status.dart';
import 'package:flutterbuyandsell/api/ps_api_service.dart';
import 'package:flutterbuyandsell/model/package_model.dart';
import 'package:flutterbuyandsell/viewobject/package.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';

class GetAdsProvider extends ChangeNotifier {
  final PsApiService _psApiService = PsApiService();
  bool isLoading = false;
  final List<Product> productListAdsItems = <Product>[];
  final List<Package> packageList = <Package>[];

  Future<dynamic> getAllItems({
    // required StreamController<PsResource<Product>> itemDetailStream,
    required bool isConnectedToInternet,
    required String adsStatus,
  }) async {
    isLoading = true;
    notifyListeners();
    if (isConnectedToInternet) {
      final PsResource<List<Product>> _resource =
          await _psApiService.getAllItems(adsStatus: adsStatus);

      if (_resource.status == PsStatus.SUCCESS) {
        // Create Map List
        print('mohamealy' + productListAdsItems.length.toString());

        int i = 0;
        for (Product data in _resource.data!) {
          productListAdsItems.add(data);
        }
        print('mohamealy2' + productListAdsItems.length.toString());
      }
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getAllPackage({
    // required StreamController<PsResource<Product>> itemDetailStream,
    required bool isConnectedToInternet,
    required String adsStatus,
  }) async {
    isLoading = true;
    notifyListeners();
    if (isConnectedToInternet) {
      final PsResource<List<Package>> _resource =
          await _psApiService.getAllpackages();

      if (_resource.status == PsStatus.SUCCESS) {
        // Create Map List
        print('mohamealy' + packageList.length.toString());

        int i = 0;
        for (Package data in _resource.data!) {
          packageList.add(data);
        }
        print('mohamealy2' + packageList.length.toString());
      }
      isLoading = false;
      notifyListeners();
    }
  }
}
