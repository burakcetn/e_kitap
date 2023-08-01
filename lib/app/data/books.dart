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
    "bookPath": "assets/books/Akcakoca_Denizkz_Efsanesi.json",
    "audioPath": "audios/akcaova.m4a",
    "imagePath": "assets/images/akcakoca.jpg",
    "question": "quiz2"
  },
  {
    "name": "Arap Baba",
    "bookPath": "assets/books/arap_baba.json",
    "audioPath": "audios/Arap_Baba.m4a",
    "imagePath": "assets/images/arap_baba.jpg",
    "question": "quiz10"
  },
  {
    "name": "Ayakbastı Mevkii",
    "bookPath": "assets/books/ayakbast_mevki.json",
    "audioPath": "audios/ayakbast_Mevki.m4a",
    "imagePath": "assets/images/ayakbastı.jpg",
    "question": "quiz13"
  },
  {
    "name": "Aynalı Mağara Efsanesi",
    "nameUp": "Aynalı Mağara Efsanesi",
    "bookPath": "assets/books/aynal_Magara.json",
    "audioPath": "audios/aynali_magara.m4a",
    "imagePath": "assets/images/aynalı_magara.jpg",
    "question": "quiz14"
  },
  {
    "name": "Agrı dağı efsanesi",
    "bookPath": "assets/books/Agr_Dagi_Efsanesi.json",
    "audioPath": "audios/agri_dagi_efsanesi.m4a",
    "imagePath": "assets/images/agrı_dagı.jpg",
    "question": "quiz1"
  },
  {
    "name": "Balıklı Göl ve İğde Ağacı",
    "bookPath": "assets/books/balikli_gol_ve_Igde_agac.json",
    "audioPath": "audios/blkli_gol_ve_igde_agaci.m4a",
    "imagePath": "assets/images/balıklı.jpg",
    "question": "quiz19"
  },
  {
    "name": "Cumalıkızık Cin Aralığı",
    "bookPath": "assets/books/cumalkzk_cin_aralg.json",
    "audioPath": "audios/cumalikizik_cin_araligi.m4a",
    "imagePath": "assets/images/cumalikizik.jpg",
    "question": "quiz9"
  },
  {
    "name": "Görmeli Köprüsü",
    "bookPath": "assets/books/Gormeli_Koprusu.json",
    "audioPath": "audios/gormeli_koprusu.m4a",
    "imagePath": "assets/images/gormeli.jpg",
    "question": "quiz11"
  },
  {
    "name": "Kıztaşı",
    "bookPath": "assets/books/kztas.json",
    "audioPath": "audios/kiztasi.m4a",
    "imagePath": "assets/images/kıztası.jpg",
    "question": "quiz5"
  },
  {
    "name": "Munzur Baba",
    "bookPath": "assets/books/Munzur_Baba.json",
    "audioPath": "audios/munzur_baba.m4a",
    "imagePath": "assets/images/munzur_baba.jpg",
    "question": "quiz15"
  },
  {
    "name": "Pamukkale Efsanesi",
    "bookPath": "assets/books/pamukkale_efsanesi.json",
    "audioPath": "audios/pamukkale_efsanesi.m4a",
    "imagePath": "assets/images/pamukkale.jpg",
    "question": "quiz3"
  },
  {
    "name": "Sarıkız Efsanesi",
    "bookPath": "assets/books/Sarkz-Efsanesi.json",
    "audioPath": "audios/audios/sarikiz.m4a",
    "imagePath": "assets/images/sarıkız.jpg",
    "question": "quiz6"
  },
  {
    "name": "Ses Çıkarmayan kurbağalar",
    "bookPath": "assets/books/Ses-Ckarmayan-kurbagalar.json",
    "audioPath": "audios/sec_cikarmayan_kurbagalar.m4a",
    "imagePath": "assets/images/kurbagalar.jpg",
    "question": "quiz7"
  },
  {
    "name": "Söylemez Baba",
    "bookPath": "assets/books/Soylemez-Baba.json",
    "audioPath": "audios/soylemez_baba.m4a",
    "imagePath": "assets/images/soylemez_baba.jpg",
    "question": "quiz16"
  },
  {
    "name": "Ulu Burnu",
    "bookPath": "assets/books/Ulu-Burnu.json",
    "audioPath": "audios/ulu_burnu.m4a",
    "imagePath": "assets/images/ulu_burnu.jpg",
    "question": "quiz12"
  },
  {
    "name": "Yusufçuk Kuşu",
    "bookPath": "assets/books/Yusufcuk-Kusu.json",
    "audioPath": "audios/yusufcuk.m4a",
    "imagePath": "assets/images/yusufcuk_kusu.jpg",
    "question": "quiz18"
  },
  {
    "name": "Çeç Dağı",
    "bookPath": "assets/books/Cec_Dagi.json",
    "audioPath": "audios/cec_dagi.m4a",
    "imagePath": "assets/images/cec_dagı.jpg",
    "question": "quiz17"
  },
  {
    "name": "Çifte Minareli Medrese",
    "bookPath": "assets/books/Cifte_Minareli_Medrese.json",
    "audioPath": "audios/ciftemedreseliminare.m4a",
    "imagePath": "assets/images/cifte_minare.jpg",
    "question": "quiz20"
  },
  {
    "name": "Şahmeran",
    "bookPath": "assets/books/sahmeran.json",
    "audioPath": "audios/sahmeran.m4a",
    "imagePath": "assets/images/sahmeran.jpg",
    "question": "quiz4"
  }
];

final bookList = bookModelFromJson(_booksAll);
