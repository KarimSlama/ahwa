import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_strings.dart';

class OrderDrinksDropdownMenu extends StatelessWidget {
  final String? selectedDrink;
  final ValueChanged<String?> onChanged;
  final List<String> drinks;

  const OrderDrinksDropdownMenu({
    super.key,
    required this.selectedDrink,
    required this.onChanged,
    required this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: Icon(Iconsax.arrow_bottom_copy),
      decoration: InputDecoration(
        prefixIcon: Icon(Iconsax.coffee_copy, color: Colors.grey),
        hintText: AppStrings.chooseDrink,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.black87.withValues(alpha: .4), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.black87.withValues(alpha: .4), width: 1),
        ),
      ),
      value: selectedDrink,
      onChanged: onChanged,
      items: drinks.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
