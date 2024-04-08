import 'package:flutter/material.dart';
import 'package:weatherapp/home/home_page.dart';

class ForecastWeatherView extends StatelessWidget {
  const ForecastWeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: getScreenHeightWithoutAppBar(context) / 2,
      color: Colors.red,
    );
  }
}
