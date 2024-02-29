import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const WeatherCard(
      {super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(icon, size: 30),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$temp° C",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
