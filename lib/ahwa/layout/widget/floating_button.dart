import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/common/widget/circualr_containers/circular_container_shadow.dart';
import '../../new_order/add_new_order.dart';

class FloatingWidget extends StatelessWidget {
  final Widget mainScreenWidget;
  const FloatingWidget({super.key, required this.mainScreenWidget});

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: mainScreenWidget,
      floatingWidget: GestureDetector(
        onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddNewOrder()),
        child: CircularContainerShadow(
          color: Colors.blue.withValues(alpha: .4),
          widget: Icon(Iconsax.additem_copy, color: Colors.white),
        ),
      ),
      floatingWidgetWidth: 60,
      floatingWidgetHeight: 60,
    );
  }
}
