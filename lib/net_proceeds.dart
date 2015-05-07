library net_proceeds;

import 'dart:html';

InputElement get _salesPrice => querySelector('#salesPrice');
InputElement get _firstDeed => querySelector('#firstDeed');
InputElement get _secondDeed => querySelector('#secondDeed');
InputElement get _otherDeed => querySelector('#otherDeed');
Element get _grossEquity => querySelector('#grossEquity');
InputElement get _listingBrokerageFeePct => querySelector('#listingBrokerageFeePct');
Element get _listingBrokerageFee => querySelector('#listingBrokerageFee');
InputElement get _sellingBrokerageFeePct => querySelector('#sellingBrokerageFeePct');
Element get _sellingBrokerageFee => querySelector('#sellingBrokerageFee');

InputElement get _prepaymentPenalty => querySelector('#prepaymentPenalty');
InputElement get _unpaidLoanBalanceInterest => querySelector('#unpaidLoanBalanceInterest');
InputElement get _lienReleaseFee => querySelector('#lienReleaseFee');
Element get _grantorsTax => querySelector('#grantorsTax');
InputElement get _unpaidAssessmentsTaxes => querySelector('#unpaidAssessmentsTaxes');
InputElement get _wellSepticInspection => querySelector('#wellSepticInspection');
InputElement get _termiteInspection => querySelector('#termiteInspection');
InputElement get _inspectionIssues => querySelector('#inspectionIssues');
InputElement get _purchaserClosingCosts => querySelector('#purchaserClosingCosts');
InputElement get _homeWarranty => querySelector('#homeWarranty');
InputElement get _miscellaneous => querySelector('#miscellaneous');
InputElement get _titleService => querySelector('#titleService');
InputElement get _hoaDocuments => querySelector('#hoaDocuments');
InputElement get _attorneyFees => querySelector('#attorneyFees');
Element get _creditsDueAtClosing => querySelector('#creditsDueAtClosing');

Element get _totalEstimatedProceeds => querySelector('#totalEstimatedProceeds');

initNetProceeds() {
  _listingBrokerageFeePct.value = '3.0';
  _sellingBrokerageFeePct.value = '3.0';
  _calculateNetProceeds();

  final inputElements = querySelectorAll('#netproceeds input[type=text]');

  // iterate over the checkboxes
  inputElements.forEach((input) {
    input.onKeyUp.listen((_) => _calculateNetProceeds());
    input.onChange.listen((_) => _calculateNetProceeds());
  });
  
}

_calculateNetProceeds() {
  try {
    
    var salesPrice = getDoubleValue(_salesPrice);
    var firstDeed = getDoubleValue(_firstDeed);
    var secondDeed = getDoubleValue(_secondDeed);
    var otherDeed = getDoubleValue(_otherDeed);
    var grossEquity = salesPrice - (firstDeed + secondDeed + otherDeed);
    _grossEquity.text = grossEquity.toStringAsFixed(0);
    var listingBrokerageFeePct = getPctValue(_listingBrokerageFeePct);
    var listingBrokerageFee = listingBrokerageFeePct * salesPrice;
    _listingBrokerageFee.text = listingBrokerageFee.toStringAsFixed(0);
    var sellingBrokerageFeePct = getPctValue(_sellingBrokerageFeePct);
    var sellingBrokerageFee = sellingBrokerageFeePct * salesPrice;
    _sellingBrokerageFee.text = sellingBrokerageFee.toStringAsFixed(0);

    var prepaymentPenalty = getDoubleValue(_prepaymentPenalty);
    var unpaidLoanBalanceInterest = getDoubleValue(_unpaidLoanBalanceInterest);
    var lienReleaseFee = getDoubleValue(_lienReleaseFee);
    var grantorsTax = salesPrice / 1000;
    _grantorsTax.text = grantorsTax.toStringAsFixed(0);
    var unpaidAssessmentsTaxes = getDoubleValue(_unpaidAssessmentsTaxes);
    var wellSepticInspection = getDoubleValue(_wellSepticInspection);
    var termiteInspection = getDoubleValue(_termiteInspection);
    var inspectionIssues = getDoubleValue(_inspectionIssues);
    var purchaserClosingCosts = getDoubleValue(_purchaserClosingCosts);
    var homeWarranty = getDoubleValue(_homeWarranty);
    var miscellaneous = getDoubleValue(_miscellaneous);
    var titleService = getDoubleValue(_titleService);
    var hoaDocuments = getDoubleValue(_hoaDocuments);
    var attorneyFees = getDoubleValue(_attorneyFees);
     
    var creditsDueAtClosing = listingBrokerageFee + sellingBrokerageFee
     + prepaymentPenalty + unpaidLoanBalanceInterest + lienReleaseFee
     + grantorsTax + unpaidAssessmentsTaxes + wellSepticInspection
     + termiteInspection + inspectionIssues + purchaserClosingCosts
     + homeWarranty + miscellaneous + titleService + hoaDocuments + attorneyFees;
    _creditsDueAtClosing.text = creditsDueAtClosing.toStringAsFixed(0);
        
    var totalEstimatedProceeds = grossEquity - creditsDueAtClosing;
    _totalEstimatedProceeds.text = totalEstimatedProceeds.toStringAsFixed(0);
        
  } catch (FormatException) {
    
  }
  
  
}

double getPctValue(InputElement element) {
  var v = getDoubleValue(element);
  if (v >= 1.0) {
    v = v / 100;
  }
  return v;
}

double getDoubleValue(InputElement element) {
  var v = 0.0;
  try {
    v = double.parse(element.value);  
  } catch (FormatException) { 
  }
  return v;
}