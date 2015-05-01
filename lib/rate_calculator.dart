library rate_calculator;

import 'dart:html';

InputElement get _lastSalesPrice => querySelector('#lastSalesPrice');
DateInputElement get _lastSalesDate => querySelector('#lastSalesDate');
Element get _estimatedValue => querySelector('#estimatedValue');
var InflationRates = [
  1.0, 1.0, 7.9, 17.4, 18, 14.6, // 1914
  15.6, -10.5, -6.1, 1.8, 0, 2.3, 1.1, -1.7, -1.7, 0          // 1920
  -2.3, -9, -9.9, -5.1, 3.1, 2.2, 1.5, 3.6, -2.1, -1.4,       // 1930
  0.7, 5, 10.9, 6.1, 1.7, 2.3, 8.3, 14.4, 8.1, -1.2,          // 1940
  1.3, 7.9, 1.9, 0.8, 0.7, -0.4, 1.5, 3.3, 2.8, 0.7,          // 1950
  1.7, 1.0, 1.0, 1.3, 1.3, 1.6, 2.9, 3.1, 4.2, 5.5,           // 1960
  5.7, 4.4, 3.2, 6.2, 11.0, 9.1, 5.8, 6.5, 7.6, 11.3,         // 1970
  13.5, 10.3, 6.2, 3.2, 4.3, 3.6, 1.9, 3.6, 4.1, 4.8,         // 1980
  5.4, 4.2, 3.0, 3.0, 2.6, 2.8, 3.0, 2.3, 1.6, 2.2,           // 1990
  3.4, 2.8, 1.6, 2.3, 2.7, 3.4, 3.2, 2.8, 3.8, -0.4,          // 2000
  1.6, 3.2, 2.1, 1.5, 1.6, -0.1
  ];
const FIRST_YEAR = 1914;
const LAST_YEAR = 2015;


initCalculator() {
  var workDate = new DateTime.now();
  workDate = workDate.subtract(new Duration(days: 10 * 365));
  _lastSalesDate.valueAsDate = workDate;
  _calculate();
  
  _lastSalesPrice.onKeyUp.listen((_) => _calculate());
  _lastSalesDate.onChange.listen((_) => _calculate());
}

_calculate() {
  try {
    var lastSalesPrice = double.parse(_lastSalesPrice.value);
    var currentPrice = lastSalesPrice;
    var currentDate = new DateTime.now();
    if (_lastSalesDate.valueAsDate.year < FIRST_YEAR || _lastSalesDate.valueAsDate.year > LAST_YEAR) {
      return;
    }
    for (var year = _lastSalesDate.valueAsDate.year; year <= currentDate.year && year < LAST_YEAR; year++) {
      currentPrice += currentPrice * (InflationRates[year - FIRST_YEAR] / 100);
    }
    _estimatedValue.text = currentPrice.toStringAsFixed(0);
  } catch (FormatException) {}
}
