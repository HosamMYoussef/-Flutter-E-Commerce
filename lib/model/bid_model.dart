class BidModel {
  late String auctionId, price,userId;

  BidModel({
    required this.auctionId,
    required this.price,
    required this.userId,
  });

  BidModel.fromJson(Map<dynamic, dynamic> map) {
    auctionId = map['auctionId'];
    price = map['price'];
    userId = map['userId'];
   
  }

  toJson() {
    return {
      'auctionId': auctionId,
      'price': price,
      'userId': userId,
     
    };
  }
}