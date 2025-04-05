import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';

class ARLearningScreen extends StatefulWidget {
  const ARLearningScreen({super.key});

  @override
  _ARLearningScreenState createState() => _ARLearningScreenState();
}

class _ARLearningScreenState extends State<ARLearningScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedSubject = "All";

  final List<Map<String, String>> models = [
    {"name": "Human Skull", "file": "assets/models/skull_model.glb", "subject": "Biology"},
    {"name": "Human Cell", "file": "assets/models/human_cell_model.glb", "subject": "Biology"},
    {"name": "Drone", "file": "assets/models/drone_model.glb", "subject": "Physics"},
    {"name": "Atom Model", "file": "assets/models/atom_model.glb", "subject": "Chemistry"},
    {"name": "Laptop Model", "file": "assets/models/laptop_model.glb", "subject": "Computer Science"},
    {"name": "Solar System", "file": "assets/models/solar_system_model.glb", "subject": "Physics"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredModels =
        models
            .where(
              (model) =>
                  (selectedSubject == "All" || model["subject"] == selectedSubject) &&
                  model["name"]!.toLowerCase().contains(_searchController.text.toLowerCase()),
            )
            .toList();

    return GradientScaffold(
      appBar: AppBar(title: const Text("AR Learning")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search topics...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedSubject,
              items:
                  [
                    "All",
                    "Biology",
                    "Physics",
                    "Chemistry",
                    "Computer Science",
                  ].map((subject) => DropdownMenuItem(value: subject, child: Text(subject))).toList(),
              onChanged: (value) => setState(() => selectedSubject = value!),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredModels.length,
                itemBuilder: (context, index) {
                  final model = filteredModels[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: ModelViewer(src: model["file"]!, ar: true, autoRotate: true, disableZoom: true),
                          ),
                          const SizedBox(height: 10),
                          Text(model["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Subject: ${model["subject"]}"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ARModelViewerScreen(modelPath: model["file"]!)),
                              );
                            },
                            child: const Text("View in AR"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ARModelViewerScreen extends StatelessWidget {
  final String modelPath;

  const ARModelViewerScreen({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View in AR')),
      body: Center(child: ModelViewer(src: modelPath, ar: true, autoRotate: true, cameraControls: true)),
    );
  }
}
