class RestaurantData {
  String sId;
  String name;
  String imageUrl;
  double latitude;
  double longitude;
  List<String> attributes;
  String opensAt;
  String closesAt;
  bool acceptingOrders;

  RestaurantData(
      {this.sId,
      this.name,
      this.imageUrl,
      this.latitude,
      this.longitude,
      this.attributes,
      this.opensAt,
      this.closesAt,
      this.acceptingOrders});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    attributes = json['attributes'].cast<String>();
    opensAt = json['opensAt'];
    closesAt = json['closesAt'];
    acceptingOrders = json['accepting_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['attributes'] = this.attributes;
    data['opensAt'] = this.opensAt;
    data['closesAt'] = this.closesAt;
    data['accepting_orders'] = this.acceptingOrders;
    return data;
  }
}
