import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/weather_forecast.dart';
import 'package:weather_app/weather_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 15),
            icon: const Icon(Icons.refresh),
            onPressed: () {
              print("Refresh");
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "28° C",
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.sunny, size: 60),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Sunny",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Weather Forecast",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        WeatherCard(
                          icon: Icons.cloudy_snowing,
                          time: "12:00",
                          temp: "14",
                        ),
                        WeatherCard(
                          icon: Icons.cloudy_snowing,
                          time: "03:00",
                          temp: "17",
                        ),
                        WeatherCard(
                          icon: Icons.sunny,
                          time: "06:00",
                          temp: "28",
                        ),
                        WeatherCard(
                          icon: Icons.sunny,
                          time: "09:00",
                          temp: "32",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalInfoCard(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: "90",
                      ),
                      AdditionalInfoCard(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: "7.64",
                      ),
                      AdditionalInfoCard(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: "1006",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
