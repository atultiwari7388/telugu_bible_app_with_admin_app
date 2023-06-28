import 'package:open_share_pro/open.dart' as open;

class ApiRepository {
  static checkOther(name) {
    switch (name) {
      case 'Call Now':
        callNow();
        break;
      case 'Send an Email':
        sendEmail();
        break;
      case 'Send a Whatsapp Message':
        sendWhatsApp();
        break;
      default:
        null;
    }
  }

  static sendWhatsApp() {
    return open.Open.whatsApp(whatsAppNumber: "+919440106362", text: "Hi");
  }

  static callNow() async {
    return open.Open.phone(phoneNumber: "919440106362");
  }

  static sendEmail() async {
    return open.Open.mail(
      toAddress: "demo@gmail.com",
      subject: "Bible Support",
      body: "",
    );
  }

  static openInstagram() async {
    return open.Open.browser(url: "https://");
  }

  static openFacebook() async {
    return open.Open.browser(url: "https://");
  }

  static openLinkendin() async {
    return open.Open.browser(url: "//");
  }
}
