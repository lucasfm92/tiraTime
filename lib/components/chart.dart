import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      ((index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum,
        };
      }),
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      label: tr['day'] as String,
                      value: tr['value'] as double,
                      percentage: _weekTotalValue == 0
                          ? 0
                          : (tr['value'] as double) / _weekTotalValue),
                );
              }).toList()),
        ),
      ),
    );
  }
}
