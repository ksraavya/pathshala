import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNavbarFixed = false;
  bool isDarkMode = false;
  Color selectedColor = Colors.blue;

  void _showAccessibilityPopup() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        double fontSize = 16;
        bool isColorInverted = false;
        bool isHighContrast = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Accessibility Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Font Size"),
                  Slider(
                    value: fontSize,
                    min: 12,
                    max: 24,
                    divisions: 6,
                    label: "${fontSize.toInt()}px",
                    onChanged: (value) => setState(() => fontSize = value),
                  ),
                  SwitchListTile(
                    title: Text("Color Inversion"),
                    value: isColorInverted,
                    onChanged: (value) => setState(() => isColorInverted = value),
                  ),
                  SwitchListTile(
                    title: Text("High Contrast Mode"),
                    value: isHighContrast,
                    onChanged: (value) => setState(() => isHighContrast = value),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [IconButton(icon: Icon(Icons.accessibility), onPressed: _showAccessibilityPopup)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sidenav Colors", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children:
                  [Colors.red, Colors.black, Colors.blue, Colors.green, Colors.orange]
                      .map(
                        (color) => GestureDetector(
                          onTap: () => setState(() => selectedColor = color),
                          child: Container(
                            margin: EdgeInsets.all(4),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColor == color ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 20),
            Text("Sidenav Type", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: [_buildOptionButton("Dark"), _buildOptionButton("Transparent"), _buildOptionButton("White")]),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text("Navbar Fixed"),
              value: isNavbarFixed,
              onChanged: (value) => setState(() => isNavbarFixed = value),
            ),
            SwitchListTile(
              title: Text("Light / Dark"),
              value: isDarkMode,
              onChanged: (value) => setState(() => isDarkMode = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label),
      ),
    );
  }
}
