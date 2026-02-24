sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"customerapp/test/integration/pages/CustomersList",
	"customerapp/test/integration/pages/CustomersObjectPage",
	"customerapp/test/integration/pages/PurchasesObjectPage"
], function (JourneyRunner, CustomersList, CustomersObjectPage, PurchasesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('customerapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCustomersList: CustomersList,
			onTheCustomersObjectPage: CustomersObjectPage,
			onThePurchasesObjectPage: PurchasesObjectPage
        },
        async: true
    });

    return runner;
});

