import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_tienda/infrastructure/models/productos_model.dart';
import 'package:lista_tienda/presentation/widgets/widgets.dart';

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
    /// Lista de productos
    List<Productos> listaProductos = [];

    /// Funcion para agregar productos
    void agregarProducto() {
      listaProductos.addAll(
        [
          Productos(
            name: nameController.text,
            price: double.parse(priceController.text),
          )
        ].toList(),
      );
      setState(() {});
      nameController.clear();
      priceController.clear();
      for (var i = 0; i < listaProductos.length; i++) {
        print(listaProductos[i].name);
      }
      context.pop();
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
        title: const Text('Prodcutos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaProductos.length,
              itemBuilder: (context, index) => TablaProductos(
                name: listaProductos[index].name,
                price: double.parse(listaProductos[index].price.toString()),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              for (var i = 0; i < listaProductos.length; i++) {
                print('''
                        ${listaProductos[i].name}
                        ${listaProductos[i].price}
                      ''');
              }
            },
            child: const Text('Imprimir'),
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
