import 'dart:convert';

import 'package:getx_skeleton/app/data/models/book_model.dart';

const _booksAll = [
  {
    "name": "Akdamar Kilisesi",
    "bookPath": "assets/books/akdamar_kilisesi.json",
    "audioPath": "audios/akdamar_kilisesi.m4a",
    "imagePath": "assets/images/akdamar.jpg",
    "question": "quiz8"
  },
  {
    "name": "Akçakoca Denizkızı Efsanesi",
    "bookPath": "assets/books/arap_baba.json",
    "audioPath": "audios/akcaova.m4a",
    "imagePath": "assets/images/akcakoca.jpg",
    "question": "quiz2"
  },
  {
    "name": "Arap Baba",
    "bookPath": "assets/books/ayakbast_mevki.json",
    "audioPath": "audios/Arap Baba.m4a",
    "imagePath": "assets/images/arap_baba.jpg",
    "question": "quiz10"
  },
  {
    "name": "Ayakbastı Mevki",
    "bookPath": "assets/books/ayakbast_mevki.json",
    "audioPath": "audios/Ayakbastı Mevki.m4a",
    "imagePath": "assets/images/ayakbastı.jpg",
    "question": "quiz13"
  },
  {
    "name": "Aynalı Magara",
    "bookPath": "assets/books/aynal_Magara.json",
    "audioPath": "audios/Aynalı Magara.m4a",
    "imagePath": "assets/images/aynalı_magara.jpg",
    "question": "quiz14"
  },
  {
    "name": "Agrı dağı efsanesi",
    "bookPath": "",
    "audioPath": "audios/Agri_dagi_efsanesi.m4a",
    "imagePath": "assets/images/agrı_dagı.jpg",
    "question": "quiz1"
  },
  {
    "name": "Balıklı Göl ve İğde Ağacı",
    "bookPath": "assets/books/balikli_gol_ve_Igde_agac.json",
    "audioPath": "audios/Balıklı Göl ve İğde Ağacı.m4a",
    "imagePath": "assets/images/balıklı.jpg",
    "question": "quiz19"
  },
  {
    "name": "Cumalıkızık Cin Aralığı",
    "bookPath": "assets/books/cumalkzk_cin_aralg.json",
    "audioPath": "audios/Cumalıkızık Cin Aralığı.m4a",
    "imagePath": "assets/images/cumalikizik.jpg",
    "question": "quiz9"
  },
  {
    "name": "Görmeli Köprüsü",
    "bookPath": "",
    "audioPath": "audios/Görmeli Köprüsü.m4a",
    "imagePath": "assets/images/gormeli.jpg",
    "question": "quiz11"
  },
  {
    "name": "Kıztaşı",
    "bookPath": "",
    "audioPath": "audios/Kıztaşı.m4a",
    "imagePath": "assets/images/kıztası.jpg",
    "question": "quiz5"
  },
  {
    "name": "Munzur Baba",
    "bookPath": "",
    "audioPath": "audios/Munzur Baba.m4a",
    "imagePath": "assets/images/munzur_baba.jpg",
    "question": "quiz15"
  },
  {
    "name": "Pamukkale Efsanesi",
    "bookPath": "",
    "audioPath": "audios/Pamukkale Efsanesi.m4a",
    "imagePath": "assets/images/pamukkale.jpg",
    "question": "quiz3"
  },
  {
    "name": "Sarıkız Efsanesi",
    "bookPath": "",
    "audioPath": "audios/Sarıkız Efsanesi.m4a",
    "imagePath": "assets/images/sarıkız.jpg",
    "question": "quiz6"
  },
  {
    "name": "Ses Çıkarmayan kurbağalar",
    "bookPath": "",
    "audioPath": "audios/Ses Çıkarmayan kurbağalar.m4a",
    "imagePath": "assets/images/kurbagalar.jpg",
    "question": "quiz7"
  },
  {
    "name": "Söylemez Baba",
    "bookPath": "",
    "audioPath": "audios/Söylemez Baba.m4a",
    "imagePath": "assets/images/soylemez_baba.jpg",
    "question": "quiz16"
  },
  {
    "name": "Ulu Burnu",
    "bookPath": "",
    "audioPath": "audios/Ulu Burnu.m4a",
    "imagePath": "assets/images/ulu_burnu.jpg",
    "question": "quiz12"
  },
  {
    "name": "Yusufçuk Kuşu",
    "bookPath": "",
    "audioPath": "audios/Yusufçuk Kuşu.m4a",
    "imagePath": "assets/images/yusufcuk_kusu.jpg",
    "question": "quiz18"
  },
  {
    "name": "Çeç Daği",
    "bookPath": "",
    "audioPath": "audios/Çeç Daği.m4a",
    "imagePath": "assets/images/cec_dagı.jpg",
    "question": "quiz17"
  },
  {
    "name": "Çifte Minareli Medrese",
    "bookPath": "",
    "audioPath": "audios/Çifte Minareli Medrese.m4a",
    "imagePath": "assets/images/cifte_minare.jpg",
    "question": "quiz20"
  },
  {
    "name": "Şahmeran",
    "bookPath": "",
    "audioPath": "audios/Şahmeran.m4a",
    "imagePath": "assets/images/sahmeran.jpg",
    "question": "quiz4"
  }
];

final bookList = bookModelFromJson(_booksAll);
