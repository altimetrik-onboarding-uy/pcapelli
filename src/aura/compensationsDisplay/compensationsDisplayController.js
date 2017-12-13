({
	doInit: function(component, event, helper) {
        var myAttribute = 'all';
        var submittedValue = 'all';
        var contactId = component.get("v.contactId");


	    var action = component.get("c.getCompensations");
        action.setParams({ "recordType" : myAttribute,
                          "contactId" : contactId,
                          "submittedValue" : submittedValue});

	    action.setCallback(this, function(response) {
	        var state = response.getState();
	        if (state === "SUCCESS") {
	            component.set("v.compensationsList", response.getReturnValue());
	        }
	        else {
	            console.log("Failed with state: " + state);
	        }
	    });

	    $A.enqueueAction(action);
	},

    editRecord : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var recId = selectedItem.dataset.record;


        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
             "recordId": recId
        });
        editRecordEvent.fire();
},
    handleApplicationEvent : function(cmp, event) {
        var selection = event.getParam("selection");
        var submittedType = event.getParam("selectionSubmitted");

        // set the handler attributes based on event data
        cmp.set("v.statusTypeSelected", submittedType);
        cmp.set("v.typeSelected", selection);

        var action = cmp.get("c.getCompensations");
        action.setParams({ "recordType" : selection,
                          "submittedValue": submittedType});

	    action.setCallback(this, function(response) {
	        var state = response.getState();
	        if (state === "SUCCESS") {
	            cmp.set("v.compensationsList", response.getReturnValue());
	        }
	        else {
	            console.log("Failed with state: " + state);
	        }
	    });


	    $A.enqueueAction(action);
    },
    clickSubmitCompensation : function(cmp, event) {
        var boxesSelected = [];
        var getAllId = cmp.find("selectedCompensations");
        for (var i = 0; i < getAllId.length; i++) {
           if (getAllId[i].get("v.compensation.Submitted__c") == true) {
             boxesSelected.push(getAllId[i].get("v.compensation.Id"));
           }
         }
        var action = cmp.get("c.setCompensationsAsSubmitted");
        action.setParams({ "recordIdToSubmit" : boxesSelected});

	    action.setCallback(this, function(response) {
	        var state = response.getState();
	        if (state === "SUCCESS") {
	            console.log("OK: " + state);
                $A.get('e.force:refreshView').fire();
	        }
	        else {
	            console.log("Failed with state: " + state);
	        }
	    });

	    $A.enqueueAction(action);

    },

    exportCSV : function(component, event, helper) {
        var objectRecords = component.get("v.compensationsList");

        var csvStringResult, counter, keys, columnDivider, lineDivider;

        if (objectRecords == null || !objectRecords.length) {
            return;
        }

        columnDivider = ',';
        lineDivider =  '\n';


        keys = ['Name','Birthdate','Job_Category__c','RecordTypeId','Amount__c','Location__c','Office__c', 'Submitted__c', 'Status__c' ];

        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;

        for(var i=0; i < objectRecords.length; i++){
            counter = 0;

            for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;


                if(counter > 0){
                    csvStringResult += columnDivider;
                }
                if(skey === 'Name' || skey === 'Birthdate' || skey === 'RecordTypeId'){
                    if(skey === 'Name'){
                        var csvAddString = objectRecords[i].Contact__r.Name;}
                    if(skey === 'Birthdate'){
                        var csvAddString = objectRecords[i].Contact__r.Birthdate;}
                    if(skey === 'RecordTypeId'){
                        if (objectRecords[i].RecordType === undefined){
                            var csvAddString = '';
                        }else{
                            var csvAddString = objectRecords[i].RecordType.Name;
                        }
                        }

                    csvStringResult += '"'+ csvAddString +'"';
                    counter++;

                }else{
                    csvStringResult += '"'+ objectRecords[i][skey]+'"';

                    counter++;
                }

                 }
                 csvStringResult += lineDivider;
                 }


        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvStringResult);
        hiddenElement.target = '_self';
        hiddenElement.download = 'Compensations.csv';
        document.body.appendChild(hiddenElement);
        hiddenElement.click();
    }





})
