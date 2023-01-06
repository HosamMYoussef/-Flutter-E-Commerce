import 'package:flutter/material.dart';

import '../helper/hexColor_extension.dart';

class AuctionModel {
  late String name, image, description,  price, auctionId, category,end,start,bids;

  late String type ;
  late String condition ;


 

  AuctionModel({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.auctionId,
    required this.category,
    required this.condition,
   required this.type ,
    required this.end ,
    required this.start,
    required this.bids ,
  });

  AuctionModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    auctionId = map['auctionId'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    category = map['category'];
    condition = map['condition'];
    bids = map['bids'];
    start = map['start'];
    end = map['end'];
    type = map['type'];


  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'description': description,
      'price': price,
      'type': type,
      'bids': bids,
      'start': start,
      'end': end,
      'condition': condition,
      'auctionId': auctionId,
    };
  }
}
