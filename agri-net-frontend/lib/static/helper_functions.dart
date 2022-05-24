  bool isValidDateString(String date) {
    List<String> vals = date.split("-");
    if (vals.length != 3) {
      vals = date.split("/");
      if (vals.length != 3) {
        vals = date.split(".");
        if (vals.length != 3) {
          vals = date.split(",");
          if (vals.length != 3) {
            return false;
          }
        }
      }
    }
    try {
      if ((int.parse(vals[0]) < 30) &&
          (int.parse(vals[0]) > 0) &&
          (int.parse(vals[1]) <= 13) &&
          (int.parse(vals[1]) > 0) &&
          (int.parse(vals[2]) > 1991) &&
          (int.parse(vals[2])) < 3000) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }