class Item {
  String _name;
  String _description;
  int _cost;
  int _qty;

  Item() {}

  Item.fromOld(Item item){
    _name = item.name;
    _description = item.description;
    _cost = item.cost;
    _qty = item.qty;
  }

  int get qty => _qty;

  set qty(int value) {
    _qty = value;
  }

  int get cost => _cost;

  set cost(int value) {
    _cost = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _cost == other._cost &&
          _qty == other._qty;

  @override
  int get hashCode =>
      _name.hashCode ^ _description.hashCode ^ _cost.hashCode ^ _qty.hashCode;
}
