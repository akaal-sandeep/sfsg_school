class FeeLedgerModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  FeeLedgerModel({this.statuscode, this.message, this.data});

  FeeLedgerModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? particular;
  var due;
  var recd;
  var balance;

  Data({this.date, this.particular, this.due, this.recd, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    particular = json['Particular'];
    due = json['Due'];
    recd = json['Recd'];
    balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Particular'] = this.particular;
    data['Due'] = this.due;
    data['Recd'] = this.recd;
    data['Balance'] = this.balance;
    return data;
  }
}
