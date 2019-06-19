class OrderData {
  String sId;
  String userId;
  String restaurantId;
  List<Items> items;
  int totalAmount;
  int totalItems;
  String orderedOnRaw;
  String orderedOn;
  int preprationTime;
  String status;

  OrderData(
      {this.sId,
      this.userId,
      this.restaurantId,
      this.items,
      this.totalAmount,
      this.totalItems,
      this.orderedOnRaw,
      this.orderedOn,
      this.preprationTime,
      this.status});

  OrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    restaurantId = json['restaurantId'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    totalItems = json['total_items'];
    orderedOnRaw = json['ordered_on_raw'];
    orderedOn = json['ordered_on'];
    preprationTime = json['prepration_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['restaurantId'] = this.restaurantId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['total_items'] = this.totalItems;
    data['ordered_on_raw'] = this.orderedOnRaw;
    data['ordered_on'] = this.orderedOn;
    data['prepration_time'] = this.preprationTime;
    data['status'] = this.status;
    return data;
  }
}

class Items {
  String sId;
  String name;
  String imageUrl;
  int price;
  int quantity;

  Items({this.sId, this.name, this.imageUrl, this.price, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
