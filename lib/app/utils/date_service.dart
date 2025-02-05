import 'package:hijri/hijri_calendar.dart';

class DateService {
  static const List<String> banglaMonths = [
    'বৈশাখ', 'জ্যৈষ্ঠ', 'আষাঢ়', 'শ্রাবণ', 'ভাদ্র', 'আশ্বিন', 
    'কার্তিক', 'অগ্রহায়ণ', 'পৌষ', 'মাঘ', 'ফাল্গুন', 'চৈত্র'
  ];

  static const List<String> englishMonthsBangla = [
    'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
    'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
  ];

  static const List<String> hijriMonthsBangla = [
    'মুহাররম', 'সফর', 'রবিউল আউয়াল', 'রবিউস সানি', 'জমাদিউল আউয়াল', 'জমাদিউস সানি',
    'রজব', 'শাবান', 'রমজান', 'শাওয়াল', 'জিলকদ', 'জিলহজ'
  ];

  static const Map<int, int> banglaMonthStartDays = {
    1: 14,  // বৈশাখ starts on April 14
    2: 15,  // জ্যৈষ্ঠ starts on May 15
    3: 15,  // আষাঢ় starts on June 15
    4: 16,  // শ্রাবণ starts on July 16
    5: 16,  // ভাদ্র starts on August 16
    6: 16,  // আশ্বিন starts on September 16
    7: 16,  // কার্তিক starts on October 16
    8: 15,  // অগ্রহায়ণ starts on November 15
    9: 15,  // পৌষ starts on December 15
    10: 14, // মাঘ starts on January 14
    11: 13, // ফাল্গুন starts on February 13
    12: 14  // চৈত্র starts on March 14
  };

  static String convertToBanglaNumber(int number) {
    const Map<String, String> numberMap = {
      '0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪', 
      '5': '৫', '6': '৬', '7': '৭', '8': '৮', '9': '৯'
    };
    return number.toString().split('').map((e) => numberMap[e] ?? e).join();
  }

  static String getEnglishDateInBangla(DateTime date) {
    String day = convertToBanglaNumber(date.day);
    String month = englishMonthsBangla[date.month - 1];
    String year = convertToBanglaNumber(date.year);
    return '$day $month $year';
  }

  static String getBanglaDate(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;

    // Convert to Bangla Year
    if (month > 3 || (month == 3 && day >= 14)) {
      year -= 593;
    } else {
      year -= 594;
    }

    int banglaMonthIndex = 0;
    int banglaDay = day;

    // Find the correct Bangla month
    for (int i = 1; i <= 12; i++) {
      int startDay = banglaMonthStartDays[i]!;
      if ((month == i + 3 && day >= startDay) || (month == i + 4 && day < banglaMonthStartDays[i + 1]!)) {
        banglaMonthIndex = i - 1;
        banglaDay = day - startDay + 1;
        break;
      }
    }

    return '${convertToBanglaNumber(banglaDay)} ${banglaMonths[banglaMonthIndex]} ${convertToBanglaNumber(year)}';
  }

  static String getHijriDate(DateTime date) {
    HijriCalendar todayHijri = HijriCalendar.fromDate(date);
    String day = convertToBanglaNumber(todayHijri.hDay);
    String month = hijriMonthsBangla[todayHijri.hMonth - 1];
    String year = convertToBanglaNumber(todayHijri.hYear);
    return '$day $month $year';
  }
}
