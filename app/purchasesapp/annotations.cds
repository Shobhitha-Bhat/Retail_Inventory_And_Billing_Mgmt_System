using AdminService as service from '../../srv/admin-service';
annotate service.Purchases with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'purchaseID',
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : customer_ID,
            Label : 'customer_ID',
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
    ]
);

annotate service.Purchases with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'city',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'totalOrders',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.PurchaseItems with {
    item @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Items',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : item_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'itemName',
                    LocalDataProperty : item.category.categoryName,
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Items with {
    ID @Common.Text : itemName
};

annotate service.PurchaseItems with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PurchaseItems',
            ID : 'newsection',
            Target : '@UI.FieldGroup#newsection',
        },
    ],
    UI.FieldGroup #newsection : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : quantity,
                Label : 'quantity',
            },
            {
                $Type : 'UI.DataField',
                Value : item_ID,
                Label : 'item_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : itemStatus,
                Label : 'itemStatus',
            },
            {
                $Type : 'UI.DataField',
                Value : purchase_ID,
                Label : 'purchase_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : purchase.customer_ID,
                Label : 'customer_ID',
            },
        ],
    },
);

annotate service.Customers with {
    ID @Common.Text : name
};

