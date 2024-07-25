import 'package:flutter/material.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('assets/images/camisa.png', height: 100),
                        ListTile(
                          title: Text('Camiseta slim'),
                          subtitle: Text('Blanca\n\$299.00 MXN'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('assets/images/gorra.png', height: 100),
                        ListTile(
                          title: Text('Gorra básica'),
                          subtitle: Text('Negra\n\$149.00 MXN'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Acción para ir a pagar
              },
              child: Text('Ir a pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
