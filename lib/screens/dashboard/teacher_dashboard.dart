import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pathshala_dashboard/widgets/custom_sidebar.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final Color primaryColor = Colors.blueGrey.shade800;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _selectedClass = 'Class 10-A';
  String _announcementSubject = '';
  String _announcementContent = '';

  // Sample events for the calendar
  final Map<DateTime, List<Event>> _events = {};
  List<String> classes = ['Class 10-A', 'Class 9-B', 'Class 11-C', 'Class 12-D'];

  // Sample data for metrics
  final metrics = {'hoursTaught': 124, 'totalClasses': 45, 'totalStudents': 138, 'testsGraded': 92};

  // Sample data for subject scores
  final List<SubjectScore> subjectScores = [
    SubjectScore('English', 78),
    SubjectScore('Math', 65),
    SubjectScore('Physics', 72),
    SubjectScore('Chemistry', 81),
    SubjectScore('Biology', 76),
  ];

  // Sample data for assignments
  final List<Assignment> pendingAssignments = [
    Assignment('Essay on Shakespeare', 28, 'Pending'),
    Assignment('Math Problem Set #4', 23, 'Pending'),
  ];

  final List<Assignment> reviewedAssignments = [
    Assignment('Chemistry Lab Report', 30, 'Reviewed'),
    Assignment('Physics Quiz', 25, 'Reviewed'),
  ];

  final List<Assignment> gradedAssignments = [
    Assignment('History Essay', 32, 'Graded'),
    Assignment('Grammar Test', 29, 'Graded'),
  ];

  // Sample data for student progress
  final List<StudentProgress> studentProgress = [
    StudentProgress('Alex Johnson', 92, 85, 'Complete'),
    StudentProgress('Emma Davis', 88, 78, 'In Progress'),
    StudentProgress('Michael Brown', 76, 70, 'Incomplete'),
    StudentProgress('Sophia Wilson', 95, 92, 'Complete'),
    StudentProgress('James Miller', 84, 81, 'In Progress'),
  ];

  @override
  void initState() {
    super.initState();

    // Add a sample event
    final now = DateTime.now();
    final sampleEvent = Event(title: 'Physics Class', class_: 'Class 11-C', time: '10:30 AM');

    _events[DateTime(now.year, now.month, now.day + 1)] = [sampleEvent];
  }

  void _addNewEvent(String title, String class_, String time) {
    final newEvent = Event(title: title, class_: class_, time: time);

    setState(() {
      if (_events[_selectedDay] != null) {
        _events[_selectedDay]!.add(newEvent);
      } else {
        _events[_selectedDay] = [newEvent];
      }
    });
  }

  void _postAnnouncement() {
    if (_announcementSubject.isNotEmpty && _announcementContent.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Announcement posted successfully!'), backgroundColor: Colors.green));

      setState(() {
        _announcementSubject = '';
        _announcementContent = '';
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 70, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome header
                  Text(
                    'Welcome back, Professor!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  SizedBox(height: 6),
                  Text('Here\'s what\'s happening today', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 24),

                  // Metrics Cards
                  _buildMetricsCard(
                    title: 'Hours Taught',
                    value: metrics['hoursTaught']!,
                    icon: Icons.access_time,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),

                  _buildMetricsCard(
                    title: 'Total Classes',
                    value: metrics['totalClasses']!,
                    icon: Icons.class_,
                    color: Colors.purple,
                  ),
                  SizedBox(height: 16),

                  _buildMetricsCard(
                    title: 'Total Students',
                    value: metrics['totalStudents']!,
                    icon: Icons.people,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),

                  _buildMetricsCard(
                    title: 'Tests Graded',
                    value: metrics['testsGraded']!,
                    icon: Icons.grading,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 24),

                  // Calendar Section
                  _buildSectionTitle('Class Schedule'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TableCalendar(
                            firstDay: DateTime.utc(2023, 1, 1),
                            lastDay: DateTime.utc(2025, 12, 31),
                            focusedDay: _focusedDay,
                            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                            calendarFormat: _calendarFormat,
                            eventLoader: _getEventsForDay,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: CalendarStyle(
                              markerDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                            onFormatChanged: (format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            },
                          ),
                          SizedBox(height: 12),

                          // Events for selected day
                          ..._getEventsForDay(_selectedDay).map(
                            (event) => Container(
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                title: Text(event.title),
                                subtitle: Text('${event.class_} • ${event.time}'),
                                leading: Icon(Icons.event, color: primaryColor),
                              ),
                            ),
                          ),

                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () => _showAddEventDialog(),
                            icon: Icon(Icons.add),
                            label: Text('Add New Class'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Subject Scores Graph
                  _buildSectionTitle('Average Test Scores'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        height: 250,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (spot) => Colors.blueGrey.withOpacity(0.8),
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    '${subjectScores[groupIndex].subject}\n',
                                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${rod.toY.round()}%',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    if (value >= 0 && value < subjectScores.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          subjectScores[value.toInt()].subject.substring(0, 3),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    if (value % 20 == 0) {
                                      return Text(
                                        '${value.toInt()}%',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(color: Colors.grey[300], strokeWidth: 1);
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              subjectScores.length,
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: subjectScores[index].score.toDouble(),
                                    color: _getSubjectColor(index),
                                    width: 22,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Assignment Tracker
                  _buildSectionTitle('Assignment Tracker'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DefaultTabController(
                            length: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TabBar(
                                  labelColor: primaryColor,
                                  unselectedLabelColor: Colors.grey[600],
                                  indicatorColor: primaryColor,
                                  tabs: [
                                    Tab(text: 'Pending (${pendingAssignments.length})'),
                                    Tab(text: 'Reviewed (${reviewedAssignments.length})'),
                                    Tab(text: 'Graded (${gradedAssignments.length})'),
                                  ],
                                ),
                                SizedBox(
                                  height: 200,
                                  child: TabBarView(
                                    children: [
                                      _buildAssignmentList(pendingAssignments),
                                      _buildAssignmentList(reviewedAssignments),
                                      _buildAssignmentList(gradedAssignments),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Student Progress Monitor
                  _buildSectionTitle('Student Progress Monitor'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Select Class:',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                              ),
                              SizedBox(width: 16),
                              DropdownButton<String>(
                                value: _selectedClass,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedClass = newValue!;
                                  });
                                },
                                items:
                                    classes.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value));
                                    }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Attendance %', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Avg. Score', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(
                                  label: Text('Assignment Status', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                              rows:
                                  studentProgress.map((student) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(student.name)),
                                        DataCell(Text('${student.attendance}%')),
                                        DataCell(Text('${student.avgScore}%')),
                                        DataCell(
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(student.assignmentStatus),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              student.assignmentStatus,
                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Announcement Form
                  _buildSectionTitle('Post New Announcement'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Subject',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.subject),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _announcementSubject = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Announcement',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                              prefixIcon: Icon(Icons.announcement),
                            ),
                            maxLines: 5,
                            onChanged: (value) {
                              setState(() {
                                _announcementContent = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _postAnnouncement,
                            icon: Icon(Icons.send),
                            label: Text('Post Announcement'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Custom Sidebar as hamburger menu
          CustomSidebar(userType: 'teacher'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
    );
  }

  Widget _buildMetricsCard({required String title, required int value, required IconData icon, required Color color}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Text(
                        '$value',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.trending_up, color: Colors.green),
                    Text('+2 This Week', style: TextStyle(fontSize: 12, color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: -10,
          top: -10,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, spreadRadius: 2)],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentList(List<Assignment> assignments) {
    return ListView.separated(
      itemCount: assignments.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return ListTile(
          title: Text(assignment.title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${assignment.submissions} Submissions'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton(assignment.status),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.download, color: Colors.grey[700]),
                onPressed: () {},
                tooltip: 'Download All',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String status) {
    late String label;
    late Color color;

    switch (status) {
      case 'Pending':
        label = 'Review';
        color = Colors.blue;
        break;
      case 'Reviewed':
        label = 'Grade';
        color = Colors.orange;
        break;
      case 'Graded':
        label = 'View';
        color = Colors.green;
        break;
      default:
        label = 'Action';
        color = Colors.grey;
    }

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }

  Color _getSubjectColor(int index) {
    final colors = [Colors.blue, Colors.red, Colors.green, Colors.purple, Colors.orange];

    return colors[index % colors.length];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Complete':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Incomplete':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddEventDialog() {
    String title = '';
    String class_ = 'Class 10-A';
    String time = '9:00 AM';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add New Class'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Class', border: OutlineInputBorder()),
                    value: class_,
                    onChanged: (String? newValue) {
                      class_ = newValue!;
                    },
                    items:
                        classes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value));
                        }).toList(),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: 'Time', border: OutlineInputBorder()),
                    onChanged: (value) {
                      time = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  if (title.isNotEmpty) {
                    _addNewEvent(title, class_, time);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                child: Text('Add'),
              ),
            ],
          ),
    );
  }
}

// Data Models
class Event {
  final String title;
  final String class_;
  final String time;

  Event({required this.title, required this.class_, required this.time});
}

class SubjectScore {
  final String subject;
  final int score;

  SubjectScore(this.subject, this.score);
}

class Assignment {
  final String title;
  final int submissions;
  final String status; // 'Pending', 'Reviewed', 'Graded'

  Assignment(this.title, this.submissions, this.status);
}

class StudentProgress {
  final String name;
  final int attendance;
  final int avgScore;
  final String assignmentStatus; // 'Complete', 'In Progress', 'Incomplete'

  StudentProgress(this.name, this.attendance, this.avgScore, this.assignmentStatus);
}
