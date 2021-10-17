import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tariff_app/model/tariff_model.dart';
import 'package:tariff_app/pages/tariffs/components/tariff_details_dialog.dart';

class TariffsListItem extends StatelessWidget {

  TariffsListItem({required this.rateModel});

  RateModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(rateModel.rateName!, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TariffListRow(
                    title: "Цена:",
                    value: rateModel.price!.toString(),
                    unit: rateModel.price_title!,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Включенный пробег:",
                    value: "0",
                    unit: "км",
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  TariffListRow(
                    title: "Парковка:",
                    value: rateModel.parkrate!.toString(),
                    unit: "₴",
                  ),
                ],
              ),
            ),
            TextButton(
              child: Text("Детальнее", style: TextStyle(color: Color.fromRGBO(233, 116, 81, 1)),),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.all(2.5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context) =>
                    TariffDetailsDialog(rateModel: rateModel,)
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TariffListRow extends StatelessWidget {

  TariffListRow({this.title, this.value, this.unit});

  String? title;
  String? value;
  String? unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title! + " "),
        Wrap(
          children: [
            Text(value! + " ", style: TextStyle(fontWeight: FontWeight.bold),),
            Text(unit!),
          ],
        ),
      ],
    );
  }
}