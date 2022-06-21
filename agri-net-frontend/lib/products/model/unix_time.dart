import "../../libs.dart";
class UnixTime{


  final int unix;
  UnixTime(this.unix);
  DateTime? time;

  int minutes=0;
  int seconds=0;
  int hours=0;
  int days=0;

  void minutesFromNow(){
    seconds = (DateTime.now().millisecondsSinceEpoch/1000).floor()- unix; 
    days = (seconds/86400).floor();
    seconds = seconds- (days * 86400);
    hours = (seconds/3600).floor();
    seconds = seconds - (hours*3600);
    minutes = (seconds/60).floor();
    seconds = seconds - (minutes * 60);
  }


  String toString(){
    minutesFromNow();
    String string="";
    if (days>0){
      string += " $days ${translate(lang, "days")}";
      return string;
    }
    if (hours>0){
      string += " $hours ${translate(lang, "hours")}";
    }
    if (minutes>0){
      string += " $minutes ${translate(lang, "minutes")}";
      if (hours > 0) {
        return string;
      }
    }
    if (seconds>0){
      string += " $seconds ${translate(lang, "seconds")}";
    }
    return string;
  }
}