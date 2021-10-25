import 'package:example/helper/env_constants.dart';
import 'package:ipaycheckout/ipaycheckout.dart';
import 'dart:math';

class HttpHelper {
  Future<String> generateUrl(
      String phoneNumber, String email, String amount) async {
    final ipay = IPay(vendorId: vendorId, vendorSecurityKey: securityKey);
    var oid = getRandomString(10);
    var inv = oid;
    var url = ipay.checkoutUrl(
        live: live,
        oid: oid,
        inv: inv,
        ttl: amount,
        tel: phoneNumber,
        eml: email,
        curr: currency,
        cbk: callBackUrl,
        cst: cst,
        crl: crl,
        mpesa: mpesa,
        bonga: bonga,
        airtel: airtel,
        equity: equity,
        mobilebanking: mobilebanking,
        creditcard: creditcard,
        mkoporahisi: mkoporahisi,
        saida: saida,
        elipa: elipa,
        unionpay: unionpay,
        mvisa: mvisa,
        vooma: vooma,
        pesalink: pesalink,
        autopay: autopay);

    return url;
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    var newOid = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return newOid;
  }
}
