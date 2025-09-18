enum OrderStatus { pending, completed, cancelled }

class OrdersModel {
  final int? _id;
  final String _orderId;
  final String _customerName;
  final OrderStatus _status;
  final String _notes;
  final double _total;
  final DateTime _createdAt;
  final DateTime? _completedAt;

  OrdersModel({
    int? id,
    required String orderId,
    required String customerName,
    OrderStatus status = OrderStatus.pending,
    String notes = '',
    required double total,
    required DateTime createdAt,
    DateTime? completedAt,
  })  : _id = id,
        _orderId = orderId,
        _customerName = customerName,
        _status = status,
        _notes = notes,
        _total = total,
        _createdAt = createdAt,
        _completedAt = completedAt;

  int? get id => _id;
  String get orderId => _orderId;
  String get customerName => _customerName;
  OrderStatus get status => _status;
  String get notes => _notes;
  double get total => _total;
  DateTime get createdAt => _createdAt;
  DateTime? get completedAt => _completedAt;

  bool get isPending => _status == OrderStatus.pending;
  bool get isCompleted => _status == OrderStatus.completed;

  OrdersModel copyWith({OrderStatus? status, DateTime? completedAt}) {
    return OrdersModel(
      id: _id,
      orderId: _orderId,
      customerName: _customerName,
      status: status ?? _status,
      notes: _notes,
      total: _total,
      createdAt: _createdAt,
      completedAt: completedAt ?? _completedAt,
    );
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'],
      orderId: json['order_id'],
      customerName: json['customer_name'],
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      notes: json['notes'] ?? '',
      total: (json['total'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'order_id': _orderId,
      'customer_name': _customerName,
      'status': _status.name,
      'notes': _notes,
      'total': _total,
      'created_at': _createdAt.toIso8601String(),
      'completed_at': _completedAt?.toIso8601String(),
    };
    if (_id != null) data['id'] = _id;
    return data;
  }
}
