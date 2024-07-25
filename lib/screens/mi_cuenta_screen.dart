import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: MiCuentaScreen(),
    routes: {
      '/home': (context) => HomeScreen(),
      '/cart': (context) => CarritoScreen(),
    },
  ));
}

class MiCuentaScreen extends StatefulWidget {
  @override
  _MiCuentaScreenState createState() => _MiCuentaScreenState();
}

class _MiCuentaScreenState extends State<MiCuentaScreen> {
  String _nombre = '';
  String _correo = '';
  String _telefono = '';
  String _contrasena = '';
  int _itemId = 1; // Asigna el ID del registro que deseas actualizar

  Future<void> _getData() async {
    final url = 'http://34.231.151.154:3002/api/registro';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        if (jsonData is List) {
          var item = jsonData.firstWhere((element) => element["id"] == _itemId);
          if (item != null) {
            _nombre = item['nombre'];
            _correo = item['correo'];
            _telefono = item['telefono'];
            _contrasena = item['password'];
          } else {
            print('Registro no encontrado');
          }
        }
      });
    } else {
      print('Error al obtener datos: ${response.statusCode}');
    }
  }

  Future<void> _showEditDialog() async {
    final _nombreController = TextEditingController(text: _nombre);
    final _correoController = TextEditingController(text: _correo);
    final _telefonoController = TextEditingController(text: _telefono);
    final _contrasenaController = TextEditingController(text: _contrasena);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _correoController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Número de teléfono'),
              ),
              TextField(
                controller: _contrasenaController,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Guardar cambios'),
              onPressed: () async {
                final nombre = _nombreController.text;
                final correo = _correoController.text;
                final telefono = _telefonoController.text;
                final contrasena = _contrasenaController.text;

                if (_itemId != null && _itemId > 0) {
                  final url = Uri.parse('http://34.231.151.154:3002/api/registro/$_itemId');
                  final response = await http.put(url,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: jsonEncode({
                      'nombre': nombre,
                      'correo': correo,
                      'telefono': telefono,
                      'password': contrasena,
                    })
                  );
                  print('Request Body: ${jsonEncode({
                        'nombre': nombre,
                        'correo': correo,
                        'telefono': telefono,
                        'password': contrasena,
                      })}');

                  print('Response Status Code: ${response.statusCode}');
                  print('Response Body: ${response.body}');

                  if (response.statusCode == 200) {
                    setState(() {
                      _nombre = nombre;
                      _correo = correo;
                      _telefono = telefono;
                      _contrasena = contrasena;
                    });
                    Navigator.of(context).pop(); // Cerrar la pestaña emergente
                  } else {
                    print('Error al actualizar datos: ${response.statusCode}');
                  }
                } else {
                  print('ID de registro no válido');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Cuenta'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/LogoGrande.png'),
                ),
                SizedBox(height: 16),
                Text(
                  _contrasena,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _nombre,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Correo Electrónico: $_correo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Número de Teléfono: $_telefono',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Editar'),
                  onPressed: _showEditDialog,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 2, // Establecer el índice seleccionado como 'Perfil'
        selectedItemColor: Colors.purple,
        onTap: (index) {
          // Lógica de navegación según el índice seleccionado
          switch (index) {
            case 0:
              Navigator.pushNamed(
                  context, '/home'); // Asegúrate de definir esta ruta
              break;
            case 1:
              Navigator.pushNamed(
                  context, '/cart'); // Asegúrate de definir esta ruta
              break;
            case 2:
              // Ya estamos en la pantalla de perfil, no hacemos nada
              break;
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text('Pantalla de Inicio'),
      ),
    );
  }
}

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Center(
        child: Text('Pantalla del Carrito'),
      ),
    );
  }
}
