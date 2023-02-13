/*
{
  id: "",
  eventName: "",
  imageId: "",
  url: "",
  price: "",
  eventDate: "",
  identification: "",
}
*/

class Event {
  final String eventName;
  final String eventDate;
   final String photographer;

  Event(this.eventName, this.eventDate, this.photographer);

  //deserialization
  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
      json["eventName"],
      json["eventDate"],
      json["user"]["name"],
    );
  }
  Map<String, dynamic> toJson() => {
        "eventName": eventName,
        "eventDate": eventDate,
        "photographer": photographer,
      };

  String geteventName() {
    return eventName;
  }

  // String dateskds() {
  //  DateTime dt =  DateTime.parse(eventDate);

  // }

  //serialization
  @override
  String toString() {
    return ' $eventName ';
  }
}
