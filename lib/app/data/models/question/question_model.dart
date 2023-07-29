class QuestionModel {
  List<QuestionWrapModel> questions = [];
  String title;
  String quizKey = "";
  int type = 0;
  QuestionModel(this.title, this.quizKey, {this.type = 0});
  int nextOrder = 1;
  void add(QuestionWrapModel question) {
    question.order = nextOrder;
    nextOrder++;
    questions.add(question);
  }

  void clear() {
    for (var item in questions) {
      item.isOkey = false;
    }
  }
}

class QuestionWrapModel {
  String question;
  String value;
  bool isOkey = false;
  int order = 0;
  QuestionWrapModel(this.question, this.value);
}

class QuestionManager {
  static QuestionManager instance = QuestionManager();

  QuestionManager() {
    load();
  }
  List<QuestionModel> quiz = [];
  void load() {
    QuestionModel model = QuestionModel("Ağrı Dağı Efsanesi", "quiz1");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
        "Ülkedeki kömür {answer} yöre halkı çalışmaktadır",
        "havzasında",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Yağmurla birlikte sanki sel değil de {answer} oldu. Yer yerinden oynadı",
        "tufan",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Kadın her gün birbirinden daha da yorucu olan hayatına {answer}.",
        "isyan etti",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Ne yapacağını bilemeyen çocuk, korkulu gözlerle bakan annesine {answer}.",
        "sığındı",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Mahallenin çocukları kendileri gibi olmayan bu çocukla sürekli {answer}.",
        "alay ediyordu",
      ),
    );
    model = QuestionModel("AkcaKoca Denizkızı Efsanesi", "quiz2");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
        "Öğretmen sınav tarihini henüz {answer}.",
        "belirlemedi",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Sebze ve meyve fideleri farklı zamanlarla {answer}.",
        "dikilir",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Anne saatlerdir bıkmadan parkta oynayan çocuklarını {answer}.",
        "gözlüyor",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Çocukları iki yaşına gelmeden önce {answer}.",
        "memeden kesmeli",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Gençler birbirine sevdalanınca {answer} da aile büyüklerinden kızı istemiş",
        "köy muhtarı",
      ),
    );

    model = QuestionModel("Pamukkale Efsanesi", "quiz3");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Yüzyıllardır uygulanan {answer} kuralları toplumda saygı görmeye devam ediyor.",
          "gelenek"),
    );
    model.add(
      QuestionWrapModel(
          "Arkadaşının sorumsuz tavrı {answer} çareyi patrona şikâyet etmekte buldu.",
          "canına tak edince"),
    );
    model.add(
      QuestionWrapModel(
          "Kıyafetlerin ütülü olup olmaması {answer}.", "umurunda olmaz"),
    );
    model.add(
      QuestionWrapModel(
          "Kullandığı bitkiler sayesinde cildi {answer}.", "güzelliğe boğdu"),
    );

    model = QuestionModel("Şahmeran", "quiz4");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Adam ve kadın {answer} sağlamak için el ele vermiş çalışıyorlar.",
          "geçimlerini"),
    );
    model.add(
      QuestionWrapModel(
          "Bir şeyin başlangıcı onun {answer} dayanır.", "keşfedilmesine"),
    );
    model.add(
      QuestionWrapModel(
          "Çok kısa sürede bütün mahallelinin {answer}.", "güven kazandı"),
    );
    model.add(
      QuestionWrapModel(
          "Çocuk hayvan belgeselini seyrettikten sonra kuşunu doğaya {answer} gerektiğini anladı",
          "salıverilmesi"),
    );
    model.add(
      QuestionWrapModel(
          "Susuzluk nedeniyle her yer böcekler tarafından {answer}.",
          "istila ediliyor"),
    );

    model = QuestionModel("Kıztaşı", "quiz5");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Günümüzde rahat ve spor kıyafetler daha fazla {answer}.",
          "rağbet görmektedir"),
    );
    model.add(
      QuestionWrapModel(
          "Geceleri nehre düşen ayın gölgesini {answer}.", "seyre doyum olmaz"),
    );
    model.add(
      QuestionWrapModel(
          "Yapılan arkeolojik {answer} sonucunda yeni bir antik köy gün yüzüne çıkarıldı",
          "kazılar"),
    );
    model.add(
      QuestionWrapModel(
          "Parka gidebilmek için annesine {answer} ancak, izin alamadı.",
          "yalvardı"),
    );
    model.add(
      QuestionWrapModel(
          "Her gece yatmadan önce gözlüğünü {answer} koyar.", "başucuna"),
    );

    model = QuestionModel("Sarıkız Efsanesi", "quiz6");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Kimi zaman eğitim kimi zaman ise ekonomik nedenlerle insanlar farklı ülkelere {answer}.",
          "göçmektedir"),
    );
    model.add(
      QuestionWrapModel(
          "Her şeyi bilsen bile bir bilene {answer} , demişler.", "akıl danış"),
    );
    model.add(
      QuestionWrapModel(
          "Küçük kız babasının tüm tatlı konuşmalarına rağmen {answer}.",
          "yüz vermedi"),
    );
    model.add(
      QuestionWrapModel(
          "Suçlu diye yıllarca hapis yatan adama aslında {answer}.",
          "iftira atılmış"),
    );
    model.add(
      QuestionWrapModel("Yaşlılara her zaman {answer} edilmelidir.", "hürmet"),
    );

    model = QuestionModel("Ses Çıkarmayan Kurbağalar", "quiz7");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Yangında evi yok olan vatandaşa devlet {answer}.", "destek sağladı"),
    );
    model.add(
      QuestionWrapModel(
          " Annem bütün akrabaların bir arada olabileceği bir yemek {answer}.",
          "tertip edecek"),
    );
    model.add(
      QuestionWrapModel(
          "Yoğun trafik nedeniyle evlerine gitmekte {answer} yaşıyorlar.",
          "güçlük"),
    );
    model.add(
      QuestionWrapModel(
          "Dünyanın bir ucundaki haber sosyal medya yolu ile hızla {answer}.",
          "yayılabiliyor"),
    );
    model.add(
      QuestionWrapModel(
          "Teknolojik ihtiyaçlarınızı almadan önce teknoloji marketlerinde {answer} yapınız.",
          "araştırma"),
    );

    model = QuestionModel("Akdamar Adası", "quiz8");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Konferans belirtilen saat aralığından daha fazla {answer}.",
          "sürecek"),
    );
    model.add(
      QuestionWrapModel(
          "Zeytinyağlı sarmayı o kadar güzel yapıyor ki {answer}.",
          "üstüne tanımam"),
    );
    model.add(
      QuestionWrapModel(
          "Hırsız polisi görünce kaçmaya {answer} ancak başarılı olamadı",
          "yeltendi"),
    );
    model.add(
      QuestionWrapModel(
          "Hayatındaki her şeyin yalan olduğunu anlayınca {answer}.",
          "beyninden vurulmuşa döndü"),
    );
    model.add(
      QuestionWrapModel(
          "Konserde sanatçı tarafından sahneye davet edilen misafir önündeki kalabalığı {answer} ilerledi.",
          "yara yara"),
    );

    model = QuestionModel("Akdamar Adası", "quiz8");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Konferans belirtilen saat aralığından daha fazla {answer}.",
          "sürecek"),
    );
    model.add(
      QuestionWrapModel(
          "Zeytinyağlı sarmayı o kadar güzel yapıyor ki {answer}.",
          "üstüne tanımam"),
    );
    model.add(
      QuestionWrapModel(
          "Hırsız polisi görünce kaçmaya {answer} ancak başarılı olamadı",
          "yeltendi"),
    );
    model.add(
      QuestionWrapModel(
          "Hayatındaki her şeyin yalan olduğunu anlayınca {answer}.",
          "beyninden vurulmuşa döndü"),
    );
    model.add(
      QuestionWrapModel(
          "Konserde sanatçı tarafından sahneye davet edilen misafir önündeki kalabalığı {answer} ilerledi.",
          "yara yara"),
    );

    model = QuestionModel("Cumalıkızık-Cin Aralığı", "quiz9");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Eski ve yeni mimari kesin çizgilerle birbirinden {answer}.",
          "aytılmaktadır"),
    );
    model.add(
      QuestionWrapModel(
          "Polis şikâyet üzerine iki iş yerini {answer}.", "bastı"),
    );
    model.add(
      QuestionWrapModel(
          "Uzun zamandır böyle bir sürpriz ile karşılaşmamıştı. Yapılanları görünce {answer}.",
          "gözlerine inanamadı"),
    );
    model.add(
      QuestionWrapModel(
          "Binanın {answer} teyzeler oturmuş sohbet ediyorlardı", "girişine"),
    );
    model.add(
      QuestionWrapModel(
          "Uzun zamandır kirayı ödeyemediği için ev sahibini {answer} içeri girmesi gerekiyordu.",
          "atlatıp"),
    );

    model = QuestionModel("Arap Baba", "quiz10");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Aslında yerleşim merkezleri {answer} kurulmalıdır.", "dağ eteğine"),
    );
    model.add(
      QuestionWrapModel("İnsanları, tek bir görüşme ile {answer} yanılırsınız.",
          "değerlendirirseniz"),
    );
    model.add(
      QuestionWrapModel(
          "Yamaçları daha fazla ağaçlandırarak heyelan tehlikesini {answer} çalışırız.",
          "önlemeye"),
    );
    model.add(
      QuestionWrapModel(
          "Yıllarca anne ve babanın {answer} çocuklar büyüdükleri zaman karar vermekte zorluk yaşarlar",
          "tesiri altında kalan"),
    );
    model.add(
      QuestionWrapModel(
          "İnsanlar yaşanan felaketler neticesinde korkuya kapılsa da bir {answer} sonra normal düşünce tarzına geri dönüyorlar.",
          "müddet"),
    );

    model = QuestionModel("Görmeli Köprüsü", "quiz11");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Marketlerde çekirdek olarak satılan ay çekirdeği, İzmirliler tarafından çiğdem olarak {answer}.",
          "bilinmektedir"),
    );
    model.add(
      QuestionWrapModel(
          "Günümüzde bilgi hırsızlığının artması nedeniyle alana {answer} insanların sayısı azalıyor.",
          "emek veren"),
    );
    model.add(
      QuestionWrapModel(
          "Mimar Sinan’ın tüm eserleri görenler tarafından {answer}.",
          "beğeniliyor"),
    );

    model = QuestionModel("Ulu Burnu", "quiz12");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Filmin sonunda daracık yolda yürüyen adam aniden dönüp insanları şapkası ile {answer}.",
          "selamladı"),
    );
    model.add(
      QuestionWrapModel(
          " İnsan gücünün sınırlarını aşan durumlar karşısında {answer}.",
          "aciz kalır"),
    );
    model.add(
      QuestionWrapModel(
          "Buz hokeyinde daire biçimindeki bir taş buzların üzerinde sopalar yardımıyla {answer}.",
          "sürüklenmektedir"),
    );
    model.add(
      QuestionWrapModel(
          "Yapay zekâ adı altında yapılan çalışmalar görenleri {answer}.",
          "şaşkına çevirdi"),
    );
    model.add(
      QuestionWrapModel(
          "Gün boyu tarlada çalışan kadın eğilmiş belini {answer} ev işlerine koyuldu.",
          "doğrultup"),
    );

    model = QuestionModel("Ayakbastı Mevki", "quiz13");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Eskiden {answer} için imamlar mutlaka minareye çıkarmış.",
          "ezan okuman"),
    );
    model.add(
      QuestionWrapModel(
          "Deprem felaketi nedeniyle birçok köy {answer}.", "yerle bir oldu"),
    );
    model.add(
      QuestionWrapModel(
          "Belediye çalışanları asfalt çalışması yaparken kazdıkları yerden su {answer} başladı.",
          "fışkırmaya"),
    );
    model.add(
      QuestionWrapModel(
          "Evde yaptığı tostu kantindeki tostlara benzetmek için tost makinesini var gücüyle {answer}.",
          "bastırdı"),
    );

    model = QuestionModel("Aynalı Mağara Efsanesi", "quiz14");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Annesinden uzun yıllar ayrı kalan Fahri artık bu duruma {answer}.",
          "dayanamaz"),
    );
    model.add(
      QuestionWrapModel(
          "Yusuf peygamberin güzelliğini gören kadınlar {answer} ellerine bıçak batırdılar.",
          "kendilerinden geçerek"),
    );
    model.add(
      QuestionWrapModel(
          "Telefonu başka biri açınca evladına bir şey olduğunu düşündüğü için {answer}.",
          "dizlerinin bağı çözüldü"),
    );
    model.add(
      QuestionWrapModel(
          "Öyle heybetli ve sert bir adamdı ki karşısında biri konuşmadan önce {answer}.",
          "destur alırdı"),
    );
    model.add(
      QuestionWrapModel(
          "Her mimari eseri {answer} bir hikâye vardır.", "ünlendiren"),
    );

    model = QuestionModel("Munzur Baba", "quiz15");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Yaş kemale erince insan daha da {answer}.", "durgunlaşıyor"),
    );
    model.add(
      QuestionWrapModel(
          "O kadar hızlı koşuyordu ki saniyeler içerisinde {answer}.",
          "gözden kayboldu"),
    );
    model.add(
      QuestionWrapModel(
          "Artık sadece kendisi için değil tüm insanlık için {answer}.",
          "dua ediyor"),
    );

    model = QuestionModel("Söylemez Baba", "quiz16");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Son yıllarda konaklama türünde büyük bir çeşitlilik {answer}.",
          "göze çarpmaktadır"),
    );
    model.add(
      QuestionWrapModel(
          "{answer} adet hâline getiren insanlar davranış bozukluğuna sahip bireylerdir.",
          "yalan söylemeyi"),
    );
    model.add(
      QuestionWrapModel(
          "Tansiyonunun düşmesi ile bayılan öğrenci sınava katılım {answer}.",
          "sağlayamadı"),
    );

    model = QuestionModel("Çeç dağı", "quiz17");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Küçük kızın ablası kendisini sürekli {answer} , odasına almıyordu",
          "azarlıyor"),
    );
    model.add(
      QuestionWrapModel(
          "Yağmurlu havalarda çatıdan sızan yağmur taneleri üzerlerine {answer}.",
          "damlıyordu"),
    );
    model.add(
      QuestionWrapModel(
          "İnsanların ne söyledikleriyle ilgilenmez, eleştirildiğinde {answer}.",
          "oralı olmazdı"),
    );
    model.add(
      QuestionWrapModel(
          "Uzun zamandan beri herkesten {answer} fakat artık omzunda yük olan sırları vardı.",
          "sakladığı"),
    );

    model = QuestionModel("Yusufçuk kuşu", "quiz18");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Annesi,  {answer} uykusu gelen çocuğunun derslerini yaparken dikkatini toplaması için büyük çaba harcıyordu.",
          "gaflet basınca"),
    );
    model.add(
      QuestionWrapModel(
          "Proje uzmanı bu alanda çalışmak istemeyenlerin {answer} ifade etti.",
          "çekip gidebileceği"),
    );
    model.add(
      QuestionWrapModel(
          "Tüm çobanlar hayvanlarını {answer} için dağ bayır dolanırlar",
          "otlatmak"),
    );
    model.add(
      QuestionWrapModel(
          "İnsanlar tarafından anlaşılmadığı zaman öfkeli bir boğaya {answer}.",
          "dönüşüyor"),
    );

    model = QuestionModel("Balıklı Göl ve İğde Ağacı", "quiz19");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Evin içerisinde koşturup duran çocuklar yanlışlıkla masaya çarparak tüm tabak takımını {answer}.",
          "kırdı"),
    );
    model.add(
      QuestionWrapModel(
          "Toplumsal düzene aykırı davranan insanların {answer} oluşabilecek diğer suçların önüne geçmektedir.",
          "cezalandırılması"),
    );
    model.add(
      QuestionWrapModel(
          "Gençler birçok sosyal sorumluluk projesine {answer} büyük bir amaca hizmet ettiler.",
          "talip olmakla"),
    );

    model = QuestionModel("Çifte Minareli Medrese", "quiz20");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
          "Her gün {answer} işlerini bitirmek için masanın başına oturuyor fakat yine yarım bırakarak masadan kalkıyordu.",
          "yarım kalan"),
    );
    model.add(
      QuestionWrapModel(
          "Profesör, öğrencilerine {answer} ifade eden uzun bir konuşma yaptı.",
          "desteklerini"),
    );
    model.add(
      QuestionWrapModel("Tüm bu olanlara {answer} sadece anlamaya çalışıyordu.",
          "eseflenmeden"),
    );
    model.add(
      QuestionWrapModel(
          "Sultan Ahmet Cami’ne girdiğiniz zaman {answer} ilk şey mavi işlemeli çini fayanslardır.",
          "göze çarpan"),
    );
  }
}
