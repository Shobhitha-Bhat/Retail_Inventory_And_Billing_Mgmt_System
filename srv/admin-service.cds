using {my.retailshop as db}from '../db/schema';

service AdminService{
    entity Customers as projection on db.Customers;
    entity Category as projection on db.Categories;
    entity Purchases as projection on db.Purchases;
    
    entity Items as projection on db.Items
    actions{
        action reStockItems(newStocks:Integer);
    }

    // entity PurchaseItems as projection on db.PurchaseItems;
}