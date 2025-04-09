namespace soa.db;
 
using { cuid, Currency } from '@sap/cds/common';
 
 
using { soa.Spriderman } from './reuse';
 
 
context master {
    entity Businesspartner {
        key node_key : Spriderman.Guid @(title : '{i18n>partner_key}');
        bp_role : String(2);
        email_address : String(105);
        phone_number : String(32);
        fax_number : String(32);
        web_address : String(44);
        bp_id : String(32)  @(title : '{i18n>partner_id}');
        company_name : String(250) @(title : '{i18n>company_name}') ;
        address_guid : Association to address;
    }
    entity address {
        key node_key : Spriderman.Guid;
        city : String(44);
        postal_code : String(10);
        street : String(44);
        building: String(128);
        country: String(44) @(title : '{i18n>country}');
        address_type : String(44);
        val_start_date : Date ;
        val_end_date : Date;
        latitude : Decimal;
        longitude : Decimal;
        businesspartner : Association to one Businesspartner on businesspartner.address_guid = $self;
    }
 
    entity product  {
        key node_key : Spriderman.Guid  @(title : '{i18n>product_key}');
        product_id : String(28) @(title : '{i18n>product_id}');
        type_code : String(2);
        category : String(32);
        description : String(255);
        supplier_guid : Association to master.Businesspartner;
        tax_tarif_code : Integer;
        measure_unit : String(2);
        weight_measure : Decimal(5,2);
        weight_unit : String(2);
        currency_code : String(4);
        price : Decimal(15,2);
        width : Decimal(15,2);
        height: Decimal(5,2);
        dim_unit : String(2);
    }
 
    entity employees: cuid {
        nameFirst : String(40);
        nameMiddle : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        sex : Spriderman.Gender ;
        language : String(1);
        phoneNumber : Spriderman.phoneNumber;
        email : Spriderman.Email;
        loginName : String(12);
        Currency : Currency;
        salaryAmount : Spriderman.AmountT;
        accountNumber : String(16);
        bankId : String(15);
        bankName : String(64);
    }
}
 
context trasaction {
    entity purchaseorder: Spriderman.Amount {
        key node_key : Spriderman.Guid  @(title : '{i18n>po_node_key}');
        po_id : String(40) @(title : '{i18n>po_id}');
        partner_guid : Association to master.Businesspartner;
        lifecycle_status : String(1);
        overall_status : String(1) @(title : '{i18n>overall_status}');
        Items: Composition of many poitems on Items.parent_key = $self;
    }
 
    entity poitems : Spriderman.Amount{
        key node_key : Spriderman.Guid @(title : '{i18n>po_item_key}') ;
        parent_key : Association to purchaseorder;
        po_item_pos : Int16  @(title : '{i18n>po_item_no}');
        proudct_guid : Association to master.product ;
    }
}