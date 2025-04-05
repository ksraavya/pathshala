import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool isTeacher;

  const ProfileScreen({super.key, this.isTeacher = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Toggle switches for email notifications
  bool followsNotification = true;
  bool answersNotification = false;
  bool mentionsNotification = true;
  bool launchesNotification = false;
  bool updatesNotification = true;
  bool newsletterSubscription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with navigation
              _buildHeader(),

              // Profile banner with mountain image
              _buildBanner(),

              // Profile section with user info
              _buildProfileSection(),

              // Main content area with settings and information
              _buildMainContent(),

              // Reading section (different for teacher vs student)
              widget.isTeacher ? _buildTeachingSection() : _buildReadingSection(),
            ],
          ),
        ),
      ),
      // Floating message button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMessageDialog();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3)],
      ),
      child: Row(
        children: [
          const Icon(Icons.home, color: Colors.grey),
          const SizedBox(width: 8),
          const Text('/', style: TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          const Text('Profile', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const Spacer(),
          // Search icon for mobile that expands to search field when tapped
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              // Show search dialog or expand to search field
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Search'),
                      content: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search here',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Search')),
                      ],
                    ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.share, color: Colors.grey), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings, color: Colors.grey), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1506905925346-21bda4d32df4'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image - Fixed the negative margin issue by using Stack
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.isTeacher
                              ? 'https://images.unsplash.com/photo-1544717305-2782549b5136'
                              : 'https://images.unsplash.com/photo-1599566150163-29194dcaad36',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // User name and title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isTeacher ? 'Dr. Rajesh Sharma' : 'Anubhav Kumar',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                    ),
                    Text(
                      widget.isTeacher ? 'Physics Teacher' : 'Student Class 11th',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Action buttons in a row, wrapped for smaller screens
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionButton('App', Icons.home),
              _buildActionButton('Message', Icons.message),
              _buildActionButton('Settings', Icons.settings),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF2C3E50)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF2C3E50))),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use responsive layout based on screen width
          if (constraints.maxWidth < 768) {
            // Single column layout for mobile
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileInfoColumn(),
                const SizedBox(height: 24),
                _buildConversationsColumn(),
                const SizedBox(height: 24),
                _buildSettingsColumn(),
              ],
            );
          } else {
            // Multi-column layout for tablets and desktop
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildSettingsColumn()),
                const SizedBox(width: 16),
                Expanded(flex: 1, child: _buildProfileInfoColumn()),
                const SizedBox(width: 16),
                Expanded(flex: 1, child: _buildConversationsColumn()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildSettingsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
        ),
        const SizedBox(height: 24),
        const Text('ACCOUNT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 16),
        _buildToggleOption('Email me when someone follows me', followsNotification, (value) {
          setState(() {
            followsNotification = value;
          });
        }),
        const SizedBox(height: 16),
        _buildToggleOption('Email me when someone answers on my post', answersNotification, (value) {
          setState(() {
            answersNotification = value;
          });
        }),
        const SizedBox(height: 16),
        _buildToggleOption('Email me when someone mentions me', mentionsNotification, (value) {
          setState(() {
            mentionsNotification = value;
          });
        }),
        const SizedBox(height: 24),
        const Text('APPLICATION', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 16),
        _buildToggleOption('New launches and projects', launchesNotification, (value) {
          setState(() {
            launchesNotification = value;
          });
        }),
        const SizedBox(height: 16),
        _buildToggleOption('Monthly product updates', updatesNotification, (value) {
          setState(() {
            updatesNotification = value;
          });
        }),
        const SizedBox(height: 16),
        _buildToggleOption('Subscribe to newsletter', newsletterSubscription, (value) {
          setState(() {
            newsletterSubscription = value;
          });
        }),
      ],
    );
  }

  Widget _buildToggleOption(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Switch(value: value, onChanged: onChanged, activeColor: Colors.blue),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey))),
      ],
    );
  }

  Widget _buildProfileInfoColumn() {
    // Different profile info based on user type
    final String bio =
        widget.isTeacher
            ? 'Experienced Physics teacher with 15+ years of teaching. PhD in Applied Physics from IIT Delhi with specialization in Quantum Mechanics.'
            : 'A passionate student interested in Physics, Chemistry, and Mathematics.';

    final String name = widget.isTeacher ? 'Dr. Rajesh Sharma' : 'Anubhav Kumar';
    final String mobile = widget.isTeacher ? '+91 98765 12345' : '+91 98765 43210';
    final String email = widget.isTeacher ? 'rajesh.sharma@rsbv.edu.in' : 'anubhav.kumar@rsbv.edu.in';
    final String location = widget.isTeacher ? 'Physics Department, RSBV School, Delhi' : 'RSBV School, Delhi';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(bio, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 24),
        _buildInfoItem('Full Name:', name),
        const SizedBox(height: 12),
        _buildInfoItem('Mobile:', mobile),
        const SizedBox(height: 12),
        _buildInfoItem('Email:', email),
        const SizedBox(height: 12),
        _buildInfoItem('Location:', location),
        const SizedBox(height: 12),
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Social:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.facebook, color: Colors.blue.shade700),
            const SizedBox(width: 16),
            Icon(Icons.message, color: Colors.blue.shade400),
            const SizedBox(width: 16),
            Icon(Icons.camera_alt, color: Colors.blue.shade300),
          ],
        ),
      ],
    );
  }

  Widget _buildConversationsColumn() {
    // Different conversations based on user type
    final List<Map<String, String>> conversations =
        widget.isTeacher
            ? [
              {
                'name': 'Principal Mehta',
                'topic': 'Faculty Meeting',
                'image': 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5',
              },
              {
                'name': 'Mrs. Lakshmi',
                'topic': 'Science Department',
                'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
              },
              {
                'name': 'Anubhav Kumar',
                'topic': 'Physics Doubt',
                'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36',
              },
              {
                'name': 'Parents Committee',
                'topic': 'PTM Discussion',
                'image': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61',
              },
            ]
            : [
              {
                'name': 'Priya Gupta',
                'topic': 'Science Stream',
                'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
              },
              {
                'name': 'Arjun Singh',
                'topic': 'Mathematics Stream',
                'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
              },
              {
                'name': 'Neha Patel',
                'topic': 'Science Stream',
                'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
              },
              {
                'name': 'Rahul Verma',
                'topic': 'Mathematics Stream',
                'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
              },
            ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conversations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
        ),
        const SizedBox(height: 16),
        ...conversations.map((conversation) {
          return Column(
            children: [
              _buildConversationItem(conversation['name']!, conversation['topic']!, conversation['image']!),
              const SizedBox(height: 12),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildConversationItem(String name, String stream, String imageUrl) {
    return Row(
      children: [
        CircleAvatar(radius: 20, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
              Text(stream, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          child: const Text('REPLY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
        ),
      ],
    );
  }

  // Student-specific section
  Widget _buildReadingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Read Books',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
          ),
          const SizedBox(height: 8),
          const Text('Your reading journey and recommendations', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  _buildBookCard(
                    'Physics',
                    'Fundamentals of Physics',
                    'Essential textbook for Class 11th Physics covering mechanics, thermodynamics, and modern physics.',
                    Icons.science,
                    Colors.red,
                  ),
                  _buildBookCard(
                    'Chemistry',
                    'Organic Chemistry',
                    'Comprehensive guide to organic chemistry concepts and reactions for advanced learners.',
                    Icons.opacity,
                    Colors.pink,
                  ),
                  _buildBookCard(
                    'Mathematics',
                    'Advanced Calculus',
                    'In-depth coverage of calculus topics including limits, derivatives, and integrals.',
                    Icons.functions,
                    Colors.purple,
                  ),
                  _buildBookCard(
                    'Biology',
                    'Cell Biology',
                    'Detailed exploration of cell structure, function, and molecular biology concepts.',
                    Icons.biotech,
                    Colors.red.shade300,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Teacher-specific section
  Widget _buildTeachingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Teaching Materials',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
          ),
          const SizedBox(height: 8),
          const Text('Your courses and teaching resources', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  _buildBookCard(
                    'Class 11',
                    'Physics Lecture Notes',
                    'Comprehensive lecture notes covering mechanics, waves, thermodynamics for Class 11 students.',
                    Icons.menu_book,
                    Colors.blue,
                  ),
                  _buildBookCard(
                    'Class 12',
                    'Physics Lab Manual',
                    'Laboratory experiments and procedures for Class 12 Physics practical sessions.',
                    Icons.science,
                    Colors.green,
                  ),
                  _buildBookCard(
                    'Resources',
                    'Question Bank',
                    'Collection of practice questions and problems for exam preparation with solutions.',
                    Icons.quiz,
                    Colors.orange,
                  ),
                  _buildBookCard(
                    'Research',
                    'Quantum Physics',
                    'Research papers and advanced topics in quantum mechanics for interested students.',
                    Icons.lightbulb,
                    Colors.purple,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method to determine grid columns based on screen width
  int _getCrossAxisCount(double width) {
    if (width < 600) return 1; // Mobile: 1 column
    if (width < 900) return 2; // Small tablet: 2 columns
    if (width < 1200) return 3; // Large tablet: 3 columns
    return 4; // Desktop: 4 columns
  }

  Widget _buildBookCard(String category, String title, String description, IconData icon, Color iconColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: 16),
            Text(category, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        i % 2 == 0
                            ? 'https://images.unsplash.com/photo-1494790108377-be9c29b29330'
                            : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageDialog() {
    final List<Map<String, String>> messages =
        widget.isTeacher
            ? [
              {
                'name': 'Principal Mehta',
                'message': 'Please prepare the term report by Friday.',
                'image': 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5',
                'time': '10m ago',
              },
              {
                'name': 'Mrs. Lakshmi',
                'message': 'Can we discuss the lab equipment order?',
                'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                'time': '1h ago',
              },
              {
                'name': 'Anubhav Kumar',
                'message': 'Sir, I had a doubt in chapter 7 problem 15.',
                'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36',
                'time': '3h ago',
              },
              {
                'name': 'Parents Committee',
                'message': 'The next PTM is scheduled for next Saturday.',
                'image': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61',
                'time': 'Yesterday',
              },
            ]
            : [
              {
                'name': 'Priya Gupta',
                'message': 'Hi! Did you finish the Physics homework?',
                'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                'time': '5m ago',
              },
              {
                'name': 'Arjun Singh',
                'message': 'I shared my notes on integration. Check it out!',
                'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                'time': '1h ago',
              },
              {
                'name': 'Neha Patel',
                'message': 'Are you coming to the science club meeting?',
                'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
                'time': '3h ago',
              },
              {
                'name': 'Rahul Verma',
                'message': 'Can you help me with the calculus problem?',
                'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                'time': 'Yesterday',
              },
            ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width > 600 ? 400 : MediaQuery.of(context).size.width * 0.8,
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children:
                        messages.map((message) {
                          return Column(
                            children: [
                              _buildMessageItem(
                                message['name']!,
                                message['message']!,
                                message['image']!,
                                message['time']!,
                              ),
                              const Divider(),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(String name, String message, String imageUrl, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      onTap: () {
        // Handle message tap
      },
    );
  }
}
