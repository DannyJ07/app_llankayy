import 'package:app_llankay/servicios/serviceFirebase.dart';
import 'package:flutter/material.dart';

class Offer extends StatefulWidget {
  const Offer({Key? key}) : super(key: key);

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController askForController = TextEditingController(text: "");
  String? selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  List<String> categories = [
    'Servicios Domesticos',
    'Remodelación y construcción',
    'Salud y Belleza',
    'Reparación e instalación de equipos',
    'Servicio para mascotas',
    'Taller de carro, moto o bicicleta'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ofertar Trabajo'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 4, 62, 109),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Solicitud',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  validator: (newvalue) {
                    if (newvalue!.isEmpty) {
                      return "El campo es obligatorio";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Precio \$',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  validator: (value) {
                    if (value != null && double.tryParse(value) == null) {
                      return 'Ingrese un valor numérico válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: askForController,
                  decoration: InputDecoration(
                    labelText: 'Preguntar por',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Fecha',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            controller: TextEditingController(
                              text: selectedDate != null
                                  ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 224, 169, 3)),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Hora',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            controller: TextEditingController(
                              text: selectedTime != null
                                  ? "${selectedTime!.hour}:${selectedTime!.minute}"
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time,
                          color: Color.fromARGB(255, 224, 169, 3)),
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String dateString = selectedDate != null
                        ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                        : '';

                    String timeString = selectedTime != null
                        ? "${selectedTime!.hour}:${selectedTime!.minute}"
                        : '';

                    await AddOffer(
                      selectedCategory!,
                      descriptionController.text,
                      addressController.text,
                      priceController.text,
                      dateString,
                      timeString,
                      phoneController.text,
                      askForController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 4, 62, 109),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Publicar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
