import 'package:intl/intl.dart';

class RentalUtils {
  static formatRupiah(String val){
    final NumberFormat nf = new NumberFormat('#,##0', 'id_ID');
                        
    return "Rp. "+ nf.format(int.parse(val)).replaceAll(",", ".").toString();
  }
  static bool isNumeric(String str){
    str.allMatches("-?\\d+(\\.\\d+)?");
    // return str.matches("-?\\d+(\\.\\d+)?");
  }
}