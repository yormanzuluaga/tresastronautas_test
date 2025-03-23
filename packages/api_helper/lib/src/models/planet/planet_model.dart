class PlanetModel {
  String? msg;
  List<Datum>? data;

  PlanetModel({
    this.msg,
    this.data,
  });

  PlanetModel copyWith({
    String? msg,
    List<Datum>? data,
  }) =>
      PlanetModel(
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? name;
  int? orbitalDistanceKm;
  int? equatorialRadiusKm;
  dynamic volumeKm3;
  String? massKg;
  num? densityGCm3;
  num? surfaceGravityMS2;
  int? escapeVelocityKmh;
  num? dayLengthEarthDays;
  num? yearLengthEarthDays;
  int? orbitalSpeedKmh;
  String? atmosphereComposition;
  int? moons;
  String? image;
  String? description;
  int? yearLengthEarthYears;

  Datum({
    this.name,
    this.orbitalDistanceKm,
    this.equatorialRadiusKm,
    this.volumeKm3,
    this.massKg,
    this.densityGCm3,
    this.surfaceGravityMS2,
    this.escapeVelocityKmh,
    this.dayLengthEarthDays,
    this.yearLengthEarthDays,
    this.orbitalSpeedKmh,
    this.atmosphereComposition,
    this.moons,
    this.image,
    this.description,
    this.yearLengthEarthYears,
  });

  Datum copyWith({
    String? name,
    int? orbitalDistanceKm,
    int? equatorialRadiusKm,
    dynamic volumeKm3,
    String? massKg,
    num? densityGCm3,
    num? surfaceGravityMS2,
    int? escapeVelocityKmh,
    num? dayLengthEarthDays,
    num? yearLengthEarthDays,
    int? orbitalSpeedKmh,
    String? atmosphereComposition,
    int? moons,
    String? image,
    String? description,
    int? yearLengthEarthYears,
  }) =>
      Datum(
        name: name ?? this.name,
        orbitalDistanceKm: orbitalDistanceKm ?? this.orbitalDistanceKm,
        equatorialRadiusKm: equatorialRadiusKm ?? this.equatorialRadiusKm,
        volumeKm3: volumeKm3 ?? this.volumeKm3,
        massKg: massKg ?? this.massKg,
        densityGCm3: densityGCm3 ?? this.densityGCm3,
        surfaceGravityMS2: surfaceGravityMS2 ?? this.surfaceGravityMS2,
        escapeVelocityKmh: escapeVelocityKmh ?? this.escapeVelocityKmh,
        dayLengthEarthDays: dayLengthEarthDays ?? this.dayLengthEarthDays,
        yearLengthEarthDays: yearLengthEarthDays ?? this.yearLengthEarthDays,
        orbitalSpeedKmh: orbitalSpeedKmh ?? this.orbitalSpeedKmh,
        atmosphereComposition: atmosphereComposition ?? this.atmosphereComposition,
        moons: moons ?? this.moons,
        image: image ?? this.image,
        description: description ?? this.description,
        yearLengthEarthYears: yearLengthEarthYears ?? this.yearLengthEarthYears,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        orbitalDistanceKm: json["orbital_distance_km"],
        equatorialRadiusKm: json["equatorial_radius_km"],
        volumeKm3: json["volume_km3"],
        massKg: json["mass_kg"],
        densityGCm3: json["density_g_cm3"],
        surfaceGravityMS2: json["surface_gravity_m_s2"],
        escapeVelocityKmh: json["escape_velocity_kmh"],
        dayLengthEarthDays: json["day_length_earth_days"],
        yearLengthEarthDays: json["year_length_earth_days"],
        orbitalSpeedKmh: json["orbital_speed_kmh"],
        atmosphereComposition: json["atmosphere_composition"],
        moons: json["moons"],
        image: json["image"],
        description: json["description"],
        yearLengthEarthYears: json["year_length_earth_years"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "orbital_distance_km": orbitalDistanceKm,
        "equatorial_radius_km": equatorialRadiusKm,
        "volume_km3": volumeKm3,
        "mass_kg": massKg,
        "density_g_cm3": densityGCm3,
        "surface_gravity_m_s2": surfaceGravityMS2,
        "escape_velocity_kmh": escapeVelocityKmh,
        "day_length_earth_days": dayLengthEarthDays,
        "year_length_earth_days": yearLengthEarthDays,
        "orbital_speed_kmh": orbitalSpeedKmh,
        "atmosphere_composition": atmosphereComposition,
        "moons": moons,
        "image": image,
        "description": description,
        "year_length_earth_years": yearLengthEarthYears,
      };
}
