import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Grafico extends StatelessWidget {
  final Map<dynamic, dynamic> dataMap;

  const Grafico(this.dataMap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text("Total ${dataMap["totalExtintores"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          height: 350,
          alignment: Alignment.center,
          child: charts.PieChart<Object>(
            _createData(dataMap),
            animate: true,
            animationDuration: const Duration(seconds: 2),
            defaultInteractions: false,
            behaviors: [
              charts.DatumLegend(
                outsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                horizontalFirst: false,
                desiredMaxRows: 1,
                cellPadding: const EdgeInsets.only(right: 4, bottom: 4),
                entryTextStyle: const charts.TextStyleSpec(
                  fontSize: 11,
                ),
              )
            ],
            defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 50,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside,
                    labelPadding: 5,
                    showLeaderLines: true)
              ],
            ),
          ),
        )
      ],
    );
  }

  static List<charts.Series<SituacaoLista, Object>> _createData(
      Map<dynamic, dynamic> dados) {
    List<SituacaoLista> data = [];

    double totalExtintor =
          (dados["totalVencidos"] == 0 ? 0.0 : dados["totalVencidos"]) +
              (dados["totalVencer"] == 0 ? 0.0 : dados["totalVencer"]) +
              (dados["totalFuncional"] == 0 ? 0.0 : dados["totalFuncional"]);

      double totalVencido =
          (dados["totalVencidos"] == 0 ? 0.0 : dados["totalVencidos"]) *
              100 /
              totalExtintor;
      double totalVencer =
          (dados["totalVencer"] == 0 ? 0.0 : dados["totalVencer"]) *
              100 /
              totalExtintor;
      double totalFuncional =
          (dados["totalFuncional"] == 0 ? 0.0 : dados["totalFuncional"]) *
              100 /
              totalExtintor;

      double tGeral =
          totalVencido + totalVencer + totalFuncional;

      if (tGeral > 0) {
        data = [
          SituacaoLista("Vencidos", totalVencido, Colors.red),
          SituacaoLista("Vencer", totalVencer, Colors.orange),
          SituacaoLista("Funcional", totalFuncional, Colors.green),
        ];
      } else {
        data = [
          SituacaoLista("Vencidos", 0, Colors.red),
          SituacaoLista("Vencer", 0, Colors.orange),
          SituacaoLista("Funcional", 0, Colors.green),
        ];
      }

    return [
      charts.Series<SituacaoLista, Object>(
          id: 'Setor',
          domainFn: (SituacaoLista sit, _) => sit.label,
          measureFn: (SituacaoLista sit, _) => sit.valor,
          data: data,
          labelAccessorFn: (SituacaoLista sit, _) => '${sit.valor.round()}%',
          colorFn: (SituacaoLista sit, _) =>
              charts.ColorUtil.fromDartColor(sit.colorval))
    ];
  }
}

class SituacaoLista {
  final String label;
  final double valor;
  final Color colorval;

  SituacaoLista(this.label, this.valor, this.colorval);
}
