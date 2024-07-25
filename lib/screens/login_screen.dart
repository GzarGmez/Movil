import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Realiza la solicitud HTTP para el login
      final response = await http.post(
        Uri.parse('http://34.231.151.154:3002/api/registro'), // reemplaza con tu URL de API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve un código 200, parsea el JSON
   
        // Maneja el inicio de sesión exitoso, por ejemplo, navega a la pantalla de inicio
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Si la respuesta no fue 200, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Up Chiapas'),
      ),
      backgroundColor: Color(0xFFE6E6FA), // Define aquí el color lila que desees
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Aquí agregamos la imagen encima del formulario
              Image.asset(
                'assets/images/Logo.png',
                height: 150, // ajusta la altura según sea necesario
              ),
              SizedBox(height: 80.0), // espacio entre la imagen y el formulario
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu correo Electronico';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu contraseña!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
                    SizedBox(height: 10.0), // espacio entre el botón de login y el texto de registro
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/registro');
                      },
                      child: Text(
                        '¿No tienes cuenta? Registrate aquí',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
