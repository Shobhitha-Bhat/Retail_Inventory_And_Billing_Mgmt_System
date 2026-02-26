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
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
            // {
            //     $Type : 'UI.DataFieldForAction',
            //     Action : 'AdminService.purchasenewItems',
            //     Label : 'purchasenewItems',
            // },
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
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#totalOrders1',
            Label : 'totalOrders',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@Communication.Contact#contact',
            Label : 'Contact Name',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#totalOrders',
            Label : 'totalOrders',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#totalOrders1',
            Label : 'totalOrders',
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
    UI.Identification : [
        
    ],
    UI.DataPoint #totalOrders : {
        Value : totalOrders,
        Visualization : #Progress,
        TargetValue : 100,
    },
    UI.DataPoint #totalOrders1 : {
        Value : totalOrders,
        Visualization : #Progress,
        TargetValue : 100,
    },
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : city,
        title : createdBy,
        role : modifiedBy,
        org : modifiedBy,
        tel : [
            {
                $Type : 'Communication.PhoneNumberType',
                type : #cell,
                uri : city,
            },
        ],
        email : [
            {
                $Type : 'Communication.EmailAddressType',
                type : #work,
                address : name,
            },
        ],
        adr : [
            {
                $Type : 'Communication.AddressType',
                type : #work,
                street : createdBy,
                locality : city,
                region : modifiedBy,
                code : name,
                country : createdBy,
            },
        ],
        
    },
    UI.DataPoint #totalOrders2 : {
        Value : totalOrders,
        MinimumValue : 0,
        MaximumValue : 100,
    },
    UI.Chart #totalOrders : {
        ChartType : #Bullet,
        Measures : [
            totalOrders,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#totalOrders2',
                Role : #Axis1,
                Measure : totalOrders,
            },
        ],
    },
    UI.DataPoint #totalOrders3 : {
        Value : totalOrders,
        TargetValue : totalOrders,
    },
    UI.Chart #totalOrders1 : {
        ChartType : #Donut,
        Measures : [
            totalOrders,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#totalOrders3',
                Role : #Axis1,
                Measure : totalOrders,
            },
        ],
    },
    UI.DataPoint #totalOrders4 : {
        Value : totalOrders,
        MaximumValue : totalOrders,
    },
    UI.Chart #totalOrders2 : {
        ChartType : #Pie,
        Measures : [
            totalOrders,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#totalOrders4',
                Role : #Axis1,
                Measure : totalOrders,
            },
        ],
    },
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    },
    UI.DataPoint #progress : {
        $Type : 'UI.DataPointType',
        Value : totalOrders,
        Title : 'totalOrders',
        TargetValue : 100,
        Visualization : #Progress,
    },
    UI.HeaderFacets : [
        
    ],
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
    UI.LineItem #AddNewPurchase : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.EntityContainer/purchasenewItems',
            Label : 'purchasenewItems',
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
            Action : 'AdminService.returnItemsFromPaidPurchase',
            Label : 'returnItemsFromPaidPurchase',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'quantity',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.removeItemsFromShopping',
            Label : 'removeItemsFromShopping',
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
annotate service.Items with {
    category @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Category',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : category_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Category with {
    ID @Common.Text : categoryName
};



//for valuehelp purchaseitem dropdown
// Updated path to reach INSIDE the "many" structure
// annotate service.purchasenewItems.purchaseItems with {
//     category_ID @(
//         Common.Label : 'Category',
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Category',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : category_ID,
//                     ValueListProperty : 'ID',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'categoryName',
//                 }
//             ],
//         }
//     );

//     item_ID @(
//         Common.Label : 'Item',
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Items',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterIn',
//                     LocalDataProperty : category_ID,
//                     ValueListProperty : 'category_ID',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : item_ID,
//                     ValueListProperty : 'ID',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'itemName',
//                 }
//             ],
//         }
//     );
// };