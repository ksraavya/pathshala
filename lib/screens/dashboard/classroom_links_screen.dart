import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ClassroomLinksScreen extends StatelessWidget {
  const ClassroomLinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.purple[50]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: Colors.blue,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Classroom Links',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClassroomOptionCard(
                          title: 'Live Interactive Class',
                          description: 'Host live interactive sessions with real-time student participation',
                          videoPath: 'assets/videos/class1.mp4',
                          onPressed: () => _showLinkDialog(context, 'Live Interactive Class'),
                        ),
                        const SizedBox(height: 16),
                        ClassroomOptionCard(
                          title: 'Virtual Lab Session',
                          description: 'Conduct virtual lab experiments and demonstrations',
                          videoPath: 'assets/videos/class2.mp4',
                          onPressed: () => _showLinkDialog(context, 'Virtual Lab Session'),
                        ),
                        const SizedBox(height: 16),
                        ClassroomOptionCard(
                          title: 'Group Discussion',
                          description: 'Facilitate group discussions and collaborative learning',
                          videoPath: 'assets/videos/class3.mp4',
                          onPressed: () => _showLinkDialog(context, 'Group Discussion'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLinkDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Provide Link for $title',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E4374)),
                ),
                const SizedBox(height: 24),
                const Text('Classroom Link', style: TextStyle(fontSize: 14, color: Colors.blue)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your classroom link (e.g., Zoom, Google Meet)',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for save link functionality
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text('SAVE LINK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClassroomOptionCard extends StatefulWidget {
  final String title;
  final String description;
  final String videoPath;
  final VoidCallback onPressed;

  const ClassroomOptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ClassroomOptionCard> createState() => _ClassroomOptionCardState();
}

class _ClassroomOptionCardState extends State<ClassroomOptionCard> {
  late VideoPlayerController _videoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
    _videoController = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        // Set video to loop without sound
        _videoController.setLooping(true);
        _videoController.setVolume(0.0);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    _isInitialized
                        ? VideoPlayer(_videoController)
                        : Container(color: Colors.grey[200], child: const Center(child: CircularProgressIndicator())),
                    // Play/pause button overlay
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          if (_isInitialized) {
                            setState(() {
                              _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
                            });
                          }
                        },
                        child:
                            _isInitialized && !_videoController.value.isPlaying
                                ? Container(
                                  color: Colors.black26,
                                  child: const Icon(Icons.play_arrow, size: 64, color: Colors.white),
                                )
                                : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E4374)),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(Icons.link, color: Colors.white),
              label: const Text('PROVIDE LINK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
