import 'package:flutter/material.dart';
import 'package:clouds_app/widgets/hourly_cloud_data.dart';
import 'package:clouds_app/widgets/daily_cloud_data.dart';

class CloudMainScreen extends StatefulWidget {
  final dailyData;
  final hourlyData;

  const CloudMainScreen({this.dailyData, this.hourlyData});

  @override
  State<CloudMainScreen> createState() => _CloudMainScreenState();
}

class _CloudMainScreenState extends State<CloudMainScreen> {
  dynamic dailyWeatherData;
  dynamic hourlyWeatherData;
  late int hourlyWeatherDataLength;
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    hourlyWeatherData = widget.hourlyData;
    dailyWeatherData = widget.dailyData;
    hourlyWeatherDataLength = hourlyWeatherData.length;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 200.0,
            collapsedHeight: 100.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black, // Status bar color
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                // Background layers
                Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedOpacity(
                      opacity: _scrollOffset >= 10.0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Image.asset(
                        'assets/starry_night.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _scrollOffset < 100 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Image.asset(
                        'assets/sunset_forest.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                // Centered DailyCloudData
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0), // Moves DailyCloudData 16 pixels down
                    child: DailyCloudData(dailyWeatherData),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      HourlyCloudData(hourlyWeatherData, index),
                      const SizedBox(height: 20),
                      const Divider(height: 2),
                    ],
                  ),
                );
              },
              childCount: hourlyWeatherDataLength,
            ),
          ),
        ],
      ),
    );
  }
}
