import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';
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
    DateTime.utc(2025, 4, 8): ['Math Class at 10 AM'],
    DateTime.utc(2025, 4, 15): ['Physics Class at 2 PM'],
  };

  // Subject names for the line chart legend
  final List<String> subjects = ['Math', 'English', 'Chemistry', 'Physics'];
  final List<Color> subjectColors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];

  List<String> _getEventsForDay(DateTime day) {
    return _events.entries.firstWhere((entry) => isSameDay(entry.key, day), orElse: () => MapEntry(day, [])).value;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to make responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return GradientScaffold(
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
                    const SizedBox(height: 20),

                    // Improved Cards Layout - One card per line for mobile
                    ..._buildStatCardsColumn(),

                    const SizedBox(height: 24),

                    // Class Schedule
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: const Offset(0, 4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Class Schedule",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveCalendar(isSmallScreen),
                          const SizedBox(height: 16),
                          if (_selectedDay != null && _getEventsForDay(_selectedDay!).isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Events for ${DateFormat('MMM d, yyyy').format(_selectedDay!)}:",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._getEventsForDay(_selectedDay!).map(
                                    (event) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.event, color: Colors.redAccent, size: 18),
                                          const SizedBox(width: 8),
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
                    const SizedBox(height: 24),

                    // Test Performance Line Chart - Improved!
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: const Offset(0, 4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Test Performance",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          const SizedBox(height: 12),
                          // Add Legend for better understanding
                          _buildChartLegend(),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: _buildImprovedTestPerformanceChart(isSmallScreen),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Learning Activities (Progress) Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: const Offset(0, 4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Learning Activities",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.arrow_upward, color: Colors.green, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                "35% more activities this month",
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildActivityTimeline(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Attendance Graph
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: const Offset(0, 4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance Overview",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                          const SizedBox(height: 16),
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
                                                  ["Mon", "Tue", "Wed", "Thu", "Fri"][value.toInt() - 1],
                                                  style: TextStyle(
                                                    color: Colors.blueGrey[600],
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isSmallScreen ? 10 : 12,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1)),
                                    ),
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
                          // Day of week legend explanation
                          const SizedBox(height: 8),
                          Text(
                            "Days of the week",
                            style: TextStyle(fontSize: 12, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Add extra space at the bottom to prevent overflow
                    const SizedBox(height: 100),
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

  // Build chart legend
  Widget _buildChartLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: List.generate(subjects.length, (index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14, // Slightly bigger
              height: 14, // Slightly bigger
              decoration: BoxDecoration(color: subjectColors[index], shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text(
              subjects[index],
              style: TextStyle(fontSize: 12, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
            ),
          ],
        );
      }),
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
                    width: 46, // Bigger icon
                    height: 46, // Bigger icon
                    decoration: BoxDecoration(color: activity['color'] as Color, shape: BoxShape.circle),
                    child: Icon(activity['icon'] as IconData, color: Colors.white, size: 24), // Bigger icon
                  ),
                  if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey.withOpacity(0.3))),
                ],
              ),
              const SizedBox(width: 16),
              // Activity content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0), // Increased space between items
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blueGrey[800]),
                      ),
                      const SizedBox(height: 4),
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

  // Improved test performance line chart
  Widget _buildImprovedTestPerformanceChart(bool isSmallScreen) {
    // Test data
    final testLabels = ['Test 1', 'Test 2', 'Test 3'];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            axisNameWidget: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                'Score (%)',
                style: TextStyle(color: Colors.blueGrey[600], fontSize: isSmallScreen ? 10 : 12),
              ),
            ),
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
            axisNameWidget: const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text('Assessments', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final int index = value.toInt();
                if (index >= 0 && index < testLabels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      testLabels[index],
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
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            spots: const [FlSpot(0, 78), FlSpot(1, 82), FlSpot(2, 87)],
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (spot, percent, bar, index) =>
                      FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 2, strokeColor: Colors.blue),
            ),
            belowBarData: BarAreaData(show: false),
          ),
          // English scores
          LineChartBarData(
            spots: const [FlSpot(0, 85), FlSpot(1, 82), FlSpot(2, 89)],
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (spot, percent, bar, index) =>
                      FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 2, strokeColor: Colors.green),
            ),
            belowBarData: BarAreaData(show: false),
          ),
          // Chemistry scores
          LineChartBarData(
            spots: const [FlSpot(0, 70), FlSpot(1, 76), FlSpot(2, 82)],
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (spot, percent, bar, index) =>
                      FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 2, strokeColor: Colors.orange),
            ),
            belowBarData: BarAreaData(show: false),
          ),
          // Physics scores
          LineChartBarData(
            spots: const [FlSpot(0, 65), FlSpot(1, 79), FlSpot(2, 85)],
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (spot, percent, bar, index) =>
                      FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 2, strokeColor: Colors.purple),
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => Colors.blueGrey.shade800,
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(8),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                final subject = subjects[spot.barIndex];
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
        selectedDecoration: const BoxDecoration(color: Colors.purpleAccent, shape: BoxShape.circle),
        markerDecoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
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
        iconBackgroundColor: const Color(0xFF1E88E5),
        iconColor: Colors.white,
        trend: "+2 This Week",
        trendColor: Colors.green,
      ),
      const SizedBox(height: 20),
      _mobileStatCard(
        title: "Classes Taken",
        value: "8",
        icon: Icons.bar_chart,
        backgroundColor: Colors.white,
        iconBackgroundColor: const Color(0xFF3498DB),
        iconColor: Colors.white,
        trend: "+2 This Week",
        trendColor: Colors.green,
      ),
      const SizedBox(height: 20),
      _mobileStatCard(
        title: "Average Test Score",
        value: "85%",
        icon: Icons.assignment,
        backgroundColor: Colors.white,
        iconBackgroundColor: const Color(0xFF2ECC71),
        iconColor: Colors.white,
        trend: "+14% vs Last Month",
        trendColor: Colors.green,
      ),
      const SizedBox(height: 20),
      _mobileStatCard(
        title: "Rank",
        value: "12",
        icon: Icons.people,
        backgroundColor: Colors.white,
        iconBackgroundColor: const Color(0xFFE74C3C),
        iconColor: Colors.white,
        trend: "+3 Spots Up",
        trendColor: Colors.green,
      ),
    ];

    return cards;
  }

  // Mobile-friendly stat card with overlapping circular icon (half on card, half on background)
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
      height: 110, // Increased height to fix overflow
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main card
          Positioned(
            top: 25, // Push card down to allow icon to overlap
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  const BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4)),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(80, 12, 16, 12), // Increased left padding for bigger icon
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, color: Colors.blueGrey[600])),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                      ),
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
                ],
              ),
            ),
          ),
          // Overlapping circular icon that sits half on card, half on background
          Positioned(
            left: 20,
            top: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1, offset: Offset(0, 2))],
              ),
              child: Center(child: Icon(icon, color: iconColor, size: 25)),
            ),
          ),
        ],
      ),
    );
  }
}
