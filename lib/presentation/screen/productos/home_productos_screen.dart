import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_tienda/infrastructure/models/productos_model.dart';
import 'package:lista_tienda/presentation/widgets/widgets.dart';

/// Lista de productos
List<Productos> listaProductos = [];

class HomeProductosScreen extends StatefulWidget {
  static const String name = '/';
  const HomeProductosScreen({
    super.key,
  });

  @override
  State<HomeProductosScreen> createState() => _HomeProductosScreenState();
}

class _HomeProductosScreenState extends State<HomeProductosScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /// Funcion para agregar productos
    void agregarProducto() {
      setState(() {
        listaProductos.add(
          Productos(
              name: nameController.text,
              price: double.parse(priceController.text)),
        );
      });
      nameController.clear();
      priceController.clear();
      context.pop();
    }

    /// Funcion para eliminar productos
    void eliminarProducto(int index) {
      setState(() {
        listaProductos.removeAt(index);
      });
    }

    /// Crear un formulario para agregar productos
    void formAgregarProducto() {
      showDialog(
        context: context,
        builder: (context) => AlertForm(
          nameController: nameController,
          priceController: priceController,
          onSaved: agregarProducto,
          onCanceled: () => context.pop(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaProductos.length,
              itemBuilder: (context, index) => TablaProductos(
                name: listaProductos[index].name,
                price: double.parse(listaProductos[index].price.toString()),
                onDelete: () => eliminarProducto(index),
                onEdit: () {},
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: formAgregarProducto,
        label: const Text('Agregar Producto'),
      ),
    );
  }
}
