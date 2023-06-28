import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:open_share_pro/open.dart' as open;

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextStyle head = const TextStyle(
      fontSize: 16, color: AppColors.kBlackColor, fontWeight: FontWeight.bold);
  final TextStyle text =
      const TextStyle(fontSize: 12, color: AppColors.kBlackColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Contact Us"),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Company Office’s Address'),
                const SizedBox(height: 20),
                Text('Awiskar Technology India \nPrivate Limited', style: head),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Email: ', style: text),
                    Text('contact@awiskartech@gmail.com',
                        style: text.copyWith(color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('Website: ', style: text),
                    Text('www.awiskartech.com',
                        style: text.copyWith(color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('Mob: ', style: text),
                    Text('+91-8210918816', style: text),
                  ],
                ),
                const SizedBox(height: 20),
                Text('AwiskarTechnology (Chennai) :-', style: head),
                const SizedBox(height: 5),
                Text(
                    'No. 27, Site-B, Sathyavani Muthu St, \nSholinganallur,Chennai,',
                    style: text),
                const SizedBox(height: 2),
                Text('Tamil Nadu – 600119 (India).', style: text),
                const SizedBox(height: 20),
                Text('AwiskarTechnology (Visakhapatnam) :-',
                    style: head.copyWith(fontSize: 16)),
                const SizedBox(height: 2),
                Text(
                    '3rd Floor, Madhus Plaza, Door no 15-10,MIG 529,\nRATNAGIRI HOUSING BOARD COLONY,\nPM PALEM VSKP 41, Visakhapatnam,',
                    style: text),
                const SizedBox(height: 2),
                Text('Andhra Pradesh – 530041 (India).', style: text),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        open.Open.phone(phoneNumber: "919440106362");
                      },
                      child: const FaIcon(FontAwesomeIcons.phone,
                          color: AppColors.kPrimaryColor),
                    ),
                    InkWell(
                        onTap: () {
                          open.Open.mail(
                            toAddress: "contact@awiskartech@gmail.com",
                            subject: "Enquiry",
                            body: "Please ask your Enquiry",
                          );
                        },
                        child: const FaIcon(FontAwesomeIcons.mailchimp)),
                    InkWell(
                        onTap: () {
                          open.Open.browser(
                              url: "https://www.awiskartech.com/");
                        },
                        child: const FaIcon(FontAwesomeIcons.linkedin,
                            color: Colors.blue)),
                    InkWell(
                        onTap: () {
                          open.Open.browser(
                              url: "https://www.awiskartech.com/");
                        },
                        child: const FaIcon(FontAwesomeIcons.facebook,
                            color: Colors.blue)),
                    InkWell(
                        onTap: () {
                          open.Open.whatsApp(
                              whatsAppNumber: "+919440106362", text: "Hi");
                        },
                        child: const FaIcon(FontAwesomeIcons.whatsapp,
                            color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
