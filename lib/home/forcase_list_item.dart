import 'package:flutter/material.dart';
import 'package:weatherapp/networking/models/forcast.dart';
import 'package:weatherapp/utils.dart';

class ForcaseListItem extends StatelessWidget {
  const ForcaseListItem({
    super.key,
    required this.weatherItem,
  });
  final ForecastItem weatherItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getDayFromString(weatherItem.dtTxt),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Image(
              height: 20,
              image: Utils.getIconFromWeather(weatherItem),
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.renderTemperature(weatherItem.main.temp),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
