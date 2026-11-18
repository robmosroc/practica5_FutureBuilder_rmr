import 'package:flutter/material.dart';
import 'package:paisesgui/data/services/weather_service.dart';

class WidgetClima extends StatefulWidget {
  const WidgetClima({required this.latitud, required this.longitud, super.key});

  final double latitud;
  final double longitud;

  @override
  State<WidgetClima> createState() => _WidgetClimaState();
}

class _WidgetClimaState extends State<WidgetClima> {
  late Future<dynamic> info;

  @override
  void initState() {
    super.initState();
    // Así evitamos lanzar la petición cuando el widget se reconstruye
    info = WeatherService.obtenerClima(
      longitud: widget.longitud,
      latitud: widget.latitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: info,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // Una vez se resuelve el Future, tendremos disponible
          // la información necesaria para construir el widget

          // Obtenemos, en primer lugar, la información del snapshot

          String temperatura = snapshot.data["current_weather"]["temperature"]
              .toString();
          String velViento = snapshot.data["current_weather"]["windspeed"]
              .toString();
          String direccionViento = snapshot
              .data["current_weather"]["winddirection"]
              .toString();
          String codigo = snapshot.data["current_weather"]["weathercode"]
              .toString();

          // Y ahora creamos el widget

          return Column(
            children: [
              _obtenerIconoTiempo(codigo),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.thermostat, size: 35),
                  Text(
                    "$temperaturaº",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wind_power, size: 35),
                  const SizedBox(width: 30),
                  Text(
                    "${velViento}km/h",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 30),
                  _obtenerWidgetDireccionViento(double.parse(direccionViento)),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _obtenerWidgetDireccionViento(double direccionViento) {
    // Esta función nos devuelve un widget que contiene
    // un icono y un texto, con la dirección y el nombre del viento
    // segun su dirección.
    // Utilizamos `late` para indicar que asignaremos el valor después
    // a las variables.

    late Icon icono;
    late String nombreViento;

    if (direccionViento > 22.5 && direccionViento < 65.5) {
      icono = const Icon(Icons.north_east);
      nombreViento = "Gregal";
    } else if (direccionViento > 67.5 && direccionViento < 112.5) {
      icono = const Icon(Icons.east);
      nombreViento = "Levante";
    } else if (direccionViento > 112.5 && direccionViento < 157.5) {
      icono = const Icon(Icons.south_east);
      nombreViento = "Jaloque";
    } else if (direccionViento > 157.5 && direccionViento < 202.5) {
      icono = const Icon(Icons.south);
      nombreViento = "Mediodía";
    } else if (direccionViento > 202.5 && direccionViento < 247.5) {
      icono = const Icon(Icons.south_west);
      nombreViento = "Lebeche";
    } else if (direccionViento > 247.5 && direccionViento < 292.5) {
      icono = const Icon(Icons.west);
      nombreViento = "Poniente";
    } else if (direccionViento > 292.5 && direccionViento < 337.5) {
      icono = const Icon(Icons.north_west);
      nombreViento = "Mistral";
    } else {
      icono = const Icon(Icons.north);
      nombreViento = "Tramontana";
    }
    return Row(
      children: [
        Text(nombreViento, style: Theme.of(context).textTheme.headlineSmall),
        icono,
      ],
    );
  }

  Widget _obtenerIconoTiempo(String value) {
    Set<String> sol = <String>{"0"};
    Set<String> pocasNubes = <String>{"1", "2", "3"};
    Set<String> nubes = <String>{"45", "48"};
    Set<String> lluviaSuave = <String>{"51", "53", "55"};
    Set<String> lluvia = <String>{
      "61",
      "63",
      "65",
      "66",
      "67",
      "80",
      "81",
      "82",
      "95",
      "96",
      "99",
    };
    Set<String> nieve = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/png/soleado.png");
    }
    if (pocasNubes.contains(value)) {
      return Image.asset("assets/icons/png/poco_nublado.png");
    }
    if (nubes.contains(value)) {
      return Image.asset("assets/icons/png/nublado.png");
    }
    if (lluviaSuave.contains(value)) {
      return Image.asset("assets/icons/png/lluvia_debil.png");
    }
    if (lluvia.contains(value)) {
      return Image.asset("assets/icons/png/lluvia.png");
    }
    if (nieve.contains(value)) {
      return Image.asset("assets/icons/png/nieve.png");
    }

    return Image.asset("assets/icons/png/poco_nublado.png");
  }
}
