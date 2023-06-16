import 'package:flutter/material.dart';

class AlertForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final VoidCallback? onSaved;
  final VoidCallback? onCanceled;
  const AlertForm({
    super.key,
    required this.nameController,
    required this.priceController,
    this.onSaved,
    this.onCanceled,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Producto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre del producto',
            ),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: 'Precio del producto',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCanceled,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: onSaved,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
