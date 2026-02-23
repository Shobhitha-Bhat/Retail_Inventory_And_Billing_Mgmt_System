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
    ],
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
        Text : 'Customers',
    },
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
        TypeImageUrl : 'sap-icon://person-placeholder',
    },
);

annotate service.Items with @(
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : itemName,
            Label : 'itemName',
        },
        {
            $Type : 'UI.DataField',
            Value : totStocks,
            Label : 'totStocks',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
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
        Text : 'Items',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : itemName,
                Label : 'itemName',
            },
            {
                $Type : 'UI.DataField',
                Value : totStocks,
                Label : 'totStocks',
            },
        ],
    },
);

annotate service.Category with @(
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : categoryName,
            Label : 'categoryName',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
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
        Text : 'Categories',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'AvailableCategories',
            Target : '@UI.FieldGroup#AvailableCategories',
        },
    ],
    UI.FieldGroup #AvailableCategories : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : categoryName,
                Label : 'categoryName',
            },
            {
                $Type : 'UI.DataField',
                Value : items.itemName,
                Label : 'itemName',
            },
            {
                $Type : 'UI.DataField',
                Value : items.totStocks,
                Label : 'totStocks',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : categoryName,
        },
        TypeName : '',
        TypeNamePlural : '',
        TypeImageUrl : 'sap-icon://product',
    },
);

annotate service.Purchases with @(
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'purchase ID',
        },
        {
            $Type : 'UI.DataField',
            Value : customer_ID,
            Label : 'customer_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : createdAt,
                    Descending : true,
                },
            ],
            GroupBy : [
                customer_ID,
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Purchases',
    },
);

annotate service.Customers with {
    name @Common.FieldControl : #Mandatory
};

annotate service.Category with {
    categoryName @Common.FieldControl : #Mandatory
};

