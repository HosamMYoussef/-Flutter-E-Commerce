class CommentModel {
  late String productId, details, name, pic,date;

  CommentModel({
    required this.productId,
    required this.details,
    required this.name,
    required this.pic,
    required this.date,
  });

  CommentModel.fromJson(Map<dynamic, dynamic> map) {
    productId = map['productId'];
    details = map['details'];
    name = map['name'];
    pic = map['pic'];
    date = map['date'];
  }

  toJson() {
    return {
      'productId': productId,
      'details': details,
      'name': name,
      'pic': pic,
      'date': date,
    };
  }
}