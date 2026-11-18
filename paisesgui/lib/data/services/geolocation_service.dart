import 'package:geolocator/geolocator.dart';

class GeolocationService {
  static Future<Position> determinaPosicion() async {

    //  Declaración de variables
    bool serviceEnabled;
    LocationPermission permission;

    // Comprobamos que el servicio de geolocalización esté en funcionamiento
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Si el servicio de geolocalitzación no está activo, devolveremos un error 
      // para informar al usuario. Para ello hacemos uso de Future.error
      return Future.error('El servicio de geolocalitzación está desactivado');
    }

    // En caso que el servicio esté en funcionamiento, comprobamos los permisos:
    permission = await Geolocator.checkPermission();

    // Si no tenemos permisos...
    if (permission == LocationPermission.denied) {
      // Pedimos permiso al usuario (observemos que utilizamos await
      // para esperar que el usuario conceda explícitamente el permiso)

      permission = await Geolocator.requestPermission();

      // Si el usuario no ha concedido el permiso...
      if (permission == LocationPermission.denied) {
        // Se devuelve un error indicando que no se tienen
        // permisos para obtener la ubicación. La próxima vez
        // que se lance la aplicación se volverá a preguntar

        return Future.error(
            'No se tienen permisos para acceder a la ubicación');
      }
    }

    // Si los permisos se han denegados de forma permanente
    // lanzamos otro error:

    if (permission == LocationPermission.deniedForever) {
      return Future.error('''El acceso a la ubicación del dispositivopor parte de la 
  aplicación se ha denegado de manera persistente.\n Si queréis modificar 
  el permiso, podéis hacerlo desde la configuración de la aplicación''');
    }

    // Finalmente, si tenemos acceso a la geolocalitzación, la devolvemos:
    return await Geolocator.getCurrentPosition();
  }
}
