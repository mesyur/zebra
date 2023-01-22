import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';

import '../model/SssModel.dart';

class SssController extends GetxController{

  List<SssModel> SssList = [
    SssModel(titleString: "Zebra Nedir ?", subtitleString: "Zebra çevresinde ya da belirli bölgelerde belirli kategorilerde hizmet almak isteyen kişilerin uygulama üzerinden görüşme sağlamasına olanak sağlayan mobil uygulamadır. Hizmetlerin sahibi ya da sağlayıcı değildir."),
    SssModel(titleString: "Zebra Nerelerde Kullanılabilir ?", subtitleString: "Zebra uygulamasını şuan Türkiye geneli kullanabilirsiniz. Daha sonrasında dünyanın farklı ülkelerinde hizmete başlamak için çalışmalarına devam etmektedir."),
    SssModel(titleString: "Zebra Nasıl Çalışır ?", subtitleString: "Zebra uygulaması hizmet almak isteyen kişilerin çevresinde ya da seçtiği herhangi bir bölgedeki o alanda hizmet veren kişiler ile uygulama üzerinden görüşme sağlanır. Bu görüşme sonrası her iki tarafta birbirlerini puanlayabilir ve yorumlayabilir. Bu sayede her iki tarafta uygulama üzerinden kaliteli hizmet vermek ve almak üzerine kendilerini geliştirebilir."),
    SssModel(titleString: "Zebra Ücretli mi ?", subtitleString: "Zebra hizmet almak isteyen kişiler için tamamen ücretsizdir."),
    SssModel(titleString: "Bilgilerim Güvende mi ?", subtitleString: "Zebra uygulaması üzerindeki kayıtlı bilgileriniz güvenle saklanmaktadır."),
    SssModel(titleString: "Hizmet Veren Bilgilerimi Görebilir mi ?", subtitleString: "Çağrı gönderdiğinizde karşılıklı görüşme esnasında hizmet veren’e olan tahmini uzaklığınız Adınız ve daha önce diğer kullanıcılardan aldığınız yorum ve puanları hizmet verenler görüntüleyebilir."),
    SssModel(titleString: "Zebra Uygulamasında Hizmet Veren Olabilir miyim ?", subtitleString: "Evet. Zebra: Hizmet Veren Uygulamasını indirerek size uygun kategorilerde sizde hizmet vermeye başlayabilirsiniz."),
  ];


}


