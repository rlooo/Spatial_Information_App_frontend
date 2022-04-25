import 'package:firebase_database/firebase_database.dart';

class PutOutBoard {
  var id;
  var author; //수정
  var name;
  var contact;
  var area;
  var floor;
  var deposit;
  var price;
  var discussion;
  var client;
  var sort;
  var count;
  var range;
  var images;
  var facility;
  var latitude;
  var longitude;
  var address;
  var created_at;

  PutOutBoard(
      {this.id,
      this.author,
      this.name,
      this.contact,
      this.area,
      this.floor,
      this.deposit,
      this.price,
      this.discussion,
      this.client,
      this.sort,
      this.count,
      this.range,
      this.facility,
      this.images,
      this.latitude,
      this.longitude,
      this.address,
      this.created_at});

  factory PutOutBoard.fromJson(Map<String, dynamic> json) {
    return PutOutBoard(
      id: json['id'],
      author: json['author'],
      name: json['name'],
      contact: json['contact'],
      area: json['area'],
      floor: json['floor'],
      deposit: json['deposit'],
      price: json['price'],
      discussion: json['discussion'],
      client: json['client'],
      sort: json['sort'],
      count: json['count'],
      range: json['range'],
      facility: json['facility'],
      images: json['images'],
      latitude: json['kakaoLatitude'],
      longitude: json['kakaoLongitude'],
      address: json['address'],
      created_at: json['created_at'],
    );
  }

  toJson() => {
        'id': id,
        'author': author,
        'name': name,
        'contact': contact,
        'area': area,
        'floor': floor,
        'deposit': deposit,
        'price': price,
        'discussion': discussion,
        'client': client,
        'sort': sort,
        'count': count,
        'range': range,
        'facility': facility,
        'images': images,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'created_at': created_at,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'name': name,
      'contact': contact,
      'area': area,
      'floor': floor,
      'deposit': deposit,
      'price': price,
      'discussion': discussion,
      'client': client,
      'sort': sort,
      'count': count,
      'range': range,
      'facility': facility,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'created_at': created_at,
    };
  }
}
