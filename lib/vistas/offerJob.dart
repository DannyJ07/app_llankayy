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
        title: Text('NUEVO REGISTRO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Precio \$',
                  ),
                  validator: (value) {
                    if (value != null && double.tryParse(value) == null) {
                      return 'Ingrese un valor numérico válido';
                    }
                    return null;
                  },
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
                      icon: Icon(Icons.calendar_today),
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
                      icon: Icon(Icons.access_time),
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
                    // Convertir selectedDate a String
                    String dateString = selectedDate != null
                        ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                        : '';

                    // Convertir selectedTime a String
                    String timeString = selectedTime != null
                        ? "${selectedTime!.hour}:${selectedTime!.minute}"
                        : '';

                    // Llamar a AddOffer con los datos convertidos a String
                    await AddOffer(
                        selectedCategory!,
                        descriptionController.text,
                        addressController.text,
                        priceController.text,
                        dateString,
                        timeString);
                  },
                  child: Text('REGISTRAR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
