import 'Panaderia.dart';
import 'Analista.dart';
import 'Encargado.dart';
import 'dart:async';

Future<void> main() async{
    //Panaderia panaderia = new Panaderia();

    Encargado encargado = new Encargado();
    Analista analista = new Analista();

    
    // Threads (Futures)
    // Future<Panaderia> future = new Future(() {
    //   return panaderia;
    // });

    // Future<Panaderia> future = Future(() => Panaderia());

    // Añadimos los observadores a la panaderia
    /* Analista se suscribe a la panaderia */
    //panaderia.adscribir(analista);

    //panaderia.adscribir(encargado);


    // do {
    //     print("Panaderia en uso");

    //     await Future.value();

    //     if(panaderia.getNSimples() + panaderia.getNCompuestos() == 0){
    //         future = null;
    //     }
    // } while(future != null);

    // para pararlo future = null; con un if nProd = 0


    Future<Panaderia> futurePanaderia = Future(() => Panaderia());
    // Creando bakery asi conseguimos que no se inicialice 2 veces
    Panaderia bakery = await futurePanaderia;
    Completer completer = Completer();

    bakery.addObserver(analista);
    bakery.addObserver(encargado);

    // Función que marca la panadería como cerrada
    void marcarPanaderiaCerrada() {
        print('La panadería ha cerrado');
        completer.complete(); // Completar el futuro
    }

    // Configurar un temporizador para marcar un tiempo límite para la panadería
    Timer(Duration(seconds: 40), marcarPanaderiaCerrada);

    // Ejecutar un proceso mientras la instancia de Future esté activa
    do {
        // print('Esperando a que la panadería esté lista para usarse...');
        // Agregar aquí el código que deseas ejecutar mientras la panadería esté activa
        
         await bakery.run();

        //encargado.update(panaderia);
        // Comprobar si el futuro ha sido completado y si la panadería sigue abierta
        //print((await futurePanaderia).estaAbierta());
    } while (!completer.isCompleted && (await futurePanaderia).estaAbierta());
    //print("Ha salido del bucle");

    
}