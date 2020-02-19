import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(var selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      var response = await http.get(
          'https://bravenewcoin-v1.p.rapidapi.com/convert?qty=1&from=$crypto&to=$selectedCurrency',
          headers: {
            'x-rapidapi-host': 'bravenewcoin-v1.p.rapidapi.com',
            'x-rapidapi-key':
                '85970f2aa5msh9fbc1d907cdd7b0p15bb9cjsn2cf503220653',
          });

      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        var rate = data['to_quantity'];
        cryptoPrices[crypto] = rate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problum with the get request';
      }
    }
    return cryptoPrices;
  }
}
