({
onSelectChange : function(component, event, helper) {
    var selected = component.find("types").get("v.value");
    component.set("v.selection", selected);

},
   fireApplicationEvent : function(cmp, event) {
        var selected = cmp.find("types").get("v.value");
        var appEvent = $A.get("e.c:compensationTypeSelected");
        appEvent.setParams({
            "selection" : selected
        });
        appEvent.fire();
    }
})
