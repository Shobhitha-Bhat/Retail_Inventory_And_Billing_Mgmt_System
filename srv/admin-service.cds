using {my.retailshop as db} from '../db/schema';

service AdminService {
    entity Customers     as projection on db.Customers;
    annotate Customers with @odata.draft.enabled;
    entity Category      as projection on db.Categories;
    annotate Category with @odata.draft.enabled;

    entity Items         as projection on db.Items
        actions {
            action reStockItems(newStocks: Integer);
        };


    entity Purchases     as projection on db.Purchases
        actions {
            action removeItemsFromShopping(customer_ID: UUID,
                                           purchaseItems: many {
                item_ID  : UUID;
                quantity : Integer
            })                            returns String;

            // action    payForPurchase(customer_ID: UUID, purchase_ID: UUID);
            action payForPurchase()       returns Purchases;
            // action    returnItemsFromPaidPurchase(customer_ID: UUID,
            //                                   purchaseItems: many {
            //     item_ID  : UUID;
            //     quantity : Integer
            // }) ;

            // action returnEntirePurchase(customer_ID: UUID);
            action returnEntirePurchase() returns Purchases;
        // action updateQuantityofItems(); same as purchaseItems
        };

    annotate Purchases with @odata.draft.enabled;

    entity PurchaseItems as projection on db.PurchaseItems
        actions {
            action returnItemsFromPaidPurchase(customer_ID: UUID,
                                               purchaseItems: many {
                item_ID  : UUID;
                quantity : Integer
            });

        };

    action purchasenewItems(customer_ID: UUID,
                            purchaseItems: many {
        item_ID  : UUID;
        quantity : Integer
    });
}
