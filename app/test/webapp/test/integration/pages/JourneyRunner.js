sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"test/test/integration/pages/CustomersObjectPage",
	"test/test/integration/pages/PurchasesObjectPage"
], function (JourneyRunner, CustomersObjectPage, PurchasesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('test') + '/test/flp.html#app-preview',
        pages: {
			onTheCustomersObjectPage: CustomersObjectPage,
			onThePurchasesObjectPage: PurchasesObjectPage
        },
        async: true
    });

    return runner;
});

