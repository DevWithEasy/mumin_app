import 'package:hijri/hijri_calendar.dart';

class DateService {
  /// Method to get the current English date in Bengali format
  static String getCurrentBengaliDate() {
    const List<String> bengaliMonths = [
      "জানুয়ারি", "ফেব্রুয়ারি", "মার্চ", "এপ্রিল", "মে", "জুন",
      "জুলাই", "আগস্ট", "সেপ্টেম্বর", "অক্টোবর", "নভেম্বর", "ডিসেম্বর"
    ];

    DateTime now = DateTime.now();
    String day = _convertToBengaliNumber(now.day);
    String month = bengaliMonths[now.month - 1];
    String year = _convertToBengaliNumber(now.year);

    return '$day $month $year';
  }

/// Method to get today's Hijri date dynamically
static String getTodayHijriDate() {
   HijriCalendar hijriDate = HijriCalendar.now();

   String hijriDay = _convertToBengaliNumber(hijriDate.hDay);
   String hijriMonth = _getHijriMonthName(hijriDate.hMonth);
   String hijriYear = _convertToBengaliNumber(hijriDate.hYear);

   return '$hijriDay $hijriMonth $hijriYear';
}

/// Helper method to convert Hijri month number to name in Bengali
static String _getHijriMonthName(int month) {
   const List<String> hijriMonths = [
       "মুহররম", "সফর", "রবিউল আওয়াল", "রবিউস সানি",
       "জমাদিউল আওয়াল", "জমাদিউল সানি", "রজব",
       "শাবান", "রমজান", "শাওয়াল",
       "জিলক্বদ", "জিলহজ্জ"
   ];
    
   return hijriMonths[month -1];
}

/// Method to get today's day name in Bengali
static String getTodayBengaliDayName() {
  const List<String> bengaliDays = [
    "রবিবার", "সোমবার", "মঙ্গলবার", "বুধবার", "বৃহস্পতিবার", "শুক্রবার", "শনিবার"
  ];

  DateTime now = DateTime.now();
  return bengaliDays[now.weekday % 7];
}

/// Helper method to convert numbers to Bengali script.
static String _convertToBengaliNumber(int number) {
   const List<String> bengaliDigits = [
       '০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'
   ];
    
   return number.toString().split('').map((digit) => bengaliDigits[int.parse(digit)]).join('');
}
}
