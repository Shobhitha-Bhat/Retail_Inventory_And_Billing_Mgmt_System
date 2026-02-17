using {my.retailshop as db}from '../db/schema';

service AdminService{
    entity Customers as projection on db.Customers;
    entity Category as projection on db.Categories;
    
    entity Items as projection on db.Items
    actions{
        action reStockItems(newStocks:Integer);
    }

    entity Purchases as projection on db.Purchases
    actions{
        action addItemsToPurchase();
        action removeItemsFromPurchase();
        action updateQuantityofItems();
        action payForPurchase();
        action returnPurchase();
    }
}