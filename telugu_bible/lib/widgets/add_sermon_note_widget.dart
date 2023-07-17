import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/sermon_controller.dart';

class AddNewSermonPage extends StatefulWidget {
  const AddNewSermonPage({Key? key}) : super(key: key);

  @override
  State<AddNewSermonPage> createState() => _AddNewSermonPageState();
}

class _AddNewSermonPageState extends State<AddNewSermonPage> {
  final sermonController = Get.put(SermonController());

  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Sermon'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: sermonController.titleController,
                decoration: const InputDecoration(
                  labelText: 'Untitled',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sermonController.speakerController,
                decoration: const InputDecoration(
                  labelText: 'Speaker',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sermonController.placeController,
                decoration: const InputDecoration(
                  labelText: 'Place',
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    controller: TextEditingController(
                      text: DateFormat('dd MMM yyyy').format(selectedDate),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Time',
                    ),
                    controller: TextEditingController(
                      text: selectedTime.format(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sermonController.referenceController,
                decoration: const InputDecoration(
                  labelText: 'reference',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    sermonController.addSermonNotes(selectedDate, selectedTime);
                    Navigator.pop(context);
                  },
                  child: const Text("Save Data"))
            ],
          ),
        ),
      ),
    );
  }
}











//    // DropdownButton<String>(
//                         //   value: dropdownValue,
//                         //   onChanged: (newValue) {
//                         //     setState(() {
//                         //       dropdownValue = newValue!;
//                         //     });
//                         //   },
//                         //   items: <String>['English', 'Telugu']
//                         //       .map<DropdownMenuItem<String>>((String value) {
//                         //     return DropdownMenuItem<String>(
//                         //       value: value,
//                         //       child: Text(value),
//                         //     );
//                         //   }).toList(),
//                         // ),