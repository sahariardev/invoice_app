class Invoice {
  int _id;
  DateTime _dateIssued = DateTime.now();
  DateTime _dateDue=DateTime.now();
  String _jobDescription;

  Invoice(){

  }

  Invoice.fromOld(Invoice old){
    _id = old.id;
    _dateIssued = old.dateIssued;
    _dateDue = old.dateDue;
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

  DateTime get dateDue => _dateDue;

  set dateDue(DateTime value) {
    _dateDue = value;
  }

  set dateIssued(DateTime value) {
    _dateIssued = value;
  }


  @override
  String toString() {
    return 'Invoice{_id: $_id, _dateIssued: $_dateIssued, _dateDued: $_dateDue, _jobDescription: $_jobDescription}';
  }
}
