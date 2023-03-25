import 'Panaderia.dart';
import 'Analista.dart';
import 'Encargado.dart';
import 'dart:async';

Future<void> main() async{
    // Observadores
    Encargado encargado = new Encargado();
    Analista analista = new Analista();

    // Observable y completer
    Future<Panaderia> futurePanaderia = Future(() => Panaderia());
    Panaderia panaderia = await futurePanaderia;
    panaderia.inicializarProductos();
    Completer completer = Completer();

    // añadimos los observadores a la panaderia
    panaderia.addObserver(analista);
    panaderia.addObserver(encargado);

    // Función que marca la panadería como cerrada
    void marcarPanaderiaCerrada() {
        print('La panadería ha cerrado');
        completer.complete(); // Completar el futuro
    }

    // Configurar un temporizador para marcar un tiempo límite para la panadería
    Timer(Duration(seconds: 40), marcarPanaderiaCerrada);

    // Ejecutar un proceso mientras la instancia de Future esté activa
    do {
        await panaderia.run();
        encargado.update(panaderia);

        // Comprobar si el futuro ha sido completado y si la panadería sigue abierta
        //print((await futurePanaderia).estaAbierta());
    } while (!completer.isCompleted && (await futurePanaderia).estaAbierta());
    //print("Ha salido del bucle");

    
}