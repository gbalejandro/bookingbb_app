// To parse this JSON data, do
//
//     final reservation = reservationFromMap(jsonString);

import 'dart:convert';

class Reservation {
    bool available;
    String name;
    String? picture;
    double price;
    String? id;

    Reservation({
        required this.available,
        required this.name,
        this.picture,
        required this.price,
        this.id
    });

    factory Reservation.fromJson(String str) => Reservation.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Reservation.fromMap(Map<String, dynamic> json) => Reservation(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };

    Reservation copy() => Reservation(
      available: this.available,
      name: this.name,
      picture: this.picture,
      price: this.price,
      id: this.id,
    );

}
