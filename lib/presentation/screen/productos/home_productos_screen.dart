import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista_tienda/infrastructure/data/local_database.dart';
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

  final nameEditController = TextEditingController();
  final priceEditController = TextEditingController();

  /// Referencia de la caja de hive
  final _productos = Hive.box('productos');

  /// Instancia de la lista
  ProductosDatabase db = ProductosDatabase();

  @override
  void initState() {
    if (_productos.isEmpty) {
      return;
    } else {
      db.cargarData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Funcion para agregar productos
    void agregarProducto() {
      setState(() {
        db.listaProductos.add(
          [nameController.text, double.parse(priceController.text)],
        );
        db.actualizarData();
      });

      nameController.clear();
      priceController.clear();
      context.pop();
    }

    /// Funcion para eliminar productos
    void eliminarProducto(int index) {
      setState(() {
        db.listaProductos.removeAt(index);
        db.actualizarData();
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

    /// Crear un formulario para editar productos
    void formEditarProducto(int index) {
      nameEditController.text = db.listaProductos[index][0];
      priceEditController.text = db.listaProductos[index][1].toString();
      showDialog(
        context: context,
        builder: (context) => AlertFormEdit(
          nameController: nameEditController,
          priceController: priceEditController,
          onEdit: () {
            setState(() {
              db.listaProductos[index][0] = nameEditController.text;
              db.listaProductos[index][1] =
                  double.parse(priceEditController.text);
              db.actualizarData();
            });
            nameEditController.clear();
            priceEditController.clear();
            context.pop();
          },
          onCanceled: () => context.pop(),
        ),
      );
    }

    const textColum = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 35),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _productos.isEmpty
          ? const Center(
              child: Text('Empiece a agregar productos'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 0.5),
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(0.5),
                        2: FlexColumnWidth(0.5),
                      },
                      children: const [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text('Nombres', style: textColum)),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text('Precio', style: textColum)),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text('Acciones', style: textColum)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: db.listaProductos.length,
                      itemBuilder: (context, index) => TablaProductos(
                        name: db.listaProductos[index][0],
                        price: double.parse(
                            db.listaProductos[index][1].toString()),
                        onDelete: () => eliminarProducto(index),
                        onEdit: () => formEditarProducto(index),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: formAgregarProducto,
        label: const Text('Agregar Producto'),
      ),
    );
  }
}
