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

  var platArea; //대지면적
  var archArea; //건축면적
  var bcRat; //건폐율
  var vlRat; //용적률
  var grndFlrCnt; //지상층수
  var ugrndFlrCnt; //지하층수
  var mainPurpsCdNm; //주용도
  var etcPurps; //기타용도
  var strctCdNm; //구조
  var totPkngCnt; //총주차수

  PutOutBoard({
    this.id,
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
    this.created_at,
    this.platArea, //대지면적
    this.archArea, //건축면적
    this.bcRat, //건폐율
    this.vlRat, //용적률
    this.grndFlrCnt, //지상층수
    this.ugrndFlrCnt, //지하층수
    this.mainPurpsCdNm, //주용도
    this.etcPurps, //기타용도
    this.strctCdNm, //구조
    this.totPkngCnt, //총주차수
  });

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
      platArea: json['platArea'],
      archArea: json['archArea'],
      bcRat: json['bcRat'],
      vlRat: json['vlRat'],
      grndFlrCnt: json['grndFlrCnt'],
      ugrndFlrCnt: json['ugrndFlrCnt'],
      mainPurpsCdNm: json['mainPurpsCdNm'],
      etcPurps: json['etcPurps'],
      strctCdNm: json['strctCdNm'],
      totPkngCnt: json['totPkngCnt'],
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
        'platArea': platArea,
        'archArea': archArea,
        'bcRat': bcRat,
        'vlRat': vlRat,
        'grndFlrCnt': grndFlrCnt,
        'ugrndFlrCnt': ugrndFlrCnt,
        'mainPurpsCdNm': mainPurpsCdNm,
        'etcPurps': etcPurps,
        'strctCdNm': strctCdNm,
        'totPkngCnt': totPkngCnt,
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
      'platArea': platArea,
      'archArea': archArea,
      'bcRat': bcRat,
      'vlRat': vlRat,
      'grndFlrCnt': grndFlrCnt,
      'ugrndFlrCnt': ugrndFlrCnt,
      'mainPurpsCdNm': mainPurpsCdNm,
      'etcPurps': etcPurps,
      'strctCdNm': strctCdNm,
      'totPkngCnt': totPkngCnt,
    };
  }
}
