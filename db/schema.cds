namespace my.retailshop;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Customers : cuid, managed {
    name        : String;
    city        : String;
    totalOrders : Integer default 0;
    purchases   : Association to many Purchases
                      on purchases.customer = $self; //for reverse navigation
}

entity Categories : cuid, managed {
    categoryName : String;
    items        : Composition of many Items
                       on items.category = $self;
}

entity Items : cuid, managed {
    itemName  : String;
    category  : Association to Categories;
    totStocks : Integer default 0;
}

entity Purchases : cuid, managed {
    customer      : Association to Customers;
    purchaseItems : Composition of many PurchaseItems
                        on purchaseItems.purchase = $self;
    status        : String enum {
        Shopping;
        Paid;
        PurchaseReturnedAmountRefunded;
    } default 'Shopping';
}

entity PurchaseItems : cuid, managed {
    purchase : Association to Purchases;
    item     : Association to Items;
    quantity : Integer;
}
