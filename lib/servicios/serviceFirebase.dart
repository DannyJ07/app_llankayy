import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> AddOffer(String categoria, String descripcion, String direccion,
    String precio, String fecha, String hora) async {
  await db.collection("offer").add({
    "Categoría": categoria,
    "Descripción": descripcion,
    "Dirección": direccion,
    "Precio": precio,
    "Fecha": fecha,
    "Hora": hora
  });
}
