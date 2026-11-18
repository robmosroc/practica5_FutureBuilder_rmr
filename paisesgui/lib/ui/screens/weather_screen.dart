import 'package:flutter/material.dart';
import 'package:paisesgui/data/services/geolocation_service.dart';
import 'package:paisesgui/ui/widgets/widget_clima.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Nuestro widget principal dependerá en primera instancia
      // de la ubicación
      future: GeolocationService.determinaPosicion(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Inicialización de widget con el resultado
        Widget miTiempo;

        // Comprobamos el estado de la conexión
        if (snapshot.connectionState == ConnectionState.done) {
          // Si ha finalizado (ConnectionState.done), comprobamos si tiene errores
          if (snapshot.hasError) {
            // Si tiene errores, creeamos un un Text con el texto de este error
            debugPrint(snapshot.error.toString());
            miTiempo = Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.hasData) {
            // Si no hay errores comprobamos si hay datos, y
            // construimos con ellos el widget a mostrar.
            // Recordemos que snapshot.data contendrá el contenido
            // que ha resuelto la llamada asíncrona.
            // Si todo va bien, el resultado será un Position,
            // con la latitud i la longitud

            double longitud = snapshot.data.longitude;
            double latitud = snapshot.data.latitude;

            miTiempo = Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "Coordenadas: $latitud, $longitud",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 50),
                    WidgetClima(latitud: latitud, longitud: longitud),
                  ],
                ),
              ),
            );
            // Finalmente, devolvemos el widget que hemos construido
            return miTiempo;
          }
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
