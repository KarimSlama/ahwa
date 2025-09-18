class DrinksModel {
  final int? _id;
  final String _name;
  final double _price;
  final bool _isAvailable;
  final DateTime _createdAt;

  DrinksModel({
    int? id,
    required String name,
    required double price,
    bool isAvailable = true,
    DateTime? createdAt,
  })  : _id = id,
        _name = name,
        _price = price,
        _isAvailable = isAvailable,
        _createdAt = createdAt ?? DateTime.now();

  int? get id => _id;
  String get name => _name;
  double get price => _price;
  bool get isAvailable => _isAvailable;
  DateTime get createdAt => _createdAt;

  factory DrinksModel.fromJson(Map<String, dynamic> json) {
    return DrinksModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      isAvailable: json['is_available'] == 1,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': _name,
      'price': _price,
      'is_available': _isAvailable ? 1 : 0,
      'created_at': _createdAt.toIso8601String(),
    };
    if (_id != null) data['id'] = _id;
    return data;
  }

  @override
  String toString() => '$_name (${_price}ج)';
}
