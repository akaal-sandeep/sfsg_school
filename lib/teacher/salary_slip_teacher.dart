import 'package:flutter/material.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../teacher_model/salary_slip_model.dart';

class SalarySlip extends StatelessWidget {
  SalarySlipModel salarySlipModel;

  SalarySlip({Key? key, required this.salarySlipModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double netSalary=0;
    double earnings = 0;
    double deductions = 0;

    for(int i=0;i<salarySlipModel.data!.length;i++){
      netSalary = netSalary +  (salarySlipModel.data![i].aMOUNT20-salarySlipModel.data![i].aMOUNT21);
    }

    for(int i=0;i<salarySlipModel.data!.length;i++){
      earnings = earnings +  salarySlipModel.data![i].aMOUNT20;
    }

    for(int i=0;i<salarySlipModel.data!.length;i++){
      deductions = deductions +  salarySlipModel.data![i].aMOUNT21;
    }

    return Scaffold(
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title: "Salary Slip",
                hideStudentName: true,
              ),
              Expanded(
                  child: salarySlipModel.data!.isEmpty
                      ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                      : Column(
                    children: [
                      smallSpace(),
                      header(text:salarySlipModel.data![0].dESC200),
                      details(label: "Net Salary", value: netSalary),
                      header(text:"Earnings"),
                      ListView.builder(
                        shrinkWrap: true
                        ,
                        itemCount: salarySlipModel.data!.length,

                        itemBuilder: (BuildContext context, int index) {
                          if(salarySlipModel.data![index].dESC20==null)
                            return Container();
                          return
                            details(label: salarySlipModel.data![index].dESC20, value: salarySlipModel.data![index].aMOUNT20);

                        },),
                      /*     details(label: salarySlipModel.data![1].dESC20, value: salarySlipModel.data![1].aMOUNT20),
                  details(label: salarySlipModel.data![2].dESC20, value: salarySlipModel.data![2].aMOUNT20),
                  details(label: salarySlipModel.data![3].dESC20, value: salarySlipModel.data![3].aMOUNT20),
                  details(label: salarySlipModel.data![4].dESC20, value: salarySlipModel.data![4].aMOUNT20),
                  details(label: salarySlipModel.data![5].dESC20, value: salarySlipModel.data![5].aMOUNT20),
                  details(label: salarySlipModel.data![6].dESC20, value: salarySlipModel.data![6].aMOUNT20),
                  details(label: salarySlipModel.data![7].dESC20, value: salarySlipModel.data![7].aMOUNT20),
                  details(label: salarySlipModel.data![8].dESC20, value: salarySlipModel.data![8].aMOUNT20),*/
                      detailsGrey(label: "Total", value: earnings),
                      header(text: "Deduction"),
                      detailsGrey(label: "Total", value: deductions),




                    ],
                  )
              )],
          )),
    );
  }

  Widget header({required  text}){
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      color: ColorConstants.themeColor,
      child: Text(text.toString().replaceAll("Salary for the Month of", ""),style: CommonDecoration.bigLabel.copyWith(color: Colors.white),),
    );
  }

  Widget details({required  label,required  value}){
    return Container(

      padding: EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(child: Text(label.toString(),style: CommonDecoration.smallLabel)),
          Expanded(child: Text(value.toString(),style: CommonDecoration.smallLabel)),
        ],
      ),
    );
  }


  Widget detailsGrey({required  label,required  value}){
    return Container(
      padding: EdgeInsets.all(7),
      color: Colors.grey.withOpacity(.5),
      child: Row(
        children: [
          Expanded(child: Text(label.toString(),style: CommonDecoration.smallLabel.copyWith(color: Colors.white),),),
          Expanded(child: Text(value.toString(),style: CommonDecoration.smallLabel.copyWith(color: Colors.white))),
        ],
      ),
    );
  }

}
