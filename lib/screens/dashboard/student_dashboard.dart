import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_sidebar.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 3, 30): ['Math Class at 10 AM'],
    DateTime.utc(2025, 4, 1): ['Physics Class at 2 PM'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events.entries.firstWhere((entry) => isSameDay(entry.key, day), orElse: () => MapEntry(day, [])).value;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to make responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dashboard Title
                    Text(
                      "Student Dashboard",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                    ),
                    SizedBox(height: 20),

                    // Improved Cards Layout - One card per line for mobile
                    ..._buildStatCardsColumn(),

                    SizedBox(height: 24),

                    // Class Schedule
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4)),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Class Schedule",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          SizedBox(height: 16),
                          _buildResponsiveCalendar(isSmallScreen),
                          SizedBox(height: 16),
                          if (_selectedDay != null && _getEventsForDay(_selectedDay!).isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Events for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}:",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                                  ),
                                  SizedBox(height: 8),
                                  ..._getEventsForDay(_selectedDay!).map(
                                    (event) => Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.event, color: Colors.redAccent, size: 16),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              event,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blueGrey[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Test Performance Line Chart
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4)),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Test Performance",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: _buildTestPerformanceChart(isSmallScreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Learning Activities (Progress) Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4)),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Learning Activities",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.arrow_upward, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                "35% more activities this month",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          _buildActivityTimeline(),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Attendance Graph
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4)),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance Overview",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Calculate bar width based on container width
                                final barWidth = (constraints.maxWidth - 80) / 5;
                                return BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    barGroups: [
                                      BarChartGroupData(
                                        x: 1,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 80,
                                            color: Colors.blue,
                                            width: barWidth * 0.7, // Responsive width
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 2,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 60,
                                            color: Colors.green,
                                            width: barWidth * 0.7,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 3,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 70,
                                            color: Colors.orange,
                                            width: barWidth * 0.7,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 4,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 50,
                                            color: Colors.red,
                                            width: barWidth * 0.7,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 5,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 75,
                                            color: Colors.purple,
                                            width: barWidth * 0.7,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      ),
                                    ],
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 20,
                                          getTitlesWidget:
                                              (value, meta) => Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                  "${value.toInt()}%",
                                                  style: TextStyle(
                                                    color: Colors.blueGrey[600],
                                                    fontSize: isSmallScreen ? 10 : 12,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget:
                                              (value, meta) => Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  ["M", "T", "W", "T", "F"][value.toInt() - 1],
                                                  style: TextStyle(
                                                    color: Colors.blueGrey[600],
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isSmallScreen ? 10 : 12,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(
                                      show: true,
                                      horizontalInterval: 20,
                                      getDrawingHorizontalLine:
                                          (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
                                      drawVerticalLine: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Sidebar overlay
          CustomSidebar(userType: 'student'),
        ],
      ),
    );
  }

  // Learning activities timeline
  Widget _buildActivityTimeline() {
    final activities = [
      {'title': 'Completed Math Quiz', 'date': '22 DEC 7:20 PM', 'color': Colors.green, 'icon': Icons.school},
      {
        'title': 'Science Lab Report Submitted',
        'date': '21 DEC 11 PM',
        'color': Colors.redAccent,
        'icon': Icons.science,
      },
      {'title': 'History Essay Completed', 'date': '21 DEC 9:34 PM', 'color': Colors.blue, 'icon': Icons.history_edu},
      {
        'title': 'New Study Topic Unlocked',
        'date': '20 DEC 2:20 AM',
        'color': Colors.orange,
        'icon': Icons.auto_stories,
      },
      {
        'title': 'Achieved Gold Badge in Physics',
        'date': '18 DEC 4:54 AM',
        'color': Colors.pink,
        'icon': Icons.emoji_events,
      },
    ];

    return Column(
      children: List.generate(activities.length, (index) {
        final activity = activities[index];
        final isLast = index == activities.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline line and dot
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: activity['color'] as Color, shape: BoxShape.circle),
                    child: Icon(activity['icon'] as IconData, color: Colors.white, size: 20),
                  ),
                  if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey.withOpacity(0.3))),
                ],
              ),
              SizedBox(width: 16),
              // Activity content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blueGrey[800]),
                      ),
                      SizedBox(height: 4),
                      Text(activity['date'] as String, style: TextStyle(fontSize: 13, color: Colors.blueGrey[500])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Test performance line chart
  Widget _buildTestPerformanceChart(bool isSmallScreen) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    value.toInt().toString(),
                    style: TextStyle(color: Colors.blueGrey[600], fontSize: isSmallScreen ? 10 : 12),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const texts = ['Test 1', 'Test 2', 'Test 3'];
                if (value.toInt() >= 0 && value.toInt() < texts.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      texts[value.toInt()],
                      style: TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: isSmallScreen ? 10 : 12,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            left: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
          ),
        ),
        minX: 0,
        maxX: 2,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          // Math scores
          LineChartBarData(
            spots: [FlSpot(0, 78), FlSpot(1, 82), FlSpot(2, 87)],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.1)),
          ),
          // English scores
          LineChartBarData(
            spots: [FlSpot(0, 85), FlSpot(1, 82), FlSpot(2, 89)],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.1)),
          ),
          // Chemistry scores
          LineChartBarData(
            spots: [FlSpot(0, 70), FlSpot(1, 76), FlSpot(2, 82)],
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.orange.withOpacity(0.1)),
          ),
          // Physics scores
          LineChartBarData(
            spots: [FlSpot(0, 65), FlSpot(1, 79), FlSpot(2, 85)],
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.purple.withOpacity(0.1)),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => Colors.blueGrey.shade700.withOpacity(0.8),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                String subject;

                if (spot.barIndex == 0) {
                  subject = 'Math';
                } else if (spot.barIndex == 1) {
                  subject = 'English';
                } else if (spot.barIndex == 2) {
                  subject = 'Chemistry';
                } else {
                  subject = 'Physics';
                }

                return LineTooltipItem(
                  '$subject: ${spot.y.toInt()}%',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  // Helper method to build responsive calendar
  Widget _buildResponsiveCalendar(bool isSmallScreen) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      eventLoader: _getEventsForDay,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.7), shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: Colors.purpleAccent, shape: BoxShape.circle),
        markerDecoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
        // Adjust text size for smaller screens
        defaultTextStyle: TextStyle(fontSize: isSmallScreen ? 12 : 14),
        weekendTextStyle: TextStyle(fontSize: isSmallScreen ? 12 : 14),
        outsideTextStyle: TextStyle(fontSize: isSmallScreen ? 12 : 14, color: Colors.grey),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: isSmallScreen ? 16 : 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        // Make header smaller for mobile screens
        headerPadding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8.0 : 16.0),
      ),
      availableGestures: AvailableGestures.all,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.blueGrey[600], fontSize: isSmallScreen ? 11 : 13),
        weekendStyle: TextStyle(color: Colors.blueGrey[600], fontSize: isSmallScreen ? 11 : 13),
      ),
      calendarBuilders: CalendarBuilders(
        // Optimize for smaller screens
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);
          final displayText = isSmallScreen ? text[0] : text.substring(0, min(text.length, 3));
          return Center(
            child: Text(displayText, style: TextStyle(color: Colors.blueGrey[600], fontSize: isSmallScreen ? 11 : 13)),
          );
        },
      ),
    );
  }

  // Helper function to limit string length
  int min(int a, int b) {
    return a < b ? a : b;
  }

  // Build stat cards in vertical column layout
  List<Widget> _buildStatCardsColumn() {
    final cards = [
      _mobileStatCard(
        title: "Study Hours",
        value: "15:21",
        icon: Icons.schedule,
        backgroundColor: Colors.white,
        iconBackgroundColor: Color(0xFF303030),
        iconColor: Colors.white,
        trend: "+12% This Week",
        trendColor: Colors.green,
      ),
      SizedBox(height: 12),
      _mobileStatCard(
        title: "Classes Taken",
        value: "8",
        icon: Icons.bar_chart,
        backgroundColor: Colors.white,
        iconBackgroundColor: Color(0xFF3498DB),
        iconColor: Colors.white,
        trend: "+2 This Week",
        trendColor: Colors.green,
      ),
      SizedBox(height: 12),
      _mobileStatCard(
        title: "Average Test Score",
        value: "85%",
        icon: Icons.assignment,
        backgroundColor: Colors.white,
        iconBackgroundColor: Color(0xFF2ECC71),
        iconColor: Colors.white,
        trend: "+14% vs Last Month",
        trendColor: Colors.green,
      ),
      SizedBox(height: 12),
      _mobileStatCard(
        title: "Rank",
        value: "12",
        icon: Icons.people,
        backgroundColor: Colors.white,
        iconBackgroundColor: Color(0xFFE74C3C),
        iconColor: Colors.white,
        trend: "+3 Spots Up",
        trendColor: Colors.green,
      ),
    ];

    return cards;
  }

  // Mobile-friendly stat card (one card per line)
  Widget _mobileStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color backgroundColor,
    required Color iconBackgroundColor,
    required Color iconColor,
    String? trend,
    Color? trendColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main card
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4))],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(75, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontSize: 14, color: Colors.blueGrey[600])),
                      if (trend != null)
                        Text(
                          trend,
                          style: TextStyle(
                            fontSize: 12,
                            color: trendColor ?? Colors.blueGrey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
                ],
              ),
            ),
          ),

          // Overlapping icon
          Positioned(
            left: 0,
            top: 50 - 25, // Center vertically
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1, offset: Offset(0, 2))],
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
          ),
        ],
      ),
    );
  }
}
