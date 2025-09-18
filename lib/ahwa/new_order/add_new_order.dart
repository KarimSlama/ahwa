import 'package:ahwa/core/constants/data/database/database_operations_service/drinks_operations_service_impl.dart';
import 'package:ahwa/core/constants/data/database/database_operations_service/orders_operations_service_impl.dart';
import 'package:ahwa/core/constants/data/database/initialize_data_methods/local_database_helper.dart';
import 'package:ahwa/core/constants/data/repository/order_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/common/widget/heading/section_heading.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/data/models/drinks_model.dart';
import '../../core/constants/data/models/orders_model.dart';
import '../../core/constants/data/repository/drinks_repository.dart';
import '../layout/widget/order_drinks_dropdown_menu.dart';
import '../layout/widget/order_text_form_field.dart';

class AddNewOrder extends StatefulWidget {
  const AddNewOrder({super.key});

  @override
  State<AddNewOrder> createState() => _AddNewOrderState();
}

class _AddNewOrderState extends State<AddNewOrder> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customNotesController = TextEditingController();
  String? _selectedDrink;
  List<DrinksModel> drinks = [];
  bool _isLoading = false;

  late DrinksRepository drinksRepository;
  late OrderRepository orderRepository;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customNotesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await LocalDatabaseHelper().initDatabase();

      drinksRepository =
          DrinksRepository(DrinksDatabaseServiceImpl(LocalDatabaseHelper()));
      orderRepository =
          OrderRepository(OrdersDatabaseServiceImpl(LocalDatabaseHelper()));

      final loadedDrinks = await drinksRepository.getAllDrinks();

      setState(() {
        drinks = loadedDrinks;
        if (_selectedDrink == null && drinks.isNotEmpty) {
          _selectedDrink = drinks.first.name;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitOrder() async {
    if (_customerNameController.text.trim().isEmpty) {
      _showErrorMessage("من فضلك ادخل اسم الزبون");
      return;
    }

    if (_selectedDrink == null || _selectedDrink!.isEmpty) {
      _showErrorMessage("من فضلك اختر مشروب");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final drink = drinks.firstWhereOrNull((d) => d.name == _selectedDrink);

    if (drink == null) {
      _showErrorMessage("المشروب المختار غير موجود");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final newOrder = OrdersModel(
      customerName: _customerNameController.text.trim(),
      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
      status: OrderStatus.pending,
      notes: _customNotesController.text.trim(),
      total: drink.price.toDouble(),
      createdAt: DateTime.now(),
    );

    await orderRepository.addOrder(newOrder);

    _showSuccessMessage("تم إضافة الطلب بنجاح🎉");

    _clearForm();

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearForm() {
    _customerNameController.clear();
    _customNotesController.clear();
    setState(() {
      _selectedDrink = drinks.isNotEmpty ? drinks.first.name : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeading(title: AppStrings.newOrder),
                const SizedBox(height: 24),
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else ...[
                  OrderTextFormField(
                    controller: _customerNameController,
                    hintText: AppStrings.customerName,
                    prefixIcon: Iconsax.profile_2user,
                  ),
                  const SizedBox(height: 16),
                  if (drinks.isNotEmpty)
                    OrderDrinksDropdownMenu(
                      selectedDrink: _selectedDrink,
                      drinks: drinks.map((d) => d.name).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDrink = newValue;
                        });
                      },
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: const Text(
                        'لا توجد مشروبات متاحة حاليا',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  const SizedBox(height: 16),
                  OrderTextFormField(
                    controller: _customNotesController,
                    hintText: AppStrings.customNotes,
                    prefixIcon: Iconsax.note_1_copy,
                    maxLines: 4,
                    maxLength: 200,
                  ),
                  const SizedBox(height: 24),
                  if (_selectedDrink != null && drinks.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'سعر المشروب:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${drinks.firstWhereOrNull((d) => d.name == _selectedDrink)?.price ?? 0} جنيه',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: drinks.isEmpty ? null : _submitOrder,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              AppStrings.submit,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
