final dictionary = {
  "register": {
    "amh": "ተመዝገብ",
    "oro": "temezgeb",
    "tig": "temezgeb",
  },
  "confirm": {
    "amh": "አረጋግጥ",
    "oro": "aregagt",
    "tig": "aregagt",
  },
  "days": {
    "amh": "ቀናት",
    "oro": "kennatt",
    "tig": "kinatt",
  },
  "before": {
    "amh": "በፊት",
    "oro": "befit",
    "tig": "befit",
  },
  ".": {
    "amh": "ከ",
    "oro": "ke",
    "tig": "kee",
  },
  "price": {
    "amh": "ዋጋ",
    "oro": "meeqqa",
    "tig": "ዋጋ",
  },
  "registered agents": {
    "amh": "የተመዘገቡ ወኪሎች",
    "oro": "yetemezegebu wekiloch",
    "tig": "yetemezegebu wekiloch",
  },
  "Phone": {
    "amh": "ስልክ",
    "oro": "billbila",
    "tig": "slk",
  },
  "don't recieve the code": {
    "amh": "የሚስጥር ቁጥሩ አልደረሰኝም",
    "oro": "yemistr kutru alderesegnm",
    "tig": "yemistr kutru alderesegnm",
  },
  "job title": {
    "amh": "የስራ መደቡ መጠሪያ",
    "oro": "yesra medebu meteriya",
    "tig": "yesra medebu meteriyaa",
  },
  "farmer": {
    "amh": "ገበሬ",
    "oro": "gebere",
    "tig": "geberee",
  },
  "merchant": {
    "amh": "ነጋዴ",
    "oro": "negade",
    "tig": "negadee",
  },
  "consumer": {
    "amh": "ሸማች",
    "oro": "shemach",
    "tig": "shemachh",
  },
  "all": {
    "amh": "ሁሉም",
    "oro": "hulum",
    "tig": "hulumm",
  },
  "langauge": {
    "amh": "ቋንቋ",
    "oro": "qwanqwa",
    "tig": "qwanqwaa",
  },
  "please enter your full name": {
    "amh": "ሙሉ ስምህን አስገባ",
    "oro": "mulu smhn asgeba",
    "tig": "mulu smhn asgebaa",
  },
  "please enter your phone number": {
    "amh": "ስልክ ቁጥርህን አስገባ",
    "oro": "slk kutrhn asgeba",
    "tig": "slk kutrhn asgebaa",
  },
  "please select a role": {
    "amh": "ሚና ይምረጡ",
    "oro": "mina yimretu",
    "tig": "mina yimretuu",
  },
  "confirmation": {
    "amh": "ማረጋገጫ",
    "oro": "maregagecha",
    "tig": "maregagechaa",
  },
  "login": {
    "amh": "ግባ",
    "oro": "gba",
    "tig": "gbaa",
  },
  "registration": {
    "amh": "ምዝገባ",
    "oro": "mzgeba",
    "tig": "mzgebaa",
  },
  "subscription": {
    "amh": "የደንበኝነት ምዝገባ",
    "oro": "yedenbgna mzgeba",
    "tig": "yedenbegna mzgebaa",
  },
  "settings": {
    "amh": "ቅንብሮች",
    "oro": "qnbroch",
    "tig": "qnbrochh",
  },
  "logout": {
    "amh": "ውጣ",
    "oro": "wta",
    "tig": "wtaa",
  },
  "no product available": {
    "amh": "ምንም ምርት አይገኝም",
    "oro": "mnm mrt ayigegnm",
    "tig": "mnm mrt ayigenmm",
  },
  "unsubscribe" : {
    "amh" : "አለመመዝገብ",
    "tig"  : "አለመመዝገብ",
    "oro"  : "unsubscribee"
  },
  "subscribe" : {
    "amh" : "ተመዝገብ",
    "tig"  : "ተመዝገብ",
    "oro"  : "አለመመዝገብ"
  },
};

String lang = "amh";

String translate(String lang, String sentence) {
  final str = sentence.trim().toLowerCase();
  String str2 = sentence;
  switch (lang.toLowerCase()) {
    case "en":
    case "eng":
      {
        return sentence;
      }
    case "amh":
    case "am":
    case "amharic":
    case "amhara":
      {
        final val = dictionary[str];
        str2 = (val != null) ? (val["amh"] ?? '') : str2;
        break;
      }
    case "oro":
    case "or":
    case "oromifa":
    case "oromo":
      {
        final val = dictionary[str];
        print(val);
        str2 = (val != null) ? (val["oro"] ?? '') : str2;
        break;
      }
    case "tigr":
    case "tig":
    case "tigray":
    case "tigrigna":
      {
        final val = dictionary[str];
        str2 = (val != null) ? (val["tig"] ?? '') : str2;
        break;
      }
  }
  if (str2 == "") {
    return sentence;
  }
  return str2;
}
