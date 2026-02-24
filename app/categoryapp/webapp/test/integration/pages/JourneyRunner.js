sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"categoryapp/test/integration/pages/CategoryList",
	"categoryapp/test/integration/pages/CategoryObjectPage",
	"categoryapp/test/integration/pages/ItemsObjectPage"
], function (JourneyRunner, CategoryList, CategoryObjectPage, ItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('categoryapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCategoryList: CategoryList,
			onTheCategoryObjectPage: CategoryObjectPage,
			onTheItemsObjectPage: ItemsObjectPage
        },
        async: true
    });

    return runner;
});

