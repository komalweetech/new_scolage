import '../constant/asset_icons.dart';

enum StatusType {
  success,
  error,
  info,
}

enum BottomNavBarMenuEnum {
  home(
      iconLink: AssetIcons.HOME_ICON,
      selectedIconLink: AssetIcons.SELECTED_HOME_ICON,
      displayName: "Home"),
  pretest(
      iconLink: AssetIcons.PRETEST_ICON,
      selectedIconLink: AssetIcons.SELECTED_PRETEST_ICON,
      displayName: "Pretest"),
  favorite(
      iconLink: AssetIcons.BOTTOM_NAV_BAR_FAVORITE_ICON,
      selectedIconLink: AssetIcons.SELECTED_FAVORITE_ICON,
      displayName: "Favorite"),
  offers(
      iconLink: AssetIcons.OFFERS_ICON,
      selectedIconLink: AssetIcons.SELECTED_OFFERS_ICON,
      displayName: "Offers"),
  needHelp(
      iconLink: AssetIcons.BOTTOM_NAV_BAR_NEED_HELP_ICON,
      selectedIconLink: AssetIcons.SELECTED_BOTTOM_NAV_BAR_NEED_HELP_ICON,
      displayName: "Need Help");

  final String displayName;
  final String iconLink;
  final String selectedIconLink;

  const BottomNavBarMenuEnum(
      {required this.displayName,
      required this.iconLink,
      required this.selectedIconLink});
}

enum ParentsOrStudentEnum {
  parents(
    displayName: "Parents",
  ),
  student(
    displayName: "Student",
  );

  final String displayName;
  const ParentsOrStudentEnum({
    required this.displayName,
  });
}

enum InviteScreenTabEnum {
  invite(
    displayName: "Invite",
  ),
  faq(
    displayName: "FAQ",
  );

  final String displayName;
  const InviteScreenTabEnum({
    required this.displayName,
  });
}
