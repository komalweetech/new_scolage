import '../constant/asset_icons.dart';

// TAB VIEW ENUM
enum NearbyScreenTabEnum {
  // sort(iconLink: AssetIcons.DROP_DOWN_ICON, displayName: "Sort"),
  area(iconLink: AssetIcons.DROP_DOWN_ICON, displayName: "Area"),
  fees(iconLink: AssetIcons.DROP_DOWN_ICON, displayName: "Fees"),
  trending(iconLink: AssetIcons.DROP_DOWN_ICON, displayName: "Trending");

  final String displayName;
  final String iconLink;

  const NearbyScreenTabEnum({
    required this.displayName,
    required this.iconLink,
  });
}


// SORT BY ENUM
enum SortByEnum {
  popularity(
      iconLink: AssetIcons.SORT_BY_POPULARITY_ICON, displayName: "Popularity"),
  nearby(iconLink: AssetIcons.SORT_BY_NEARBY_ICON, displayName: "Nearby"),
  rating(iconLink: AssetIcons.SORT_BY_RATING_ICON, displayName: "Rating"),
  priceLowToHigh(
      iconLink: AssetIcons.SORT_BY_PRICE_LOW_TO_HIGH_ICON,
      displayName: "Price - low to high"),
  priceHighToLow(
      iconLink: AssetIcons.SORT_BY_PRICE_HIGH_TO_LOW_ICON,
      displayName: "Price - high to low");

  final String displayName;
  final String iconLink;

  const SortByEnum({
    required this.displayName,
    required this.iconLink,
  });
}

// FEE RANGE ENUM
enum FeesRangeEnum {
  f10000To20000(startValue: 10000, endValue: 20000, displayName: "10000-20000"),
  f20000To35000(startValue: 20000, endValue: 35000, displayName: "20000-35000"),
  f35000To55000(startValue: 35000, endValue: 55000, displayName: "35000-55000"),
  f55000To85000(startValue: 55000, endValue: 85000, displayName: "55000-85000"),
  f85000To1Lakh(startValue: 85000, endValue: 100000, displayName: "85000-100000"),
  f1LakhTo5Lakh(startValue: 100000, endValue: 500000, displayName: "100000-500000");

  final String displayName;
  final double startValue;
  final double endValue;

  const FeesRangeEnum({
    required this.displayName,
    required this.startValue,
    required this.endValue,
  });
}
