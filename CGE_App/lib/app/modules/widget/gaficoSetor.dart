// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Grafico extends StatelessWidget {
  final Map<dynamic, dynamic> dataMap;

  const Grafico(this.dataMap, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDefaultPieChart();
  }

  SfCircularChart _buildDefaultPieChart() {
    return SfCircularChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: _getDefaultPieSeries(dataMap),
    );
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(Map dataMap) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        explode: true,
        explodeIndex: 0,
        explodeOffset: '5%',
        dataSource: <ChartSampleData>[
          if (dataMap['totalFuncional'] > 0)
          ChartSampleData(x: 'Funcional', y: dataMap['totalFuncional'], text: '${dataMap['totalFuncional']}\nFuncional', pointColor: Colors.green),
          if (dataMap['totalVencidos'] > 0)
            ChartSampleData(x: 'Vencidos', y: dataMap['totalVencidos'], text: '${dataMap['totalVencidos']}\nVencido ', pointColor: Colors.red),
          if (dataMap['totalVencer'] > 0)
            ChartSampleData(x: 'A Vencer', y: dataMap['totalVencer'], text: '${dataMap['totalVencer']}\nA Vencer ', pointColor: Colors.deepOrange),
        ],
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.text,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        startAngle: 50,
        endAngle: 50,
        dataLabelSettings: const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.inside), 
      ),
    ];
  }
}

class ChartSampleData {
  final String x;
  final num y;
  final String text;
  final Color? pointColor;

  ChartSampleData({required this.x, required this.y, required this.text, this.pointColor});
}
