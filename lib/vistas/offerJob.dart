import 'package:flutter/material.dart';

class Offer extends StatefulWidget {
  const Offer({Key? key}) : super(key: key);

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _valueController = TextEditingController();

  String _selectedCategory = 'Servicios Domesticos';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _categories = [
    'Servicios Domesticos',
    'Remodelación y construcción',
    'Salud y Belleza',
    'Reparación e instalación de equipos',
    'Servicio para mascotas',
    'Taller de carro, moto o bicicleta'
  ];

  @override
  void initState() {
    super.initState();
    _categoryController.text = _selectedCategory;
    _updateDateTimeController();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _dateTimeController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _updateDateTimeController() {
    final formattedDate =
        '${_selectedDate.toString().split(' ')[0]} ${_selectedTime.format(context)}';
    _dateTimeController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ofertar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Solicitud',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Categoría',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCategory = value!;
                        _categoryController.text = _selectedCategory;
                      });
                    },
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Dirección',
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Valor \$',
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Text(
                      'Fecha: ${_selectedDate.toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      'Hora: ${_selectedTime.format(context)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                          _updateDateTimeController();
                        });
                      }
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null && pickedTime != _selectedTime) {
                        setState(() {
                          _selectedTime = pickedTime;
                          _updateDateTimeController();
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: screenWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String description =
                              _descriptionController.text;
                          final String address = _addressController.text;
                          final double value =
                              double.tryParse(_valueController.text) ?? 0.0;
                          final String category = _categoryController.text;
                          final String dateTime = _dateTimeController.text;

                          // Aquí puedes enviar los datos a Firebase
                          // Ejemplo:
                          // firebaseService.saveOffer(description, address, value, category, dateTime);

                          // Limpiar campos después de enviar
                          _descriptionController.clear();
                          _addressController.clear();
                          _valueController.clear();
                        }
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
