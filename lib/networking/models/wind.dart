class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });
  late final double speed;
  late final int deg;
  late final double gust;

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}
