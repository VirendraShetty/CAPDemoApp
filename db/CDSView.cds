namespace soa.cds;

using { soa.db.master, soa.db.trasaction } from './data-model';

context CDSViews {
    define view![POWorklist] as
        select from trasaction.purchaseorder{
            key po_id as![PurchaseOrderId],
            key Items.po_item_pos as ![ItemPosition],
            partner_guid.bp_id as![PartnerId],
            partner_guid.company_name as![CompanyName],
            gross_amount as![GrossAmount],
            net_amount as![NetAmount],
            tax_amnout as![TaxAmount],
            currency as![CurrencyCode],
            overall_status as![Status],
            Items.proudct_guid.product_id as![ProductId],
            Items.proudct_guid.description as![ProductName],
            partner_guid.address_guid.city as![City],
            partner_guid.address_guid.country as![Country],
        };


    define view![ProductValueHelp] as
    select from master.product{
        @EndUserText.label:[
            {
                language: 'EN',
                text: 'Product id'
            },
            {
                language: 'DE',
                text: 'Prodekt id'
            }
        ]
        product_id as![ProductId],
        @EndUserText.label:[
            {
                language: 'EN',
                text: 'Product Description'
            },
            {
                language: 'DE',
                text: 'Prodekt Description'
            }
        ]
        description as![Description]
    };


    define view![ItemView] as
    select from trasaction.poitems{
        parent_key.partner_guid.node_key as![CustomerId],
        proudct_guid.node_key as![ProductId],
        currency as![CurrencyCode],
        gross_amount as![GrossAmount],
        net_amount as![NetAmount],
        tax_amnout as![TaxAmount],
        parent_key.overall_status as![Status]
    };

    define view ProductView as select from master.product
    // Mixin is a keyword to define lose coupling
    //which will never load items data for product rather load on demand
    mixin{
        //View on view
        po_order: Association[*] to ItemView on po_order.ProductId = $projection.ProductId
    } into {
        node_key as![ProductId],
        description as![Description],
        category as![Category],
        price as![Price],
        supplier_guid.bp_id as![SupplierId],
        supplier_guid.company_name as![SupplierName],
        supplier_guid.address_guid.city as![City],
        supplier_guid.address_guid.country as![Country],
        //exposed association, at runtime in odata we will see a link to load
        //dependent data
        po_order as![To_Items]
    };

    define view CProductValuesView as
        select from ProductView{
            ProductId,
            Country,
            round(sum(To_Items.GrossAmount),2) as![TotalPurchaseAmount] : Decimal(10,2),
            To_Items.CurrencyCode as![CurrencyCode]
        } group by ProductId, Country, To_Items.CurrencyCode;
}
 