import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String videoPath;

  const VideoWidget({required this.videoPath, super.key});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(widget.videoPath)
          ..initialize().then((_) {
            setState(() {});
          })
          ..setLooping(true)
          ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
        : Container(height: 150, color: Colors.black26);
  }
}

class VirtualClassroomScreen extends StatelessWidget {
  final List<Map<String, String>> classes = [
    {
      "title": "Mathematics Class",
      "description": "Join your classmates in an interactive mathematics session...",
      "video": "assets/videos/class1.mp4",
      "link": "https://www.spatial.io/s/History-Class-Re6654-67e58a5d421b9508955eed40?share=3148705785012351695",
    },
    {
      "title": "Physics Class",
      "description": "Experience physics concepts through interactive simulations...",
      "video": "assets/videos/class2.mp4",
      "link": "https://www.spatial.io/s/History-Class-Re6654-67e58a5d421b9508955eed40?share=3148705785012351695",
    },
    {
      "title": "Chemistry Lab",
      "description": "Conduct virtual chemistry experiments in a safe environment...",
      "video": "assets/videos/class3.mp4",
      "link":
          "https://www.spatial.io/s/another_badger479s-3D-Hangout-67e58c7c1c467e8ae4c49c32?share=6928208671902124317",
    },
  ];

  VirtualClassroomScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text("Virtual Classroom", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Icon(Icons.timer, color: Colors.white),
                SizedBox(width: 5),
                Text("Total Study Hours: 0.00", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...classes.map(
              (classItem) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: VideoWidget(videoPath: classItem["video"]!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              classItem["title"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Text(classItem["description"]!, style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: Colors.blue),
                                SizedBox(width: 5),
                                Text("Next class starts in 15 minutes"),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.people, size: 16, color: Colors.blue),
                                SizedBox(width: 5),
                                Text("25 students attending"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _launchURL(classItem["link"]!),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                              child: const Text("Go to Classroom"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Upcoming Classes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const ListTile(
                leading: Icon(Icons.schedule, color: Colors.blue),
                title: Text("History Class - Starts in 30 minutes"),
                subtitle: Text("Instructor: Dr. Smith"),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const ListTile(
                leading: Icon(Icons.schedule, color: Colors.blue),
                title: Text("Biology Class - Starts in 1 hour"),
                subtitle: Text("Instructor: Dr. Johnson"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
