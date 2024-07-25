import 'package:flutter/material.dart';
import 'mi_cuenta_screen.dart'; // Importa la nueva pantalla
import 'carrito_screen.dart'; // Importa la pantalla de Carrito


class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Acción para retroceder
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/Logo.png', // Ruta del logo en assets
              height: 50,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Mi cuenta'),
                subtitle: Text('213360@ids.upchiapas.edu.mx'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MiCuentaScreen()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Cambiar mi contraseña'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.subscriptions),
                title: Text('Mi suscripción'),
                subtitle: Text('Mensual, finalizará el 30/10/2024'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('Idioma'),
                subtitle: Text('Español'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.article),
                title: Text('Cosas aburridas'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Términos de servicio'),
                    SizedBox(height: 4.0),
                    Text('Contacto'),
                    SizedBox(height: 4.0),
                    Text('Ayuda'),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.add_circle),
                title: Text('Agregar Productos'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Agregar Producto'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Nombre del Producto'),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Descripción'),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Precio'),
                          ),
                          // Agrega un campo para la imagen si es necesario
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Código para guardar el producto
                            Navigator.pop(context);
                          },
                          child: Text('Guardar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar sesión'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
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
        currentIndex: 2, // Index 2 seleccionado por defecto (Perfil)
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Navegar a HomeScreen al tocar "Inicio"
              break;
            case 1:
            // Navegar a la pantalla de carrito (debes implementar esto)
              break;
            case 2:
            // Ya estamos en la pantalla de perfil, no se necesita acción
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
        child: Text('Contenido de la pantalla de inicio'),
      ),
    );
  }
}