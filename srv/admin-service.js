module.exports = function () {

    //check if category exists before adding a new item.
    this.before('CREATE', 'Items', async (req) => {
        const { category_ID } = req.data;

        const category = await SELECT.one.from('Categories').where({ ID: category_ID })

        if (!category) {
            req.reject(404, 'Category Not found')
        }
    })


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


    this.before('DELETE', 'Customers', (req) => {
        req.reject(403, "Once a customer registers to the company's database, can't be deleted.")

    })


    this.before('CREATE', 'Purchases', (req) => {
        if (!req.data.purchaseItems || req.data.purchaseItems.length === 0) {
            req.reject(400, 'Purchase must contain atleast 1 item.')
        }
    })


    // Creating a new Purchase
    //1. Check if the requested Items exists. 
    //2.Check if enough quantity exists as per customer request.
    //3. Even if one of the item doesnt exist or unavailable quantity in stock-> notify missing items itemids and low stock itemids and by how much less and cancel purchase.
    //4. Decrement totstocks of Items by quantity
    //5.Increment totOrders of the customer by 1.

    this.on('CREATE', 'Purchases', async (req,next) => {
        let missingItemsIDs = new Map();
        let availableItemsIDs = new Map();
        let lowStockItemsIDs = new Map();


        for (const { item_ID, quantity } of req.data.purchaseItems) {
            const itemExists = await SELECT.one.from('Items').where({ ID: item_ID })
            // 1)
            if (!itemExists) {
                missingItemsIDs.set(item_ID, quantity);
                continue;
            }
            // 2)
            if (itemExists.totStocks < quantity) {
                lowStockItemsIDs.set(item_ID, quantity - itemExists.totStocks);
                continue;
            }
            availableItemsIDs.set(item_ID, quantity);
        }

        // 3)
        if (missingItemsIDs.size > 0 || lowStockItemsIDs.size > 0) {
            return { message: `Unavailable Items: ${JSON.stringify([...missingItemsIDs])} and Items with less Stock and Required ${JSON.stringify([...lowStockItemsIDs])} ` }
        }

        // 4)
        for (const [ item_ID, quantity ] of availableItemsIDs) {
            await UPDATE('Items').set({ totStocks: {'-=':quantity} }).where({ ID: item_ID })
        }
        // 5)
        await UPDATE('Customers').set({ totalOrders:{'+=':1} }).where({ ID: req.data.customer_ID })

        return next();
    })


    this.on('DELETE','Purchases',(req)=>{
        req.reject(403, "Purchase Already recorded in company's Database. Cannot Delete.")
    })

}