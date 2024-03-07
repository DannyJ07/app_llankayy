import 'dart:io';

import 'package:app_llankay/servicios/serviceFirebase.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchJob extends StatefulWidget {
  const SearchJob({Key? key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OFERTAS DE TRABAJO'),
      ),
      body: FutureBuilder(
        future: ListOffer(),
        builder: ((context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final offer = snapshot.data?[index];
                return GestureDetector(
                  onTap: () {
                    _showOfferDetails(context, offer!);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Precio: ${offer['Precio']}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Categoría: ${offer['Categoría']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  void _showOfferDetails(BuildContext context, Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalles de la oferta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Categoría: ${offer['Categoría']}'),
              Text('Descripción: ${offer['Descripción']}'),
              Text('Dirección: ${offer['Dirección']}'),
              Text('Fecha: ${offer['Fecha']}'),
              Text('Hora: ${offer['Hora']}'),
              Text('Precio: ${offer['Precio']}'),
              Text('Contacto: ${offer['Contacto']}'),
              ElevatedButton(
                onPressed: () async {
                  String telefono = offer[
                      'Telefono']; // Obtenga el número de teléfono de la oferta
                  final url = 'tel:$telefono';

                  if (await canLaunch(url)) {
                    try {
                      await launch(url);
                    } catch (error) {
                      // Maneje los errores aquí
                      print(error);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text('No se pudo llamar al contacto.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Aceptar'),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    // Solicite permisos para Android si es necesario
                    if (Platform.isAndroid) {
                      await Permission.phone.request();
                      if (await Permission.phone.isGranted) {
                        await launch(url);
                      } else {
                        // Maneje el denegación de permisos
                      }
                    } else {
                      // Maneje dispositivos que no sean Android
                    }
                  }
                },
                child: Text('CONTACTAR'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
