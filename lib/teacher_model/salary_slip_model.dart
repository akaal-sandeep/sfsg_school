class SalarySlipModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  SalarySlipModel({this.statuscode, this.message, this.data});

  SalarySlipModel.fromJson(Map<String, dynamic> json) {
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
  var aMOUNT200;
  String? dESC200;
  String? dESC1;
  String? dESC2;
  String? dESC3;
  String? dESC4;
  String? dESC5;
  String? dESC6;
  String? dESC7;
  var aMOUNT5;
  var aMOUNT6;
  String? dESC20;
  var aMOUNT20;
  String? dESC21;
  var aMOUNT21;
  var aMOUNT1;
  var aMOUNT50;
  var aMOUNT2;
  var aMOUNT3;
  String? dESC30;
  String? dESC31;
  String? dESC32;

  Data(
      {this.aMOUNT200,
        this.dESC200,
        this.dESC1,
        this.dESC2,
        this.dESC3,
        this.dESC4,
        this.dESC5,
        this.dESC6,
        this.dESC7,
        this.aMOUNT5,
        this.aMOUNT6,
        this.dESC20,
        this.aMOUNT20,
        this.dESC21,
        this.aMOUNT21,
        this.aMOUNT1,
        this.aMOUNT50,
        this.aMOUNT2,
        this.aMOUNT3,
        this.dESC30,
        this.dESC31,
        this.dESC32});

  Data.fromJson(Map<String, dynamic> json) {
    aMOUNT200 = json['AMOUNT200'];
    dESC200 = json['DESC200'];
    dESC1 = json['DESC1'];
    dESC2 = json['DESC2'];
    dESC3 = json['DESC3'];
    dESC4 = json['DESC4'];
    dESC5 = json['DESC5'];
    dESC6 = json['DESC6'];
    dESC7 = json['DESC7'];
    aMOUNT5 = json['AMOUNT5'];
    aMOUNT6 = json['AMOUNT6'];
    dESC20 = json['DESC20'];
    aMOUNT20 = json['AMOUNT20'];
    dESC21 = json['DESC21'];
    aMOUNT21 = json['AMOUNT21'];
    aMOUNT1 = json['AMOUNT1'];
    aMOUNT50 = json['AMOUNT50'];
    aMOUNT2 = json['AMOUNT2'];
    aMOUNT3 = json['AMOUNT3'];
    dESC30 = json['DESC30'];
    dESC31 = json['DESC31'];
    dESC32 = json['DESC32'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AMOUNT200'] = this.aMOUNT200;
    data['DESC200'] = this.dESC200;
    data['DESC1'] = this.dESC1;
    data['DESC2'] = this.dESC2;
    data['DESC3'] = this.dESC3;
    data['DESC4'] = this.dESC4;
    data['DESC5'] = this.dESC5;
    data['DESC6'] = this.dESC6;
    data['DESC7'] = this.dESC7;
    data['AMOUNT5'] = this.aMOUNT5;
    data['AMOUNT6'] = this.aMOUNT6;
    data['DESC20'] = this.dESC20;
    data['AMOUNT20'] = this.aMOUNT20;
    data['DESC21'] = this.dESC21;
    data['AMOUNT21'] = this.aMOUNT21;
    data['AMOUNT1'] = this.aMOUNT1;
    data['AMOUNT50'] = this.aMOUNT50;
    data['AMOUNT2'] = this.aMOUNT2;
    data['AMOUNT3'] = this.aMOUNT3;
    data['DESC30'] = this.dESC30;
    data['DESC31'] = this.dESC31;
    data['DESC32'] = this.dESC32;
    return data;
  }
}
