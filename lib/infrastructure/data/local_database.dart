import 'package:hive_flutter/hive_flutter.dart';
// import 'package:lista_tienda/infrastructure/models/productos_model.dart';

class ProductosDatabase {
  List listaProductos = [];
  final _productos = Hive.box('productos');

  void cargarData() {
    listaProductos = _productos.get('LISTAPRODUCTOS');
  }

  void actualizarData() {
    _productos.put('LISTAPRODUCTOS', listaProductos);
  }
}
