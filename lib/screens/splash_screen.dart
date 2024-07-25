import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una carga o proceso inicial antes de pasar a la siguiente pantalla
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login'); // Navega al LoginScreen después de 3 segundos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cambia el color de fondo según tus necesidades
      body: Center(
        child: Image.asset(
          'assets/images/LogoGrande.png', // Ruta de tu imagen de logo
          width: 500, // Ajusta el tamaño de la imagen según sea necesario
        ),
      ),
    );
  }
}
