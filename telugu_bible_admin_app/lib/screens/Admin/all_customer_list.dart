import 'package:flutter/material.dart';
import 'package:telugu_admin/screens/Admin/widgets/users_list.widgets.dart';

class AdminCustomerScreen extends StatefulWidget {
  static const String id = "products";

  const AdminCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AdminCustomerScreen> createState() => _AdminCustomerScreenState();
}

class _AdminCustomerScreenState extends State<AdminCustomerScreen> {
  // final productCategoryController = Get.put(ProductCategoryController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const AllCustomersListScreen();
  }
}
