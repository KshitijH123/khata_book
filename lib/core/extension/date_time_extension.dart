extension DateTimeX on DateTime {
  String get toStringMonth {
    switch (month) {
      case 1:
        return 'Jan $year';
      case 2:
        return 'Feb $year';
      case 3:
        return 'Mar $year';
      case 4:
        return 'Apr $year';
      case 5:
        return 'May $year';
      case 6:
        return 'Jun $year';
      case 7:
        return 'Jul $year';
      case 8:
        return 'Aug $year';
      case 9:
        return 'Sept $year';
      case 10:
        return 'Oct $year';
      case 11:
        return 'Nov $year';
      case 12:
        return 'Dec $year';
      default:
        return '$year';
    }
  }
}
