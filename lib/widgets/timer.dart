class TimeLeft {
  static String timeLeft(DateTime due) {
    String retVal;

    Duration _timeUntilDue = due.difference(DateTime.now());

    int _daysUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    int _secUntil = _timeUntilDue.inSeconds -
        (_daysUntil * 24 * 60 * 60) -
        (_hoursUntil * 60 * 60) -
        (_minUntil * 60);
// one dev to role the all

    if (_daysUntil > 0) {
      retVal = _daysUntil.toString() + "d "+_hoursUntil.toString() +'h';
    } else if (_hoursUntil > 0) {
      retVal = _hoursUntil.toString() +
          "h " +
          _minUntil.toString() +
          "m"  ;
    } else if (_minUntil > 0) {
      retVal =_minUntil.toString()+ "m " + _secUntil.toString()+"s" ;
    } else if (_secUntil > 0) {
      retVal = _secUntil.toString() + " sec ";
    } else if (_secUntil == 0) {
      retVal ='Finished';
    } else {
      retVal = "Finished";
    }

    return retVal;
  }
}





