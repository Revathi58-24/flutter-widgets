
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';           // For charts
import 'package:table_calendar/table_calendar.dart'; // For calendar

void main() {
  runApp(MyApp());
}

//  Root Widget (StatefulWidget to handle theme switching)
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false; //  To switch between dark and light themes
  int _selectedIndex = 0;   //  To handle BottomNavigationBar selection

  // List of pages shown for each BottomNavigationBar tab
  final List<Widget> _pages = [
    ChartPage(),
    TablePage(),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Topics Demo',
      debugShowCheckedModeBanner: false,

      // Theme Setup
      theme: isDarkTheme
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),

      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Topics Demo"),

          // Theme Toggle Button (Icon size increased)
          actions: [
            IconButton(
              iconSize: 32, //  Increased icon size for better visibility
              icon: Icon(isDarkTheme ? Icons.light_mode : Icons.dark_mode),
              tooltip: "Switch Theme",
              onPressed: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                });
              },
            ),
          ],
        ),

        //  Display current page based on selected index
        body: _pages[_selectedIndex],

        // Bottom Navigation Bar (for Chart, Table, Calendar)
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Chart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart), label: 'Table'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Calendar'),
          ],
        ),
      ),
    );
  }
}


// 📊 Chart Page - Displays simple bar chart

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sales Chart (Bar Chart Example)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              //  Simple Bar Chart
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('Mon');
                              case 1:
                                return const Text('Tue');
                              case 2:
                                return const Text('Wed');
                              case 3:
                                return const Text('Thu');
                              case 4:
                                return const Text('Fri');
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),

                    //  Data for bars
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8)]),
                      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10)]),
                      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14)]),
                      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15)]),
                      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 9)]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 🧾 Table Page - Displays student data

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 5,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Score')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('john')),
                DataCell(Text('IT')),
                DataCell(Text('98')),
              ]),
              DataRow(cells: [
                DataCell(Text('james')),
                DataCell(Text('CSE')),
                DataCell(Text('95')),
              ]),
              DataRow(cells: [
                DataCell(Text('josh')),
                DataCell(Text('ECE')),
                DataCell(Text('92')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}


// 📅 Calendar Page - Displays simple calendar

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime focusedDay = DateTime.now(); // Current month/year
  DateTime? selectedDay; // User-selected day

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: TableCalendar(
          focusedDay: focusedDay,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
          },
        ),
      ),
    );
  }
}
