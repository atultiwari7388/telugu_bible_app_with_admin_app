import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sermon_controller.dart';

class EditSermonDataWidget extends StatefulWidget {
  const EditSermonDataWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.speaker,
    required this.place,
    required this.reference,
  }) : super(key: key);

  final String id;
  final String title;
  final String speaker;
  final String place;
  final String reference;

  @override
  State<EditSermonDataWidget> createState() => _EditSermonDataWidgetState();
}

class _EditSermonDataWidgetState extends State<EditSermonDataWidget> {
  final sermonController = Get.put(SermonController());
  late TextEditingController titleController;
  late TextEditingController speakerController;
  late TextEditingController placeController;
  late TextEditingController referenceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    speakerController = TextEditingController(text: widget.speaker);
    placeController = TextEditingController(text: widget.place);
    referenceController = TextEditingController(text: widget.reference);
  }

  @override
  void dispose() {
    titleController.dispose();
    speakerController.dispose();
    placeController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Sermons"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: speakerController,
                decoration: InputDecoration(
                  labelText: 'Speaker',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Place',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: referenceController,
                decoration: InputDecoration(
                  labelText: 'Reference',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final editedTitle = titleController.text;
                  final editedSpeaker = speakerController.text;
                  final editedPlace = placeController.text;
                  final editedReference = referenceController.text;

                  // TODO: Save the edited sermon data
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
