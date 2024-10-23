

extension DayName on int {


  String getDayName(){

    switch(this){

      case 1 : return 'شنبه';
      case 2 : return 'یکشنبه';
      case 3 : return 'دوشنبه';
      case 4 : return 'سه شنبه';
      case 5 : return 'چهار شنبه';
      case 6 : return 'پنج شنبه';
      case 7 : return 'جمعه';
    }

    return 'ندارد';

  }


}