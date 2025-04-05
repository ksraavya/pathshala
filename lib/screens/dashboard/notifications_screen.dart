import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "text": "Your test score for Mathematics has been released! You scored 92% - Great job!",
      "color": Colors.green,
    },
    {
      "id": 2,
      "text": "New class scheduled: Physics - Newton's Laws of Motion starts in 30 minutes",
      "color": Colors.blue,
    },
    {"id": 3, "text": "Upcoming test: Chemistry - Chemical Bonding tomorrow at 10:00 AM", "color": Colors.orange},
    {"id": 4, "text": "Congratulations! You've moved up to Rank #5 in the weekly leaderboard", "color": Colors.pink},
    {"id": 5, "text": "Reminder: Your Science project submission is due in 24 hours", "color": Colors.red},
  ];

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Notification"),
            content: Text(message),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("OK"))],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Important Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Dismissible(
                    key: Key(notification['id'].toString()),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      color: notification['color'],
                      child: ListTile(
                        title: Text(notification['text'], style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              notifications.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text("Recent Activities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _activityButton("CLASS STARTED", Colors.green, "Your class has started. Join now!"),
                _activityButton("TEST REMINDER", Colors.blue, "Reminder: Your test starts in 1 hour."),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _activityButton("SCORE RELEASED", Colors.orange, "Your latest test score is now available."),
                _activityButton("ASSIGNMENT DUE", Colors.red, "Reminder: Your assignment is due tomorrow."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityButton(String text, Color color, String message) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => _showPopup(message),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
