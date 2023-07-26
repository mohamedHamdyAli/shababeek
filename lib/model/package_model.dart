class PackageModel {
  PackageModel({
    this.packageId,
    this.title,
    this.price,
    this.currencyId,
    this.postCount,
    this.packageInAppPurchasedPrdId,
    this.type,
    this.status,
    this.addedDate,
    this.addedDateStr,
    this.currency,
  });

  String? packageId;
  String? title;
  String? price;
  String? currencyId;
  String? postCount;
  String? packageInAppPurchasedPrdId;
  String? type;
  String? status;
  DateTime? addedDate;
  String? addedDateStr;
  Currency? currency;

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        packageId: json['package_id'],
        title: json['title'],
        price: json['price'],
        currencyId: json['currency_id'],
        postCount: json['post_count'],
        packageInAppPurchasedPrdId: json['package_in_app_purchased_prd_id'],
        type: json['type'],
        status: json['status'],
        addedDate: DateTime.parse(json['added_date']),
        addedDateStr: json['added_date_str'],
        currency: Currency.fromJson(json['currency']),
      );
}

class Currency {
  Currency({
    this.id,
    this.currencyShortForm,
    this.currencySymbol,
    this.status,
    this.isDefault,
    this.addedDate,
  });

  String? id;
  String? currencyShortForm;
  String? currencySymbol;
  String? status;
  String? isDefault;
  DateTime? addedDate;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json['id'],
        currencyShortForm: json['currency_short_form'],
        currencySymbol: json['currency_symbol'],
        status: json['status'],
        isDefault: json['is_default'],
        addedDate: DateTime.parse(json['added_date']),
      );
}
