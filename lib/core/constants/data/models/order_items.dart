class OrderItems {
  final int? _id;
  final int _orderId;
  final int _drinkId;
  final String _drinkName;
  final int _quantity;
  final double _unitPrice;
  final double _subtotal;
  final String _notes;
  final DateTime _createdAt;

  OrderItems({
    int? id,
    required int orderId,
    required int drinkId,
    required String drinkName,
    required int quantity,
    required double unitPrice,
    String notes = '',
    DateTime? createdAt,
  })  : _id = id,
        _orderId = orderId,
        _drinkId = drinkId,
        _drinkName = drinkName,
        _quantity = quantity,
        _unitPrice = unitPrice,
        _subtotal = quantity * unitPrice,
        _notes = notes,
        _createdAt = createdAt ?? DateTime.now();

  int? get id => _id;
  int get orderId => _orderId;
  int get drinkId => _drinkId;
  String get drinkName => _drinkName;
  int get quantity => _quantity;
  double get unitPrice => _unitPrice;
  double get subtotal => _subtotal;
  String get notes => _notes;
  DateTime get createdAt => _createdAt;

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      id: json['id'],
      orderId: json['order_id'],
      drinkId: json['drink_id'],
      drinkName: json['drink_name'],
      quantity: json['quantity'],
      unitPrice: (json['unit_price'] as num).toDouble(),
      notes: json['notes'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'order_id': _orderId,
      'drink_id': _drinkId,
      'drink_name': _drinkName,
      'quantity': _quantity,
      'unit_price': _unitPrice,
      'subtotal': _subtotal,
      'notes': _notes,
      'created_at': _createdAt.toIso8601String(),
    };
    if (_id != null) data['id'] = _id;
    return data;
  }
}
