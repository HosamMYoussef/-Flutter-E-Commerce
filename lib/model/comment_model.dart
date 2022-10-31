class CommentModel {
  late String productId, details, name, pic,date;
  String?rating;

  CommentModel({
    required this.productId,
    required this.details,
    required this.name,
    required this.pic,
    required this.date,
     this.rating,
  });

  CommentModel.fromJson(Map<dynamic, dynamic> map) {
    productId = map['productId'];
    details = map['details'];
    name = map['name'];
    pic = map['pic'];
    date = map['date'];
    rating = map['rating'];
  }

  toJson() {
    return {
      'productId': productId,
      'details': details,
      'name': name,
      'pic': pic,
      'date': date,
      'rating': rating,
    };
  }
}