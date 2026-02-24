using AdminService as service from '../../srv/admin-service';
annotate service.Category with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'categoryName',
                Value : categoryName,
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
            Label : 'Items',
            ID : 'Items',
            Target : 'items/@UI.LineItem#Items1',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'categoryName',
            Value : categoryName,
        },
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
    ],
    UI.FieldGroup #Items : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : categoryName,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : ID,
        },
    },
    UI.FieldGroup #Items1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
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
);

annotate service.Items with @(
    UI.LineItem #Items : [
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
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'GeneralInformation',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
    ],
    UI.FieldGroup #Itemsobject : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
    },
    UI.LineItem #PurchaseItems : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : totStocks,
            Label : 'totStocks',
        },
        {
            $Type : 'UI.DataField',
            Value : itemName,
            Label : 'itemName',
        },
    ],
    UI.LineItem #Items1 : [
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
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
    },
);

