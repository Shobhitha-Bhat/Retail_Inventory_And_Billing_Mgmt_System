using AdminService as service from '../../srv/admin-service';
annotate service.Customers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'city',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalOrders',
                Value : totalOrders,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchases',
            ID : 'Purchases',
            Target : 'purchases/@UI.LineItem#Purchases',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'city',
            Value : city,
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalOrders',
            Value : totalOrders,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.EntityContainer/purchasenewItems',
            Label : 'purchasenewItems',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : city,
        },
        TypeImageUrl : 'sap-icon://customer',
    },
);

annotate service.Purchases with @(
    UI.LineItem #Purchases : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'purchaseID',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.payForPurchase',
            Label : 'payForPurchase',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.returnEntirePurchase',
            Label : 'returnEntirePurchase',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Items',
            ID : 'PurchaseItems',
            Target : 'purchaseItems/@UI.LineItem#PurchaseItems',
        },
    ],
);

annotate service.PurchaseItems with @(
    UI.LineItem #PurchaseItems : [
        {
            $Type : 'UI.DataField',
            Value : item_ID,
            Label : 'item_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : item.itemName,
            Label : 'itemName',
        },
        {
            $Type : 'UI.DataField',
            Value : itemStatus,
            Label : 'itemStatus',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.removeItemsFromShopping',
            Label : 'removeItemsFromShopping',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.returnItemsFromPaidPurchase',
            Label : 'returnItemsFromPaidPurchase',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'quantity',
        },
    ]
);

// annotate AdminService.removeItemsFromShopping with @Common.SideEffects: {
//     TargetEntities: [
//         '../PurchaseItems' // Refreshes the items table
//     ]
    
// };
// annotate AdminService.PurchaseItems.removeItemsFromShopping with @Common.SideEffects: {
//     TargetEntities: [
//         '../purchaseItems' // Use the navigation property name from the Parent (Purchases)
//     ]
// };

// Note the "/" instead of "."
annotate AdminService.PurchaseItems.removeItemsFromShopping with @Common.SideEffects: {
    TargetEntities: [
        '../',           // Refreshes the Purchase (parent)
        '../purchaseItems' // Explicitly refreshes the sibling collection
    ],
    TargetProperties: [
        '../status'      // Refresh specific properties if needed
    ]
};