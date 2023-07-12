// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutElevation extends StatefulWidget {
  final Map<dynamic, dynamic> dataMap;

  const DoughnutElevation(this.dataMap, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoughnutDefaultState createState() => _DoughnutDefaultState();
}

class _DoughnutDefaultState extends State {
  _DoughnutDefaultState();

  @override
  Widget build(BuildContext context) {
    return _buildElevationDoughnutChart();
  }

  SfCircularChart _buildElevationDoughnutChart() {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '125%',
            width: '125%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 10,
              color: const Color.fromARGB(255, 76, 0, 39),
              child: Container(),
            )),
        CircularChartAnnotation(
            widget: const Text('10',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.498), fontSize: 20)))
      ],
      series: _getElevationDoughnutSeries(),
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
              x: 'A',
              y: 50,
              pointColor: const Color.fromARGB(255, 252, 0, 0),
            ),
            ChartSampleData(
              x: 'B',
              y: 38,
              pointColor: const Color.fromRGBO(230, 230, 230, 1),
            )
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }
}

class ChartSampleData {
  final String x;
  final num y;
  final Color? pointColor;

  ChartSampleData({required this.x, required this.y, this.pointColor});
}
