import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';

class UploadARModelScreen extends StatefulWidget {
  const UploadARModelScreen({Key? key}) : super(key: key);

  @override
  _UploadARModelScreenState createState() => _UploadARModelScreenState();
}

class _UploadARModelScreenState extends State<UploadARModelScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFileName;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _scaleController = TextEditingController(text: "0.5 0.5 0.5");
  final TextEditingController _rotationController = TextEditingController(text: "0 0 0");
  final TextEditingController _positionController = TextEditingController(text: "0 0 0");

  Future<void> _pickGlbFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['glb']);

    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
      });
    }
  }

  void _uploadModel() {
    if (_formKey.currentState!.validate()) {
      // This would connect to backend in a real implementation
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('This is a demo. No actual upload happens.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text('AR Models'),
        actions: [
          IconButton(icon: const Icon(Icons.language), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Upload AR Model',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Upload GLB File Button
                  ElevatedButton.icon(
                    onPressed: _pickGlbFile,
                    icon: const Icon(Icons.upload_file),
                    label: Text(_selectedFileName ?? 'UPLOAD GLB FILE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Model Title Field
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Model Title *', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Subject Field
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'Subject *', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Category Field
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category *', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Scale Field
                  TextFormField(
                    controller: _scaleController,
                    decoration: const InputDecoration(labelText: 'Scale (x y z) *', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter scale values';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Model Description *',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Rotation and Position Fields in a Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _rotationController,
                          decoration: const InputDecoration(
                            labelText: 'Rotation (x y z)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _positionController,
                          decoration: const InputDecoration(
                            labelText: 'Position (x y z)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Upload Model Button
                  ElevatedButton.icon(
                    onPressed: _uploadModel,
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('UPLOAD MODEL'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    _positionController.dispose();
    super.dispose();
  }
}
