// Define el repositorio de acceso a los datos
// Esta capa es la que se usa desde la aplicación para abstraer
// el acceso a los datos.
// Hemos cambiado el repositorio.
// Ahora en vez de obtenerlo de la clase PaisesApi lo obtenemos de PaisesEjemplo

import 'package:paisesgui/data/services/paises_api.dart';
import 'package:paisesgui/domain/entities/continente.dart';
import 'package:paisesgui/domain/entities/pais.dart';

class PaisesRepository {
  late final String urlBase;
  // Con late indicamos que este valor
  // se inicializar posteriormente (en el constructor)
  late PaisesApi api;

  PaisesRepository(this.urlBase) {
    api = PaisesApi(urlBase);
  }

  //Practica 5

  Future<List<Continente>> getContinentesNuevo() async {
    return (await api.getContinentes()).map((continente) {
      return Continente.fromJSON(continente);
    }).toList();
  }

  Future<List<Pais>> getPaises(String continente) async {
    return (await api.getPaises(continente)).map((pais) {
      return Pais.fromJSON(pais);
    }).toList();
  }

  Future<Pais?> getInfoPais(String pais) async {
    return await api.infoPais(pais).then((info) {
      if (info == null) {
        return null;
      }
      return Pais.fromJSON(info);
    });
  }
}
