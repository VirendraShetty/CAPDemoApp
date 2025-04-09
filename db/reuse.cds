namespace soa.Spriderman;
 
using { Currency } from '@sap/cds/common';
 
// Enum
type Gender : String(1) enum {
    male = 'M' ;
    female = 'F';
    undisclosed = 'U';
}
 
type AmountT : Decimal(10,2)@(
    Semantics.amount.currencycode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);
 
// Aspect
aspect Amount{
    currency : Currency;
    gross_amount : AmountT @(title:'{i18n>gross_amount}');
    net_amount : AmountT;
    tax_amnout : AmountT ;
}
 
type Guid : String(32);
 
type phoneNumber : String(30) ;
 
type Email : String(255);