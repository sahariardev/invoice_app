class Invoice {
  int _id;
  DateTime _dateIssued;
  DateTime _dateDued;
  String _jobDescription;

  Invoice(){

  }

  Invoice.fromOld(Invoice old){
    _id = old.id;
    _dateIssued = old.dateIssued;
    _dateDued = old.dateDued;
    _jobDescription = old.jobDescription;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get dateIssued => _dateIssued;

  String get jobDescription => _jobDescription;

  set jobDescription(String value) {
    _jobDescription = value;
  }

  DateTime get dateDued => _dateDued;

  set dateDued(DateTime value) {
    _dateDued = value;
  }

  set dateIssued(DateTime value) {
    _dateIssued = value;
  }


  @override
  String toString() {
    return 'Invoice{_id: $_id, _dateIssued: $_dateIssued, _dateDued: $_dateDued, _jobDescription: $_jobDescription}';
  }
}
