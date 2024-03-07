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

Future<List> ListOffer() async {
  List offers = [];
  CollectionReference collectionOffer = db.collection('offer');

  QuerySnapshot queryOffer = await collectionOffer.get();

  queryOffer.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final offer = {
      "Categoría": data['Categoría'],
      "Descripción": data['Descripción'],
      "Dirección": data['Dirección'],
      "Precio": data['Precio'],
      "Fecha": data['Fecha'],
      "Hora": data['Hora'],
      "uid": documento.id
    };
    offers.add(offer);
  });

  return offers;
}
