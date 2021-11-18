class Flight {
  static String table = 'todo';

  int id;
  String flightNumber;
  String airlineCode;
  String departureCode;
  String arrivalCode;
  String departureTime;
  String arrivalTime;

  Flight({
    required this.id,
    required this.flightNumber,
    required this.airlineCode,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'flightNumber': flightNumber,
      'airlineCode': airlineCode,
      'departureCode': departureCode,
      'arrivalCode': arrivalCode,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
    return map;
  }

  static Flight fromMap(Map<String, dynamic> map) {
    print(map.toString());
    return Flight(
        id: map['id'],
        flightNumber: map['flightNumber'].toString(),
        airlineCode: map['airlineCode'].toString(),
        departureCode: map['departureCode'].toString(),
        arrivalCode: map['arrivalCode'].toString(),
        departureTime: map['departureTime'].toString(),
        arrivalTime: map['arrivalTime'].toString());
  }
}
