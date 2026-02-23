sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"adminapp/test/integration/pages/CustomersList",
	"adminapp/test/integration/pages/CustomersObjectPage",
	"adminapp/test/integration/pages/PurchasesObjectPage"
], function (JourneyRunner, CustomersList, CustomersObjectPage, PurchasesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('adminapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCustomersList: CustomersList,
			onTheCustomersObjectPage: CustomersObjectPage,
			onThePurchasesObjectPage: PurchasesObjectPage
        },
        async: true
    });

    return runner;
});

