using CatalogService as service from '../../srv/CatalogService';
 
annotate service.POService with @(
 
    // Add Fields for selecting the data
    UI.SelectionFields:[
        po_id,
        partner_guid.company_name,
        partner_guid.address_guid.city,
        partner_guid.address_guid.country,
        gross_amount,
        overall_status
    ],
 
    // To add columns to your tables
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : po_id
        },
        {
            $Type : 'UI.DataField',
            Value : partner_guid.company_name
        },
        {
            $Type : 'UI.DataField',
            Value : partner_guid.address_guid.country
        },
        {
            $Type : 'UI.DataField',
            Value : gross_amount
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.increasedPrice',
            Label : 'Price Hike',
            Inline : true,
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : Criticality
        }
    ],
 
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : po_id,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : partner_guid.company_name
        },
        ImageUrl : 'https://1000logos.net/wp-content/uploads/2017/06/Vodafone_Logo.png'
    },
 
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.Identification',
                    Label : 'Purchase Order Details',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#PricingFieldGroup',
                    Label : 'Pricing Details',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#StatusFieldGroup',
                    Label : 'Status Details',
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Items',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : po_id
        },
        {
            $Type : 'UI.DataField',
            Value : partner_guid_node_key
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus
        }
    ],
    UI.FieldGroup #PricingFieldGroup : {
        Label : 'Pricing Details',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : gross_amount
            },
            {
                $Type : 'UI.DataField',
                Value : net_amount
            },
            {
                $Type : 'UI.DataField',
                Value : tax_amnout
            }
        ]
    },
    UI.FieldGroup #StatusFieldGroup : {
        Label : 'Pricing Details',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : OverallStatus
            },
            {
                $Type : 'UI.DataField',
                Value : LifeCycleStatus
            }
        ]
    }
 
);
 
annotate service.POItemS with @(
    UI.HeaderInfo : {
        TypeName : 'PO Item',
        TypeNamePlural : 'PO Items',
        Title : {
            $Type : 'UI.DataField',
            Value : po_item_pos,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : proudct_guid.description
        }
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'More',
            Target : '@UI.Identification'
        }
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : po_item_pos,
        },
        {
            $Type : 'UI.DataField',
            Value : proudct_guid_node_key,
        },
        {
            $Type : 'UI.DataField',
            Value : gross_amount,
        },
        {
            $Type : 'UI.DataField',
            Value : net_amount,
        },
        {
            $Type : 'UI.DataField',
            Value : tax_amnout,
        }
    ],
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : po_item_pos,
        },
        {
            $Type : 'UI.DataField',
            Value : proudct_guid.description,
        },
        {
            $Type : 'UI.DataField',
            Value : gross_amount,
        },
        {
            $Type : 'UI.DataField',
            Value : tax_amnout,
        },
        {
            $Type : 'UI.DataField',
            Value : net_amount,
        }
    ]
);
 
 
annotate CatalogService.POService with {
    partner_guid@(
        Common : {
            Text : partner_guid.company_name
        },
        ValueList.entity : CatalogService.BPService
    )
}
 
annotate CatalogService.POItemS with {
    proudct_guid@(
        Common : {
            Text : proudct_guid.description
        },
        ValueList.entity : CatalogService.ProdcutsS
    )
}
 
 
@cds.odata.valuelist
annotate CatalogService.BPService with @(
    UI.Identification : [{
        $Type : 'UI.DataField',
        Value : company_name
    }]
);
 
@cds.odata.valuelist
annotate CatalogService.ProdcutsS with @(
    UI.Identification : [{
        $Type : 'UI.DataField',
        Value : description
    }]
);