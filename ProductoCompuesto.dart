import 'Producto.dart';

class ProductoCompuesto extends Producto {
  List<Producto> productos;
  int componentes;

  ProductoCompuesto()
      : productos = List<Object>(),
        componentes = 0,
        super();

  void anadirProducto(Producto prod) {
    productos.add(prod);
  }

  void eliminarProducto(Producto prod) {
    productos.remove(prod);
  }

  Producto obtenerProducto(int identificador) {
    return productos[identificador];
  }
}
