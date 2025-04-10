using { soa.db.master, soa.db.trasaction } from '../db/data-model';
using { soa.cds } from '../db/CDSView';
 
// You have to enforce authorization at the end point level
 
service CatalogService@(path: 'CatalogService', requires: 'authenticated-user'){
    // Normal Function
    function getHighestOrder() returns POService ;
    function utilsUUID() returns String ;
    function utilsDecode() returns String ;
 
    function readConvervetFile() returns String ;
    function fileExist() returns String ;
    function getLowestOrder() returns POService ;
    entity BPService as projection on master.Businesspartner;
   
    @readonly
    entity AddressS as projection on master.address;
 
    @Capabilities : {Updatable : false, Deletable : false}
    entity EmployeeS as projection on master.employees;
    entity ProdcutsS as projection on master.product;
    entity POService @(odata.draft.enabled: true) as projection on trasaction.purchaseorder{
        *,
        case lifecycle_status
        when 'N' then 'Not Expired'
        when 'E' then 'Expired'
        when 'I' then 'Not Applicable'
        end as LifeCycleStatus: String(10),
        case overall_status
        when 'P' then 'Pending'
        when 'N' then 'New'
        when 'A' then 'Approved'
        when 'X' then 'Rejected'
        end as OverallStatus : String(10),
        case overall_status
        when 'P' then 2
        when 'N' then 2
        when 'A' then 3
        when 'X' then 1
        end as Criticality : Integer
    }
    actions{
        // Instance Bound Action - Definition
        @Common.SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties : [
                'in/gross_amount'
            ]
        }
        action increasedPrice() returns String(100);
        action increasedTax() returns String(100);
    };
    entity POItemS as projection on trasaction.poitems;
    //  action hello(name: String(10)) returns String(100);
 
    // Normal Action
    action helloCap(name : String(100)) returns String(100);
    action userLogin(username: String(32), pwd : String(32)) returns String(100);
 
}
 
 
 
// Apart form Action & Functions is thre any otehr way to perform any operation
// api.sap.com --> Example --> Import and conusme service --> Remote Service()