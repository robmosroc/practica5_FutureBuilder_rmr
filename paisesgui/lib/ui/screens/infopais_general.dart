import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisesgui/data/repositories/paises_repository.dart';
import 'package:paisesgui/domain/entities/pais.dart';
import 'package:paisesgui/config/config.dart';

class InfoPaisGeneral extends StatelessWidget {
  final String nombrePais;
  InfoPaisGeneral(this.nombrePais, {super.key});

  // Referencia al repositorio, de donde obtendremos la lista de continentes
  final PaisesRepository _repository = PaisesRepository(Config.urlApi);

  @override
  Widget build(BuildContext context) {
    // Recogemos el país del repositorio
    // TO-DO
    // Añadir la información siguiente sobre el país:
    // Imagen, nombre, capital y descripción, de forma similar a como se muestra en el enunciado

    // Podéis utilizar los widgets y contenedores que consideréis oportunos (Containers, SingleChildScrollView, Columns, etc)
    // Debéis tener en cuenta no sobrepasar los límites y dibujar fuera del espacio disponible
    // Para comprobar que no os salís, podéis probar a girar el dispositivo (si lo estáis haciendo sobre Android)

    return FutureBuilder(
      future: _repository.getInfoPais(nombrePais),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
        
        if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar la información: ${snapshot.error}'),
            );
          }

        if (!snapshot.hasData) {
            return const Center(
              child: Text('No se encontró información.'),
            );
          }

        return Scaffold(
          appBar: AppBar(title: Text("Información de $nombrePais")),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(snapshot.data!.imagen ?? "", width: 750),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          snapshot.data!.nombre,
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 20,
                            color: CupertinoColors.inactiveGray,
                          ),
                          "Capital: ${snapshot.data!.capital ?? ''}",
                        ),
                        SizedBox(height: 20),
                        Text(textAlign: TextAlign.justify, snapshot.data!.descripcion ?? ""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
