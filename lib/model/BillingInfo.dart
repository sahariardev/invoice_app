import 'package:json_annotation/json_annotation.dart';

part 'BillingInfo.g.dart';

@JsonSerializable(nullable: false)
class BillingInfo {
  String _name="";
  String _country="";
  String _address="";
  String _email="";
  String _phone="";

  BillingInfo(){}

  BillingInfo.fromOld(BillingInfo old) {
    if(old != null){
      _name = old.name;
      _country = old.country;
      _address = old.address;
      _email = old.email;
      _phone = old.phone;
    }
  }

  BillingInfo.fromJSON(Map<String, dynamic> json){
    _name = json["name"];
    _country = json["country"];
    _address = json["address"];
    _email = json["email"];
    _phone = json["phone"];
  }

  factory BillingInfo.fromJson(Map<String, dynamic> json) => _$BillingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BillingInfoToJson(this);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get country => _country;

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  set country(String value) {
    _country = value;
  }

  @override
  String toString() {
    return '$name \n $email \n $phone \n $address, $country';
  }
}
