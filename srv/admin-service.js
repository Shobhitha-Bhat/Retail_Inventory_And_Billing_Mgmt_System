module.exports = function () {

    //check if category exists before adding a new item.
    this.before('CREATE', 'Items', async (req) => {
        const { category_ID } = req.data;

        const category = await SELECT.one.from('Categories').where({ ID: category_ID })

        if (!category) {
            req.reject(404, 'Category Not found')
        }
    })

    // =====================================================================================================================
    //check if the item already exists.  using the itemname and not the itemID
    //if yes...just restock it...(increment totStock)
    //else create a new item row. ie., skip back to normal create 
    this.on('CREATE', 'Items', async (req, next) => {
        const { itemName, totStocks, category_ID } = req.data;

        const itemExists = await SELECT.one.from('Items').where({ itemName, category_ID })

        if (itemExists) {
            await UPDATE('Items').set({ totStocks: itemExists.totStocks + totStocks }).where({ ID: itemExists.ID })
            // req.reject(200, "Item ReStocked.No new Item Added.")
            return { message: "Item reStocked. No new item added." }
        }
        return next();

    })

    // =======================================================================================================================
    //Action :  ReStock Items
    this.on('reStockItems', async (req) => {
        const { newStocks } = req.data;
        const { ID } = req.params[0];

        const item = await SELECT.one.from('Items').where({ ID })
        if (!item) {
            req.reject(404, 'Item Not found')
        }
        await UPDATE('Items').set({ totStocks: item.totStocks + newStocks }).where({ ID })
    })
    // ===================================================================================================================

    this.before('DELETE', 'Customers', (req) => {
        req.reject(403, "Once a customer registers to the company's database, can't be deleted.")

    })

    // ===================================================================================================================

    //deprecated as there is not Standard CREATE Purchase
    // this.before('CREATE', 'Purchases', (req) => {
    //     if (!req.data.purchaseItems || req.data.purchaseItems.length === 0) {
    //         req.reject(400, 'Purchase must contain atleast 1 item.')
    //     }
    // })



    //Deprecated since the Standard create was moved to Custom Action purchaseItems
    // this.before('CREATE','Purchases',async(req,next)=>{
    //     const {customer_ID}=req.data;
    //     const userExists = await SELECT.one.from('Purchases').where({customer_ID,status:'Shopping'});
    //     if(userExists){
    //         req.reject(400,'Add the Items to your previous pending purchase. Cant Register a new Purchase');
    //     }else{
    //         return next();
    //     }
    // })

    // Creating a new Purchase(deprecated)  => now an action purchaseItems(customerID:UUID,itemID:UUID,quantity:Integer)
    //1. Check if the requested Items exists. 
    //2. Check if enough quantity exists as per customer request.
    //3. Even if one of the item doesnt exist or unavailable quantity in stock-> notify missing items itemids and low stock itemids and by how much less and cancel purchase.
    //4. Decrement totstocks of Items by quantity
    //5.Increment totOrders of the customer by 1.

    // this.on('CREATE', 'Purchases', async (req,next) => {
    //     let missingItemsIDs = new Map();
    //     let availableItemsIDs = new Map();
    //     let lowStockItemsIDs = new Map();
    //     for (const { item_ID, quantity } of req.data.purchaseItems) {
    //         const itemExists = await SELECT.one.from('Items').where({ ID: item_ID })
    //         // 1)
    //         if (!itemExists) {
    //             missingItemsIDs.set(item_ID, quantity);
    //             continue;
    //         }
    //         // 2)
    //         if (itemExists.totStocks < quantity) {
    //             lowStockItemsIDs.set(item_ID, quantity - itemExists.totStocks);
    //             continue;
    //         }
    //         availableItemsIDs.set(item_ID, quantity);
    //     }

    //     // 3)
    //     if (missingItemsIDs.size > 0 || lowStockItemsIDs.size > 0) {
    //         return { message: `Unavailable Items: ${JSON.stringify([...missingItemsIDs])} and Items with less Stock and Required ${JSON.stringify([...lowStockItemsIDs])} ` }
    //     }

    //     // 4)
    //     for (const [ item_ID, quantity ] of availableItemsIDs) {
    //         await UPDATE('Items').set({ totStocks: {'-=':quantity} }).where({ ID: item_ID })
    //     }
    //     // 5)
    //     await UPDATE('Customers').set({ totalOrders:{'+=':1} }).where({ ID: req.data.customer_ID })

    //     return next();
    // })

    async function find_Available_Missing_LowStockItems(purchaseItems) {
        let missingItemsIDs = new Map();
        let availableItemsIDs = new Map();
        let lowStockItemsIDs = new Map();

        for (const { item_ID, quantity } of purchaseItems) {
            const itemExists = await SELECT.one.from('Items').where({ ID: item_ID })
            if (!itemExists) {
                missingItemsIDs.set(item_ID, quantity);
                continue;
            }
            if (itemExists.totStocks < quantity) {
                lowStockItemsIDs.set(item_ID, quantity - itemExists.totStocks);
                continue;
            }
            availableItemsIDs.set(item_ID, quantity);
        }
        return { missingItemsIDs, lowStockItemsIDs, availableItemsIDs };

    }

    this.on('purchaseItems', async (req) => {
        if (!req.data.purchaseItems || req.data.purchaseItems.length === 0) {
            return req.reject(400, 'Purchase must contain atleast 1 item.')
        }
        const { customer_ID } = req.data;
        //Check if Purchase from that customer exists and in Shopping state:
        const purchaseExists = await SELECT.one.from('Purchases').where({ customer_ID: customer_ID, status: 'Shopping' });

        const { missingItemsIDs, lowStockItemsIDs, availableItemsIDs } = await find_Available_Missing_LowStockItems(req.data.purchaseItems);

        if (missingItemsIDs.size > 0 || lowStockItemsIDs.size > 0) {
            return { message: `Unavailable Items: ${JSON.stringify([...missingItemsIDs])} and Items with less Stock and Required ${JSON.stringify([...lowStockItemsIDs])} ` }
        }

        //If no Purchase exists create a new Purchase
        if (!purchaseExists) {

            //INSERT the NEW purchase row into purchases also Purchaseitems
            // const newPurchase = await INSERT.into('Purchases').entries({ // customer_ID: customer_ID, status: 'Shopping' // }) 
            // // for (const [item_ID, quantity] of availableItemsIDs) { 
            // // await INSERT.into('PurchaseItems').entries({ purchase_ID: newPurchase.ID, item_ID, quantity })

            await INSERT.into('Purchases').entries({
                customer_ID,
                status: 'Shopping',
                purchaseItems: [...availableItemsIDs].map(([item_ID, quantity]) => ({
                    item_ID,
                    quantity
                }))
            })
            //cant use next() for default insertion of new rows as this is not a overriden version of CREATE. This is an action.
        }
        //If a pending purchase by a customer Exists
        else {
            //For each available Item in the addItemToPurchase order
            for (const [item_ID, quantity] of availableItemsIDs) {
                //Check If items already exists in the purchase..
                const itemExistsinPurchase = await SELECT.one.from('PurchaseItems').where({ purchase_ID: purchaseExists.ID, item_ID })
                if (itemExistsinPurchase) {
                    await UPDATE('PurchaseItems').set({ quantity: { '+=': quantity } }).where({ item_ID: item_ID, purchase_ID: purchaseExists.ID })
                }
                else {
                    await INSERT.into('PurchaseItems').entries({
                        purchase_ID: purchaseExists.ID,
                        item_ID: item_ID, quantity: quantity
                    })
                }
            }
        }
        for (const [item_ID, quantity] of availableItemsIDs) {
            await UPDATE('Items').set({ totStocks: { '-=': quantity } }).where({ ID: item_ID })
        }

    })

    // =======================================================================================================================================

    this.on('DELETE', 'Purchases', (req) => {
        req.reject(403, "Purchase Already recorded in company's Database. Cannot Delete.")
    })
    // =======================================================================================================================================

    this.on('payForPurchase', async (req) => {
        const { customer_ID } = req.data;
        const purchase_ID = req.params[0].ID;

        const purchaseExists = await SELECT.one.from('Purchases').where({ customer_ID: customer_ID, ID: purchase_ID });
        if (!purchaseExists) {
            return req.reject(404, 'Purchase Doesnt Exist')
        }
        if (purchaseExists.status === 'Completed') {
            return req.reject(400, 'Purchase Already completed')
        }

        const itemsInPurchase = await SELECT.from('PurchaseItems').where({ purchase_ID, itemStatus: 'Shopping' })
        if (itemsInPurchase.length === 0) {
            return req.reject(400, 'No items in Purchase.')
        } else {
            for (const row of itemsInPurchase) {
                await UPDATE('PurchaseItems').set({ itemStatus: 'ItemPaid' }).where({ purchase_ID, item_ID: row.item_ID });
            }
        }
        await UPDATE('Purchases').set({ status: 'Completed' }).where({ ID: purchase_ID });
        await UPDATE('Customers').set({ totalOrders: { '+=': 1 } }).where({ ID: customer_ID })
    })

    // ==========================================================================================================================================

    this.on('returnEntirePurchase', async (req) => {
        const { customer_ID } = req.data;
        const purchase_ID = req.params[0].ID;

        const purchaseExists = await SELECT.one.from('Purchases').where({ customer_ID: customer_ID, ID: purchase_ID });
        if (!purchaseExists) {
            return req.reject(404, 'Purchase Doesnt Exist')
        }
        if (purchaseExists.status === 'Shopping') {
            return req.reject(400, 'Purchase Not completed. Returns/Refunds are accepted only for Paid Purchases.')
        }
        if (purchaseExists.status === 'PurchaseReturnedAmountRefunded') {
            return req.reject(400, "Purchase already returned and Refunded");
        }
        if (purchaseExists.status === 'Completed') {
            const purchaseItems = await SELECT.from('PurchaseItems').columns('item_ID', 'quantity').where({ purchase_ID: purchase_ID, itemStatus: 'ItemPaid' })
            if (purchaseItems.length > 0) {
                for (const row of purchaseItems) {
                    const item_ID = row.item_ID;
                    const quantity = row.quantity;
                    await UPDATE('Items').set({ totStocks: { '+=': quantity } }).where({ ID: item_ID });
                    await UPDATE('PurchaseItems').set({ itemStatus: 'ItemReturnedAmountRefunded' }).where({ purchase_ID, item_ID: item_ID })
                }
                await UPDATE('Customers').set({ totalOrders: { '-=': 1 } }).where({ ID: customer_ID })
                await UPDATE('Purchases').set({ status: 'PurchaseReturnedAmountRefunded' }).where({ ID: purchase_ID, customer_ID: customer_ID })
            } else {
                return req.reject(400, 'No items in Purchase to return')
            }
        } else {
            return req.reject(400, 'Purchase is Empty. Buy Items.')
        }

    })

    // =============================================================================================================================================

    this.on('removeItemsFromShopping', async (req) => {
        const { customer_ID } = req.data;
        const purchase_ID = req.params[0].ID;
        const missingItemsFromPurchase = [];
        const purchaseExists = await SELECT.one.from('Purchases').where({ customer_ID: customer_ID, ID: purchase_ID });
        if (!purchaseExists) {
            return req.reject(404, 'Purchase Doesnt Exist')
        }
        if (purchaseExists.status === 'Completed') {
            return req.reject(400, 'Purchase Already Paid. Only Return-Refund Possible.')
        }
        if (purchaseExists.status === 'PurchaseReturnedAmountRefunded') {
            return req.reject(400, 'Purchase Already Returned and Refunded.')
        }
        if (purchaseExists.status === 'Shopping') {
            const ItemsinPurchaseExists = await SELECT.from('PurchaseItems').where({ purchase_ID ,itemStatus:'Shopping'})
            if (ItemsinPurchaseExists.length > 0) {
                for (const row of req.data.purchaseItems) {
                    const item_ID = row.item_ID;
                    const quantity = row.quantity;
                    const itemExists = await SELECT.one.from('PurchaseItems').where({ purchase_ID, item_ID: item_ID })
                    if (itemExists) {
                        await UPDATE('Items').set({ totStocks: { '+=': quantity } }).where({ ID: item_ID });
                        if(itemExists.quantity-quantity ===0){
                            await DELETE.from('PurchaseItems').where({ purchase_ID: purchase_ID, item_ID: item_ID })
                        }
                        else{
                            await UPDATE('PurchaseItems').set({quantity:{'-=':quantity}}).where({purchase_ID: purchase_ID, item_ID: item_ID})
                        }
                    }
                    else {
                        missingItemsFromPurchase.push(item_ID)
                    }

                }
                if (missingItemsFromPurchase.length > 0) {
                    return { message: `Some items are not in Purchase List - ${JSON.stringify(missingItemsFromPurchase)}` };
                }
                return { message: "Items removed from purchase and reStocked" };
            }
            else {
                return { message: "No Items in purchasing. Item already Removed" }
            }
        }
    })

    // ==========================================================================================================================================

    this.on('returnItemsFromPaidPurchase', async (req) => {
        const { customer_ID } = req.data;
        const purchase_ID = req.params[0].ID;
        const missingItemsFromPurchase = [];
        const purchaseExists = await SELECT.one.from('Purchases').where({ customer_ID: customer_ID, ID: purchase_ID });
        if (!purchaseExists) {
            return req.reject(404, 'Purchase Doesnt Exist')
        }
        if (purchaseExists.status === 'PurchaseReturnedAmountRefunded') {
            return req.reject(400, 'Purchase Already Returned and Refunded.')
        }
        if (purchaseExists.status === 'Shopping') {
            return req.reject(400, 'Purchase Not Paid.Remove Items.')
        }
        if (purchaseExists.status === 'Completed') {
            let ItemsinPurchaseExists = await SELECT.from('PurchaseItems').where({ purchase_ID ,itemStatus:'ItemPaid'})
            if (ItemsinPurchaseExists.length > 0) {
                for (const row of req.data.purchaseItems) {
                    const item_ID = row.item_ID;
                    const quantity = row.quantity;
                    const itemExists = await SELECT.one.from('PurchaseItems').where({ purchase_ID, item_ID: item_ID })
                    if (itemExists) {
                        await UPDATE('Items').set({ totStocks: { '+=': quantity } }).where({ ID: item_ID });
                        if(itemExists.quantity-quantity ===0){
                            await UPDATE('PurchaseItems').set({ itemStatus: 'ItemReturnedAmountRefunded' }).where({ purchase_ID: purchase_ID, item_ID: item_ID })
                        }else{
                            //itemStatus let it be ItemPaid itself, but reduce quantity
                            await UPDATE('PurchaseItems').set({ quantity:{'-=':quantity} }).where({ purchase_ID: purchase_ID, item_ID: item_ID })
                        }
                    }
                    else {
                        missingItemsFromPurchase.push(item_ID)
                    }
                }
                if (missingItemsFromPurchase.length > 0) {
                    return { message: `Some items are not in Purchase List - ${JSON.stringify(missingItemsFromPurchase)}` };
                }
                                                                            //rare cases that an item is still in shopping even when the purchase is already paid
                ItemsinPurchaseExists = await SELECT.from('PurchaseItems').where({ purchase_ID ,itemStatus: {in: ['ItemPaid','Shopping']}})
                if(ItemsinPurchaseExists.length === 0){
                    await UPDATE('Purchases').set({status:'PurchaseReturnedAmountRefunded'}).where({customer_ID: customer_ID, ID: purchase_ID});
                }else{
                    await UPDATE('Purchases').set({status:'Completed'}).where({customer_ID: customer_ID, ID: purchase_ID});
                }
                return { message: "Items Returned from purchase and reStocked" };
            }
            else {
                return { message: "No Items in purchase. Item already Returned/Removed" }
            }
        }


    })





}