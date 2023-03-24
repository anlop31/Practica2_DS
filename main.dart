import 'Panaderia.dart';
import 'Analista.dart';
import 'Encargado.dart';
import 'dart:async';

Future<void> main() async{
    //Panaderia panaderia = new Panaderia();

    Encargado encargado = new Encargado();
    Analista analista = new Analista();

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