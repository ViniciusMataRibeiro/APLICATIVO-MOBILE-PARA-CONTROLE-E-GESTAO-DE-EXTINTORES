// ignore_for_file: file_names
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class ExportCircular extends StatefulWidget {
  final Map<dynamic, dynamic> dataMap;

  const ExportCircular(this.dataMap, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ExportState createState() => _ExportState(dataMap);
}

class _ExportState extends State {
  final Map<dynamic, dynamic> dataMap;
  _ExportState(this.dataMap);
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y Extintor');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultDoughnutChart();
  }

  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                dataMap['totalExtintores'].toString(),
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.fire_extinguisher, size: 30, color: Colors.black)
            ],
          ),
        )
      ],
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: _tooltip,
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        radius: '85%',
        explodeOffset: '8%',
        dataSource: <ChartSampleData>[
          if (dataMap['totalFuncional'] > 0)
            ChartSampleData(
                x: 'Funcional',
                y: dataMap['totalFuncional'],
                pointColor: Colors.green),
          if (dataMap['totalVencidos'] > 0)
            ChartSampleData(
                x: 'Vencidos',
                y: dataMap['totalVencidos'],
                pointColor: Colors.red),
          if (dataMap['totalVencer'] > 0)
            ChartSampleData(
                x: 'A Vencer',
                y: dataMap['totalVencer'],
                pointColor: const Color.fromARGB(255, 255, 215, 0)),
        ],
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelPosition: ChartDataLabelPosition.inside),
      ),
    ];
  }
}

class ChartSampleData {
  final String x;
  final num y;
  final Color? pointColor;

  ChartSampleData(
      {required this.x, required this.y, this.pointColor});
}
