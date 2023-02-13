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

class Photo {
  final String id;
  final String eventName;
  final String imageId;
  final String url;
  final String userId;
  final int price;
  final String eventDate;
  late String identification;

  Photo(this.id, this.eventName, this.imageId, this.url, this.userId, this.price,
      this.eventDate, this.identification);

  //deserialization
  factory Photo.fromMap(Map<String, dynamic> json) {
    return Photo(
      json["picture"]["id"],
      json["picture"]["eventName"],
      json["picture"]["imageId"],
      json["picture"]["url"],
      json["picture"]["userId"],

      0,
      json["picture"]["eventDate"],
      json["picture"]["identification"],
    );
  }

  factory Photo.fromMap2(Map<String, dynamic> json) {
    return Photo(
      json["id"],
      json["eventName"],
      json["imageId"],
      json["url"],
      json["userId"],
      json["price"],
      json["eventDate"],
      json["identification"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "eventName": eventName,
        "imageId": imageId,
        "url": url,
        "userId": userId,
        "price": price,
        "eventDate": eventDate,
        "identification": identification,
      };

  //serialization
  @override
  String toString() {
    return "{ id: $id, eventName: $eventName, imageId: $imageId, url: $url,userId: $userId"
        "price: $price, eventDate: $eventDate, identification: $identification}";
  }
}
