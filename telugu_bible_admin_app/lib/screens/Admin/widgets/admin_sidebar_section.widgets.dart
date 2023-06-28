// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:mylex_practical/Admin/widgets/custom_sidebar_menu_buttons.dart';
// import 'package:mylex_practical/Admin/widgets/users_list.widgets.dart';
// import 'package:mylex_practical/constants/utils/colors.utils.dart';
//
// class AdminSideBarWidget extends StatelessWidget {
//   const AdminSideBarWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       color: AppColors.kLightColor,
//       child: ListView(
//         children: [
//           const SizedBox(height: 20),
//           //dashboard Section
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "DashBoard",
//               icon: FontAwesomeIcons.arrowTrendUp),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "Products",
//               icon: FontAwesomeIcons.productHunt),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "Total Orders",
//               icon: FontAwesomeIcons.firstOrder),
//           SideBarMenuButtonWidget(
//               onTap: () => Get.to(() => const AllUsersListWidget()),
//               menuName: "Users",
//               icon: FontAwesomeIcons.users),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "Notifications",
//               icon: FontAwesomeIcons.bell),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "Messages",
//               icon: FontAwesomeIcons.message),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "Analytics",
//               icon: FontAwesomeIcons.chartPie),
//
//           SideBarMenuButtonWidget(
//               onTap: () {}, menuName: "Account", icon: FontAwesomeIcons.user),
//           SideBarMenuButtonWidget(
//               onTap: () {},
//               menuName: "LogOut",
//               icon: FontAwesomeIcons.arrowRightFromBracket),
//         ],
//       ),
//     );
//   }
// }
