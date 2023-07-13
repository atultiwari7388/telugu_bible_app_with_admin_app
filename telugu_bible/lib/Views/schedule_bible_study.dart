import 'package:flutter/material.dart';
import 'package:telugu_bible/services/local_notification_services.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

class ScheduleYourBibleStudyScreen extends StatefulWidget {
  const ScheduleYourBibleStudyScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleYourBibleStudyScreen> createState() =>
      _ScheduleYourBibleStudyScreenState();
}

class _ScheduleYourBibleStudyScreenState
    extends State<ScheduleYourBibleStudyScreen> {
  late DateTime selectedDateTime;

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
    selectedDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Schedule Your Bible"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDateTime != null) {
                  // ignore: use_build_context_synchronously
                  final TimeOfDay? pickedTimeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                  );
                  if (pickedTimeOfDay != null) {
                    setState(() {
                      selectedDateTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTimeOfDay.hour,
                        pickedTimeOfDay.minute,
                      );
                    });
                  }
                }
              },
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected Time: ${selectedDateTime.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0,
              ),
              onPressed: () {
                notificationServices
                    .scheduleNotification('Study Reminder',
                        'It\'s time to study!', selectedDateTime, 50)
                    .then((value) {
                  showSnackBarMessage(
                      "Schedule",
                      "Your Reminder was schedule $selectedDateTime",
                      Colors.green);
                  Navigator.pop(context);
                });
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
