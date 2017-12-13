({
onSelectChange : function(component, event, helper) {
    var selected = component.find("types").get("v.value");
    component.set("v.selection", selected);

},
   fireApplicationEvent : function(cmp, event) {
        var submittedType = cmp.find("submittedtypes").get("v.value");
        var selected = cmp.find("types").get("v.value");

        var appEvent = $A.get("e.c:compensationTypeSelected");
        appEvent.setParams({
            "selection" : selected,
            "selectionSubmitted" : submittedType
        });
        appEvent.fire();
    }
})
