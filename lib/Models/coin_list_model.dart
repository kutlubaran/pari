class CoinListModel {
  String? id;
  String? symbol;
  String? name;

  CoinListModel({this.id, this.symbol, this.name});

  CoinListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    return data;
  }
}
