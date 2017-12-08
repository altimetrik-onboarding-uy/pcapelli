({
	doInit: function(component, event, helper) {
        var myAttribute = 'all';
        var contactId = component.get("v.contactId");


	    var action = component.get("c.getCompensations");
        action.setParams({ "recordType" : myAttribute,
                          "contactId" : contactId});

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

        // set the handler attributes based on event data
        cmp.set("v.typeSelected", selection);
        var action = cmp.get("c.getCompensations");
        action.setParams({ "recordType" : selection});

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
    }
})
