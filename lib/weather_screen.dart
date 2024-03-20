import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather_forecast.dart';
import 'package:weather_app/weather_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  /*  ----- Future  = Promises -----  */

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      const cityName = "Mumbai";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=2e9f4be5d8b45e1dfd66a7a7a68061e5"));

      final data = jsonDecode(res.body);
      if (data["cod"] != "200") {
        throw "Something went wrong!!";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather =
        getCurrentWeather(); //***it will store future in weather variable i.e. promise in weather variable and will not call the function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather in Mumbai"),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 15),
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: weather, //***** it will call the function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final currentWeatherData = data["list"][0];
          final currentTemp = currentWeatherData["main"]["temp"];
          final currentSky = currentWeatherData["weather"][0]["main"];
          final pressure = currentWeatherData["main"]["pressure"];
          final humidity = currentWeatherData["main"]["humidity"];
          final windSpeed = currentWeatherData["wind"]["speed"];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            "${currentTemp} K",
                            style: const TextStyle(
                                fontSize: 45, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                              currentSky == "Clouds"
                                  ? Icons.cloud
                                  : currentSky == "Rain" || currentSky == "Snow"
                                      ? Icons.cloudy_snowing
                                      : Icons.sunny,
                              size: 60),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            currentSky,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Weather Forecast",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final hourlyForecast = data["list"][index + 1];
                            final hourlySky =
                                hourlyForecast["weather"][0]["main"];
                            final hourlyIcon = hourlySky == "Clouds"
                                ? Icons.cloud
                                : hourlySky == "Rain" || hourlySky == "Snow"
                                    ? Icons.cloudy_snowing
                                    : Icons.sunny;
                            final hourlyTime =
                                DateTime.parse(hourlyForecast["dt_txt"]);
                            return WeatherCard(
                              icon: hourlyIcon,
                              time: DateFormat.jm().format(hourlyTime),
                              temp: hourlyForecast["main"]["temp"].toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Additional Information",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdditionalInfoCard(
                            icon: Icons.water_drop,
                            label: "Humidity",
                            value: humidity.toString(),
                          ),
                          AdditionalInfoCard(
                            icon: Icons.air,
                            label: "Wind Speed",
                            value: windSpeed.toString(),
                          ),
                          AdditionalInfoCard(
                            icon: Icons.beach_access,
                            label: "Pressure",
                            value: pressure.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
