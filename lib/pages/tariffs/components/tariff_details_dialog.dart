import 'package:flutter/material.dart';
import 'package:tariff_app/model/tariff_model.dart';
import 'package:tariff_app/pages/tariffs/components/tariffs_list_item.dart';

class TariffDetailsDialog extends StatelessWidget {

  TariffDetailsDialog({this.rateModel});

  RateModel? rateModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        title: Text(rateModel!.rateName!, textAlign: TextAlign.center,),
        titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TariffListRow(
                    title: "Цена:",
                    value: rateModel!.price!.toString(),
                    unit: rateModel!.price_title!,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Включенный пробег:",
                    value: "0",
                    unit: "км",
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Свыше пробега:",
                    value: "0",
                    unit: "км",
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Парковка:",
                    value: rateModel!.parkrate!.toString(),
                    unit: "₴",
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Платное бронирование:",
                    value: getValue(8),
                    unit: getUnit(8),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Передача:",
                    value: getValue(6),
                    unit: getUnit(6),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(1), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(2), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(31), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(4), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(6), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(getComment(8), textAlign: TextAlign.center,),
                  ),
                ],
              ),
            )
        )
    );
  }

  String getValue(int type) {
    String value = "";
    rateModel!.description.forEach((element) {
      if(element.type == type)
        value = element.val.toString();
    });
    return value;
  }

  String getUnit(int type) {
    String unit = "";
    rateModel!.description.forEach((element) {
      if(element.type == type)
        unit = element.desc!;
    });
    return unit;
  }

  String getComment(int type) {
    String comment = "";
    rateModel!.description.forEach((element) {
      if(element.type == type)
        comment = element.comment!;
    });
    return comment;
  }
}