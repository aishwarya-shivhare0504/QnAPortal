({
	doInit : function(component, event, helper) {
		helper.getQuestionRecord(component, event, helper);
        helper.getCurrentUserDet(component, event, helper);
	},
    callingChildMethod : function(component, event, helper) {
        var childComponent = component.find("childCmp");
        var message = childComponent.AuraMethod();
    },
    parentComponentEvent: function(component, event, helper) {
       
       component.set('v.Question.Best_Answer_Selected__c' , true);
    },
})