

import 'package:flutter/material.dart';
import 'package:paisesgui/data/repositories/paises_repository.dart';
import 'package:paisesgui/domain/entities/pais.dart';
import 'package:paisesgui/ui/widgets/my_weather_info.dart';
import 'package:paisesgui/config/config.dart';
import 'package:paisesgui/ui/widgets/widget_clima.dart';

class InfoPaisDetalle extends StatelessWidget {
  final String nombrePais;
  InfoPaisDetalle(this.nombrePais, {super.key});

  // Referencia al repositorio, de donde obtendremos la lista de continentes
    final PaisesRepository _repository = PaisesRepository(Config.urlApi);



  @override
  Widget build(BuildContext context) {
    // TO-DO
    // Añadir la información siguiente sobre el país:
    // Población (num. de habitantes), latitud y longitud.
    // Podéis combinar Column y Row para mostrar la información tabulada
    return FutureBuilder(
      future: _repository.getInfoPais(nombrePais),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Información de $nombrePais"),),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                spacing: 15,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child:Column(
                  children: [
                    Text(
                      "Coordenadas: ${snapshot.data!.latitud!}, ${snapshot.data!.longitud!}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 50),
                    WidgetClima(latitud: snapshot.data!.latitud!, longitud: snapshot.data!.longitud!),
                  ],
                ),
                  )  
              ],),
            ), 
          ),
        );
      }
    );
    // Antes de la información, deberemos mostrar la información sobre el tiempo en el país,
    // mediante el widtget personalizado MyWeatherInfo(), que se os proporciona ya implementado
  }
}
