sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchasesapp/test/integration/pages/PurchasesList",
	"purchasesapp/test/integration/pages/PurchasesObjectPage",
	"purchasesapp/test/integration/pages/PurchaseItemsObjectPage"
], function (JourneyRunner, PurchasesList, PurchasesObjectPage, PurchaseItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchasesapp') + '/test/flp.html#app-preview',
        pages: {
			onThePurchasesList: PurchasesList,
			onThePurchasesObjectPage: PurchasesObjectPage,
			onThePurchaseItemsObjectPage: PurchaseItemsObjectPage
        },
        async: true
    });

    return runner;
});

