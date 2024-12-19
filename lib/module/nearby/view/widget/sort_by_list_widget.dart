import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_scolage/module/nearby/view/widget/sort_by_bottom_sheet.dart';

import '../../../../utils/enum/nearby_screen_enum.dart';
import '../../dependencies/nearby_dependencies.dart';

class ShortByListWidget extends StatelessWidget {
  const ShortByListWidget({super.key, required this.isOpenFromAllFilter});

  final bool isOpenFromAllFilter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
      isOpenFromAllFilter ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: isOpenFromAllFilter,
      itemCount: SortByEnum.values.length,
      itemBuilder: (context, index) {
        SortByEnum data = SortByEnum.values[index];
        return Obx(
              () => SortByBottomSheetListTile(
            isSelected: kNearbyController.selectedSortBy.value == data,
            name: data.displayName,
            icon: data.iconLink,
            onTap: () {
              kNearbyController.selectedSortBy.value = data;
              if (isOpenFromAllFilter == false) {
                kNearbyController.reloadCollegesData();
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }
}
