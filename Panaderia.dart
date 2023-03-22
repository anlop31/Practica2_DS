import 'dart:async';
import 'dart:math';
import 'Producto.dart';
import 'Observer.dart';
import 'ProductoCompuesto.dart';
import 'ProductoSimple.dart';
import 'dart:isolate';

class Panaderia extends Observable{
/*
Panaderia : se encarga de instanciar los objetos y notificar
al observador las cantidades
*/
    

    final Random rand = Random();

    int _nSimples = 0;
    int _nCompuestos = 0;
    int _nProd = 0;
    int _simplesVendidos = 0;
    int _compuestosVendidos = 0;

    //arrays de productos
    List<Producto> stockSimples = [];
    List<Producto> stockCompuestos = [];

    //array de suscriptores
    List<Observer> observadores = [];

    Panaderia() {
        stockSimples = [];
        stockCompuestos = [];
        observadores = [];
        _simplesVendidos = 0;
        _compuestosVendidos = 0;
        inicializarProductos();
    }

    bool estaCerrada = false;

    // Otros métodos de la clase...

    bool estaAbierta() {
        print("en esta abierta estacerrada es $estaCerrada");
        return !estaCerrada;
    }

    void setCerrada(bool b){
      estaCerrada = b;
    }

    void inicializarProductos() {
    //Genera las cantidades de productos de cada tipo
    //y añade dicha cantidad de productos al arraylist correspondiente
        _nSimples = rand.nextInt(20) + 10;
        _nCompuestos = rand.nextInt(20) + 10;
        _nProd = _nSimples + _nCompuestos;

        //Future.microtask(() {
            //?????????????????????????????????????????
        notifyObservers(this);
        //});

        for (int i = 0; i < _nSimples; i++) {
            this.stockSimples.add(ProductoSimple());
        }

        for (int i = 0; i < _nCompuestos; i++) {
            this.stockCompuestos.add(ProductoCompuesto());
        }

        print("Se inicializa con " + _nSimples.toString() + " productos simples y " + _nCompuestos.toString() + " compuestos.");
    }

    void adscribir(Observer observador) {
        addObserver(observador);
        observadores.add(observador);
    }

    void quitar(Observer observador) {
        observadores.remove(observador);
    }


    //Getters  
    int getNSimples(){
        return _nSimples;
    }

    int getNCompuestos(){
        return _nCompuestos;
    }

    int getSimplesVendidos(){
        return _simplesVendidos;
    }

    int getCompuestosVendidos(){
        return _compuestosVendidos;
    }

    void venderSimple(int n){
        if (_nSimples <= 0){ // si no quedan simples
            _nSimples = 0;
            print("Se han acabado los panes");
        }
        else{ // si quedan simples
            if(n <= _nSimples){
                _simplesVendidos += n;
                for (int i = 0; (i < n) && stockSimples.isNotEmpty; i++){
                    stockSimples.removeLast();
                }
                _nSimples -= n;
                print("$n panes vendidos y quedan $_nSimples == ${stockSimples.length}");
            }
            else{
            print("No hay suficientes panes");
            }
        }
        Future.delayed(const Duration(), () {
            //setChanged();
        //    notifyObservers(this);
        });
    }



    void venderCompuesto(int n){
        if(_nCompuestos <= 0){ // si no quedan compuestos
            _nCompuestos = 0;
            print("Se han acabado las cestas");
        }
        else{ // si quedan compuestos
            if(n <= _nCompuestos){
                _compuestosVendidos += n;
                for (int i = 0; (i < n) && stockCompuestos.isNotEmpty; i++){
                    stockCompuestos.removeLast();
                }
                _nCompuestos -= n;
                print("$n cestas vendidas y quedan $_nCompuestos == ${stockCompuestos.length}");
            }
            else{
                print("No hay suficientes cestas");
            }
        }
        Future.delayed(const Duration(), () {
            //setChanged();
        //    notifyObservers(this);
        });
    } 

    void venderProducto(int tipo, int cantidad){
        // Print para comprobar que está ejecutándose
        print("Se van a vender $cantidad productos de tipo $tipo");
        if (tipo == 0){
            venderSimple(cantidad);
        } else { // si tipo == 1
            venderCompuesto(cantidad);
        }
    }

void run() async{
    //Cada cierto tiempo (instante) se vende una serie de productos 
    //(cantidad) de un tipo u otro (tipo)
   // while (_nProd > 0){
        //this.setChanged();
        int instante = Random().nextInt(5000)+1000;
        int tipo = Random().nextInt(2);
        int cantidad = Random().nextInt(4)+1;
        //print(instante);
        await Future.delayed(Duration(seconds:instante));
        //print("llegamos a vender $instante");
        venderProducto(tipo, cantidad);
        

        _nProd = _nSimples + _nCompuestos;
    //}
    //print("llega al cambio");

    setCerrada(true);

}



}