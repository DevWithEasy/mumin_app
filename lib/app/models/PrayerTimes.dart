import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class PrayerTimes {
  Timings timings;
  Date date;
  Meta meta;

  PrayerTimes({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      timings: Timings.fromJson(json['timings']),
      date: Date.fromJson(json['date']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson(String? s) {
    return {
      'timings': timings.toJson(),
      'date': date.toJson(),
      'meta': meta.toJson(),
    };
  }

  String sunrise() {
    return convertToBanglaNumbers(extractTime(timings.sunrise));
    // return timings.sunrise;
  }

  String sunset() {
    return convertToBanglaNumbers(extractTime(timings.sunset));
    // return timings.sunset;
  }

  String sahri() {
    return calculateTime(extractTime(timings.fajr), -4);
  }

  String ifter() {
    return extractTime(timings.maghrib);
  }

  String fajr_start() {
    return extractTime(timings.fajr);
  }

  String fajr_end() {
    return extractTime(timings.sunrise);
  }

  String fajr() {
    return '${fajr_start()} - ${fajr_end()}';
  }

  String dhuhr_start() {
    return extractTime(timings.dhuhr);
  }

  String dhuhr_end() {
    return calculateTime(extractTime(timings.asr), -1);
  }

  String dhuhr() {
    return '${dhuhr_start()} - ${dhuhr_end()}';
  }

  String asr_start() {
    return extractTime(timings.asr);
  }

  String asr_end() {
    return calculateTime(extractTime(timings.maghrib), -4);
  }

  String asr() {
    return '${asr_start()} - ${asr_end()}';
  }

  String maghrib_start() {
    return extractTime(timings.maghrib);
  }

  String maghrib_end() {
    return calculateTime(extractTime(timings.isha), -1);
  }

  String maghrib() {
    return '${maghrib_start()} - ${maghrib_end()}';
  }

  String isha_start() {
    return extractTime(timings.isha);
  }

  String isha_end() {
    return calculateTime(extractTime(timings.fajr), -5);
  }

  String isha() {
    return '${isha_start()} - ${isha_end()}';
  }

  List<Map<String, String>> waktTimes() {
    return [
      {'name': 'ফজর', 'time': convertToBanglaNumbers(fajr())},
      {'name': 'যোহর', 'time': convertToBanglaNumbers(dhuhr())},
      {'name': 'আসর', 'time': convertToBanglaNumbers(asr())},
      {'name': 'মাগরিব', 'time': convertToBanglaNumbers(maghrib())},
      {'name': 'এশা', 'time': convertToBanglaNumbers(isha())},
    ];
  }

  List<Map<String, String>> calenderWaktTimes() {
    return [
      {'name': 'ফজর', 'start': convertToBanglaNumbers(fajr_start()), "end" : convertToBanglaNumbers(fajr_end())},
      {'name': 'যোহর', 'start': convertToBanglaNumbers(dhuhr_start()), "end" : convertToBanglaNumbers(dhuhr_end())},
      {'name': 'আসর', 'start': convertToBanglaNumbers(asr_start()), "end" : convertToBanglaNumbers(asr_end())},
      {'name': 'মাগরিব', 'start': convertToBanglaNumbers(maghrib_start()), "end" : convertToBanglaNumbers(maghrib_end())},
      {'name': 'এশা', 'start': convertToBanglaNumbers(isha_start()), "end" : convertToBanglaNumbers(isha_end())},
    ];
  }

  String morning() {
    String from = extractTime(timings.sunrise);
    String to = calculateTime(from, 15);
    return '$from - $to';
  }

  String noon() {
    String dhuhr = extractTime(timings.dhuhr);
    String from = calculateTime(dhuhr, -9);
    String to = calculateTime(dhuhr, -1);
    return '$from - $to';
  }

  String afternoon() {
    String maghrib = extractTime(timings.maghrib);
    String from = calculateTime(maghrib, -15);
    String to = calculateTime(maghrib, -4);
    return '$from - $to';
  }

  List<Map<String, String>> restrictedTimes() {
    return [
      {'name': 'ভোরঃ', 'time': convertToBanglaNumbers(morning())},
      {'name': 'দুপুরঃ', 'time': convertToBanglaNumbers(noon())},
      {'name': 'সন্ধ্যাঃ', 'time': convertToBanglaNumbers(afternoon())},
    ];
  }

String dayName() {
  Map<String, String> bengaliDays = {
    "Sunday": "রবিবার",
    "Monday": "সোমবার",
    "Tuesday": "মঙ্গলবার",
    "Wednesday": "বুধবার",
    "Thursday": "বৃহস্পতিবার",
    "Friday": "শুক্রবার",
    "Saturday": "শনিবার"
  };

  return bengaliDays[date.gregorian.weekday.en] ?? "অজানা দিন";
}


  String dayNumber() {
    return convertToBanglaNumbers(date.gregorian.day);
  }

  String engMonth() {
    const List<String> bengaliMonths = [
      "জানুয়ারি",
      "ফেব্রুয়ারি",
      "মার্চ",
      "এপ্রিল",
      "মে",
      "জুন",
      "জুলাই",
      "আগস্ট",
      "সেপ্টেম্বর",
      "অক্টোবর",
      "নভেম্বর",
      "ডিসেম্বর"
    ];
    return bengaliMonths[date.gregorian.month.number - 1];
  }

  String engYear() {
    return convertToBanglaNumbers(date.gregorian.year);
  }

  String hijriDayNumber() {
    return convertToBanglaNumbers(date.hijri.day);
  }

  String hijriMonth() {
    const List<String> hijriMonths = [
       "মুহররম", "সফর", "রবিউল আওয়াল", "রবিউস সানি",
       "জমাদিউল আওয়াল", "জমাদিউল সানি", "রজব",
       "শাবান", "রমজান", "শাওয়াল",
       "জিলক্বদ", "জিলহজ্জ"
   ];
    return hijriMonths[date.hijri.month.number-1];
  }

  String hijriYear() {
    return convertToBanglaNumbers(date.hijri.year);
  }

  static String extractTime(String timeString) {
    return timeString.split(' ').first;
  }

  String calculateTime(String time, int minutesToAdd) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    int totalMinutes = hours * 60 + minutes;

    totalMinutes += minutesToAdd;

    totalMinutes = totalMinutes % (24 * 60);
    if (totalMinutes < 0) {
      totalMinutes += 24 * 60;
    }

    int newHours = totalMinutes ~/ 60;
    int newMinutes = totalMinutes % 60;

    String formattedTime =
        '${newHours.toString().padLeft(2, '0')}:${newMinutes.toString().padLeft(2, '0')}';

    return formattedTime;
  }
}

class Timings {
  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String imsak;
  String midnight;
  String firstthird;
  String lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstthird: json['Firstthird'],
      lastthird: json['Lastthird'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Sunset': sunset,
      'Maghrib': maghrib,
      'Isha': isha,
      'Imsak': imsak,
      'Midnight': midnight,
      'Firstthird': firstthird,
      'Lastthird': lastthird,
    };
  }
}

class Date {
  String readable;
  String timestamp;
  Hijri hijri;
  Gregorian gregorian;

  Date({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: Hijri.fromJson(json['hijri']),
      gregorian: Gregorian.fromJson(json['gregorian']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'readable': readable,
      'timestamp': timestamp,
      'hijri': hijri.toJson(),
      'gregorian': gregorian.toJson(),
    };
  }
}

class Hijri {
  String date;
  String format;
  String day;
  Weekday weekday;
  Month month;
  String year;
  Designation designation;
  List<String> holidays;
  List<String> adjustedHolidays;
  String method;

  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      holidays: List<String>.from(json['holidays']),
      adjustedHolidays: List<String>.from(json['adjustedHolidays']),
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
      'designation': designation.toJson(),
      'holidays': holidays,
      'adjustedHolidays': adjustedHolidays,
      'method': method,
    };
  }
}

class Gregorian {
  String date;
  String format;
  String day;
  Weekday weekday;
  Month month;
  String year;
  Designation designation;
  bool lunarSighting;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      lunarSighting: json['lunarSighting'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
      'designation': designation.toJson(),
      'lunarSighting': lunarSighting,
    };
  }
}

class Weekday {
  String en;
  String? ar;

  Weekday({
    required this.en,
    this.ar,
  });

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class Month {
  int number;
  String en;
  String? ar;
  int? days;

  Month({
    required this.number,
    required this.en,
    this.ar,
    this.days,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
      days: json['days'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'en': en,
      'ar': ar,
      'days': days,
    };
  }
}

class Designation {
  String abbreviated;
  String expanded;

  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbreviated': abbreviated,
      'expanded': expanded,
    };
  }
}

class Meta {
  double latitude;
  double longitude;
  String timezone;
  Method method;
  String latitudeAdjustmentMethod;
  String midnightMode;
  String school;
  Offset offset;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      method: Method.fromJson(json['method']),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],
      offset: Offset.fromJson(json['offset']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'method': method.toJson(),
      'latitudeAdjustmentMethod': latitudeAdjustmentMethod,
      'midnightMode': midnightMode,
      'school': school,
      'offset': offset.toJson(),
    };
  }
}

class Method {
  int id;
  String name;
  Params params;
  Location location;

  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json['id'],
      name: json['name'],
      params: Params.fromJson(json['params']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'params': params.toJson(),
      'location': location.toJson(),
    };
  }
}

class Params {
  int fajr;
  int isha;

  Params({
    required this.fajr,
    required this.isha,
  });

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      fajr: json['Fajr'],
      isha: json['Isha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Isha': isha,
    };
  }
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Offset {
  int fajr;
  int sunrise;
  int dhuhr;
  int asr;
  int maghrib;
  int isha;

  Offset({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory Offset.fromJson(Map<String, dynamic> json) {
    return Offset(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
    };
  }
}
