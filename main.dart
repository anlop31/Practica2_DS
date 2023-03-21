import 'Panaderia.dart';
import 'Analista.dart';
import 'Encargado.dart';

void main() async{
    Panaderia panaderia = new Panaderia();

    Encargado encargado = new Encargado();
    Analista analista = new Analista();

    
    // Threads (Futures)
    // Future<Panaderia> future = new Future(() {
    //   return panaderia;
    // });

    Future<Panaderia> future = Future(() => Panaderia());

    // Añadimos los observadores a la panaderia
    /* Analista se suscribe a la panaderia */
    panaderia.adscribir(analista);

    panaderia.adscribir(encargado);


    // future.then((panaderia){
    //     encargado.update(panaderia);
    //     print("Panadería en uso.");
    // });


    // while(await future.then((panaderia) {

    //     return true;
    // })) {}

    do {
        print("Panaderia en uso");

        await Future.value();

        if(panaderia.getNSimples() + panaderia.getNCompuestos() == 0){
            future = null;
        }
    } while(future != null);

    // para pararlo future = null; con un if nProd = 0
    
}