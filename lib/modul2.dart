import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              color: Colors.yellow,
              height: 100,
              width: 400,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Center(child: Text('Fahmi Syihaab')),
            ),

            const SizedBox(height: 20),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(color: Colors.red, height: 100, width: 100),
                Container(color: Colors.green, height: 50, width: 50),
                const Text('Tengah', style: TextStyle(color: Colors.white)),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 150, 
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Container(
                    color: Colors.orange,
                    margin: const EdgeInsets.all(5),
                  ),
                  Container(
                    color: Colors.purple,
                    margin: const EdgeInsets.all(5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 150, 
              child: ListView(
                children: [
                  Container(
                    color: Colors.cyan,
                    height: 50,
                    margin: const EdgeInsets.all(5),
                  ),
                  Container(
                    color: Colors.teal,
                    height: 50,
                    margin: const EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: const [Icon(Icons.home), Text('Home')]),
                Column(children: const [Icon(Icons.person), Text('Profil')]),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
