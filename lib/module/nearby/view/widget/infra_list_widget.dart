
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../dependencies/nearby_dependencies.dart';
import '../../model/infrastructure_model.dart';
import 'infra_chip.dart';

class InfraListWidget extends StatefulWidget {
  const InfraListWidget({super.key,this.onInfraSelected});
  final void  Function(String)? onInfraSelected;

  @override
  State<InfraListWidget> createState() => _InfraListWidgetState();
}

class _InfraListWidgetState extends State<InfraListWidget> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14.w,
      runSpacing: 14.h,
      children: List.generate(
        kNearbyController.infrastructureList.length, (index) {
          InfrastructureModel data = kNearbyController.infrastructureList[index];
          return InfraChip(
            infraData: data,
            // onTap: () {
            //   setState(() {
            //     if (_selectedInfrastructures.contains(data.name)) {
            //       _selectedInfrastructures.remove(data.name);
            //     } else {
            //       _selectedInfrastructures.add(data.name);
            //     }
            //     print("selected infra list == $_selectedInfrastructures");
            //   });
            //   widget.onInfraSelected?.call(_selectedInfrastructures.toString());
            // },
            // isSelected: _selectedInfrastructures.contains(data.name),
            onTap: () {
              // Deselect the previously selected item
              if (kNearbyController.selectedInfrastructureList.isNotEmpty) {
                kNearbyController.selectedInfrastructureList.clear();
              }

              // Toggle the current item's selection
              if (!kNearbyController.selectedInfrastructureList.contains(data)) {
                kNearbyController.selectedInfrastructureList.add(data);
              }

              print(kNearbyController.selectedInfrastructureList.first.name);

              setState(() {});
              widget.onInfraSelected?.call(data.name);
            },
            isSelected: kNearbyController.selectedInfrastructureList.contains(data),
          );

          // return InfraChip(
          //   infraData: data,
          //   onTap: () {
          //     if (kNearbyController.selectedInfrastructureList.contains(data)) {
          //       // REMOVE FROM LIST
          //       kNearbyController.selectedInfrastructureList.remove(data);
          //     } else {
          //       // ADD TO LIST
          //       kNearbyController.selectedInfrastructureList.add(data);
          //     }
          //     setState(() {});
          //   },
          //   isSelected:
          //       kNearbyController.selectedInfrastructureList.contains(data),
          // );
        },
      ),
    );
  }
}
