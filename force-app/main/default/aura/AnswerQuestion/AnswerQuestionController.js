({
	doInit : function(component, event, helper) {
		
	},
 
    submitAnswer : function (component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        var action = component.get('c.answerQuestionRecord');
        action.setParams({
            question : component.get('v.recordId'),
            answer : component.get('v.AnswerDescription')
                        
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                 var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                
                component.set('v.AnswerDescription','');
                
                //FIRING AN EVENT
                var cmpEvent = component.getEvent("EventForReload");
               
                cmpEvent.setParams({"message" : "Reload List"}); 
                cmpEvent.fire();
                
                if(response != ''){
                     alert(response);
                }
               
                
                
                
            } else if(status =='ERROR') {
                
				var errors = actionResult.getError();
                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
		    }
        })
        $A.enqueueAction(action);
    }

})