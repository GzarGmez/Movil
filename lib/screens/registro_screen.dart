import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _contrasenaController = TextEditingController(); // Controlador para la contraseña

  Future<void> _register() async {
    final nombre = _nombreController.text;
    final correo = _correoController.text;
    final telefono = _telefonoController.text;
    final contrasena = _contrasenaController.text; // Obtener la contraseña

    try {
      Dio dio = Dio(); // Instancia de Dio para hacer la solicitud HTTP
      final response = await dio.post(
        'http://34.231.151.154:3002/api/registro',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'telefono': telefono,
          'password': contrasena, // Incluir la contraseña en los datos
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registro exitoso');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print('Error al registrar: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.data}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la solicitud: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/Logo.png',
                  height: 150,
                ),
                const SizedBox(height: 40),
                const Text(
                  'REGISTRO',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('Nombre',
                    hintText: 'Name', controller: _nombreController),
                const SizedBox(height: 20),
                _buildTextField('Correo institucional',
                    hintText: 'example@ids.upchiapas.edu.mx',
                    controller: _correoController),
                const SizedBox(height: 20),
                _buildTextField('Telefono Personal',
                    hintText: 'numero',
                    controller: _telefonoController),
                const SizedBox(height: 20),
                _buildTextField('Contraseña',
                    hintText: 'Contraseña',
                    controller: _contrasenaController,
                    isPassword: true), // Nuevo campo para la contraseña
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _register();
                  },
                  child: const Text('Registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {String hintText = '',
      bool isPassword = false,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: isPassword ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
