import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:ui';

class ARGames extends StatefulWidget {
  const ARGames({super.key});

  @override
  _ARGamesState createState() => _ARGamesState();
}

class _ARGamesState extends State<ARGames> {
  bool _showGames = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Games', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElasticIn(child: Icon(Icons.videogame_asset, size: 120, color: Colors.deepPurple)),
              SizedBox(height: 20),
              FadeInDown(
                child: Text(
                  'Explore AR-based Educational Games!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [Shadow(blurRadius: 5, color: Colors.black26)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              BounceInUp(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      _showGames = true;
                    });
                  },
                  child: Text(
                    'Start Playing',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_showGames) Expanded(child: _buildGamesGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamesGrid() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return FadeInUp(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2)],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Game ${index + 1}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
