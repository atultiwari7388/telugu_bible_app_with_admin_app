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
  // late TabController controller;
  // late String appbarTitle;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = TabController(length: 2, vsync: this);
  //   controller.addListener(() {
  //     setState(() {
  //       // Update the appBarTitle based on the selected tab
  //       if (controller.index == 0) {
  //         appbarTitle = "Contact Details";
  //       } else if (controller.index == 1) {
  //         appbarTitle = "About Author";
  //       }
  //     });
  //   });
  //   appbarTitle = "Contact Details";
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

  final TextStyle head = const TextStyle(
      fontSize: 16, color: AppColors.kBlackColor, fontWeight: FontWeight.bold);
  final TextStyle text =
      const TextStyle(fontSize: 12, color: AppColors.kBlackColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        centerTitle: true,
        elevation: 0,
      ),
      body: buildContactDetailsWidget(),
    );
  }

//===================== Contact Details Widget =================
  SafeArea buildContactDetailsWidget() {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact Details', style: head.copyWith(fontSize: 25)),
              const SizedBox(height: 30),
              Text('Dr Girija Prasad Samavedam \nTelugu Bible App Owner',
                  style: head.copyWith(fontSize: 17)),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text('Email: ', style: text.copyWith(fontSize: 15)),
                  InkWell(
                    onTap: () {
                      open.Open.mail(
                        toAddress: "mnp.telugubibleapp@gmail.com",
                        subject: "Enquiry",
                        body: "Please ask your Enquiry",
                      );
                    },
                    child: Text('mnp.telugubibleapp@gmail.com',
                        style: text.copyWith(color: Colors.blue, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text('Mob: ', style: text.copyWith(fontSize: 15)),
                  Text('+91 9440106362 ,  +91 93984 27187',
                      style: text.copyWith(color: Colors.blue, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 20),
              Text('Permanant Address  (Srikakulam) :-', style: head),
              const SizedBox(height: 5),
              Text("C/o Late Dr. Nirmala Prasad Madduluri",
                  style: text.copyWith(fontSize: 14)),
              Text(
                  '#Plot no 56, Radhakrishna Nagar Colony, \nKonna Street, Srikakulam 532001, ,',
                  style: text.copyWith(fontSize: 12)),
              const SizedBox(height: 2),
              Text('Andhra Pradesh, India .',
                  style: text.copyWith(fontSize: 14)),
              const SizedBox(height: 20),
              Text('Present Address (Visakhapatnam) :-',
                  style: head.copyWith(fontSize: 16)),
              const SizedBox(height: 2),
              Text(
                  '#Flat 502, Sri Vyshnovi Gardenia Apartment,\nVUDA Layout, Marripalem,\nVisakhapatnam 530009,',
                  style: text),
              const SizedBox(height: 2),
              Text('Andhra Pradesh – 530041 (India).', style: text),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      open.Open.phone(phoneNumber: "9440106362");
                    },
                    child: const FaIcon(FontAwesomeIcons.phone,
                        color: AppColors.kPrimaryColor),
                  ),
                  InkWell(
                      onTap: () {
                        open.Open.mail(
                          toAddress: "mnp.telugubibleapp@gmail.com",
                          subject: "Enquiry",
                          body: "Please ask your Enquiry",
                        );
                      },
                      child: const FaIcon(FontAwesomeIcons.mailchimp)),
                  InkWell(
                      onTap: () {
                        open.Open.browser(
                            url: "https://twitter.com/mnp_telugubible");
                      },
                      child: const FaIcon(FontAwesomeIcons.twitter,
                          color: Colors.blue)),
                  InkWell(
                      onTap: () {
                        open.Open.browser(
                            url: "https://www.instagram.com/mnp.telugubible/");
                      },
                      child: const FaIcon(FontAwesomeIcons.instagram,
                          color: AppColors.kPrimaryColor)),
                  InkWell(
                      onTap: () {
                        open.Open.browser(
                            url: "https://www.facebook.com/mnp.telugubible");
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
    );
  }
}
