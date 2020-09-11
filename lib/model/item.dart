import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable(nullable: false)
class Item {
  String _name;
  String _description;
  int _cost;
  int _qty;

  Item() {}

  Item.fromOld(Item item) {
    _name = item.name;
    _description = item.description;
    _cost = item.cost;
    _qty = item.qty;
  }

  Item.fromJSON(Map<String, dynamic> json) {
    _name = json["name"];
    _description = json["description"];
    _cost = json["cost"];
    _qty = json["qty"];
  }
  static fromJsonList(List<dynamic> json){

    List<Item> items = new List();
    for(dynamic i in json){
      items.add(Item.fromJson(i as Map<String, dynamic>));
    }
    return items;
  }
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

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

  int get total => cost * qty;

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

  getIndex(int row,int index) {
    switch (index) {
      case 0:
        return (row+1).toString();
      case 1:
        return description;
      case 2:
        return cost.toString();
      case 3:
        return qty.toString();
      case 4:
        return total.toString();
    }
  }

  @override
  String toString() {
    return 'Item{_name: $_name, _description: $_description, _cost: $_cost, _qty: $_qty}';
  }
}
