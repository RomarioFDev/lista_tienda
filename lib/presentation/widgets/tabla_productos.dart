import 'package:flutter/material.dart';

class TablaProductos extends StatelessWidget {
  final String name;
  final double price;
  final Function()? onEdit;
  final Function()? onDelete;
  const TablaProductos({
    super.key,
    required this.name,
    required this.price,
    required this.onEdit,
    required this.onDelete,
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
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Text(name),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('$price'),
            )),
            Row(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: onDelete,
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
