import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../parent_model/fee_ledger_model.dart';

class FeeLedger extends StatelessWidget {
  FeeLedgerModel feeLedgerModel;
   FeeLedger({Key? key,required this.feeLedgerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Fee Ledger"),
          smallSpace(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration:BoxDecoration(
                color: Colors.white,
                boxShadow: myShadow,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Center(child: Text("Date/ Particulars"),)),
                      Expanded(child: Center(child: Text("Fee Due."),)),
                      Expanded(child: Center(child: Text("Fee Recd."),)),
                      Expanded(child: Center(child: Text("Fee Balance"),)),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount:feeLedgerModel.data!.length ,
                        itemBuilder: (context,i){
                      return  Column(
                        children: [
                          greyPadding(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(child:feeLedgerModel.data![i].particular.toString().contains("FEE RECEIPT")?Text(feeLedgerModel.data![i].date.toString().split(" ")[0]+"\n\n"+feeLedgerModel.data![i].particular.toString(),style: CommonDecoration.smallLabel,): Text(feeLedgerModel.data![i].particular.toString(),style: CommonDecoration.smallLabel,)),
                                Expanded(child: Center(child: Text(feeLedgerModel.data![i].due.toString(),style: CommonDecoration.smallLabel.copyWith(color: Colors.red)))),
                                Expanded(child: Center(child: Text(feeLedgerModel.data![i].recd.toString(),style: CommonDecoration.smallLabel.copyWith(color: Colors.green)))),
                                Expanded(child: Center(child: Text(feeLedgerModel.data![i].balance.toString(),style: CommonDecoration.smallLabel))),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget greyPadding(){
    return  Padding(
      padding: const EdgeInsets.all(5),
      child: greyLine(),
    );
  }

}
