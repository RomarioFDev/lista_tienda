import 'package:flutter/material.dart';

class TablaProductos extends StatelessWidget {
  final String name;
  final double price;
  const TablaProductos({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(0.5),
          2: FlexColumnWidth(0.5),
        },
        children: [
          TableRow(children: [
            Text(name),
            Text('$price'),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            )
          ])
        ],
      ),
    );
  }
}
