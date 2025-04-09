sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'soa/db/manageorder/test/integration/FirstJourney',
		'soa/db/manageorder/test/integration/pages/POServiceList',
		'soa/db/manageorder/test/integration/pages/POServiceObjectPage',
		'soa/db/manageorder/test/integration/pages/POItemSObjectPage'
    ],
    function(JourneyRunner, opaJourney, POServiceList, POServiceObjectPage, POItemSObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('soa/db/manageorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOServiceList: POServiceList,
					onThePOServiceObjectPage: POServiceObjectPage,
					onThePOItemSObjectPage: POItemSObjectPage
                }
            },
            opaJourney.run
        );
    }
);