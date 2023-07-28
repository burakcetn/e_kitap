import 'package:flutter/material.dart';

/*

   Flutter bize direkt olarak hex kod kullanmayı desteklemediği için bu class ve fonksiyon oluşturuldu.

   Oluşturulan ColorManager classında tanımlanan hex kodlar .fromHex sayesinde flutterda kullanılabilir
   formata dönüştürülüyor.

 */

class ColorManager {
  static Color base00 = HexColor.fromHex("#FAFAFA");
  static Color base20 = HexColor.fromHex("#F1F1F1");
  static Color base40 = HexColor.fromHex("#E1E1E1");
  static Color base60 = HexColor.fromHex("#BCBCBC");
  static Color base80 = HexColor.fromHex("#7C7C7C");
  static Color base100 = HexColor.fromHex("#4A4A4A");
  static Color base120 = HexColor.fromHex("#2A2A2A");

  static Color introColor1 = HexColor.fromHex("#DB2323");
  static Color introColor2 = HexColor.fromHex("#0D4E97");

  static Color bgColorRaffle = HexColor.fromHex("#B0E7F2");
  static Color succes = HexColor.fromHex("#8AC981");
  static Color failure = HexColor.fromHex('#DB2323');
  static Color approve4 = HexColor.fromHex('#0D3E97');
  static Color shadowColor = HexColor.fromHex("#9E9DBA");
  static Color introductionShadowColor = HexColor.fromHex("#DBDDE9");

  static Color raffle1 = HexColor.fromHex("#29399e");
  static Color raffle2 = HexColor.fromHex("#B0E7F2");
  static Color raffle3 = HexColor.fromHex("#74248a");
  static Color raffle4 = HexColor.fromHex("#b135d4");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
