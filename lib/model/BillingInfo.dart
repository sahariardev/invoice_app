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
