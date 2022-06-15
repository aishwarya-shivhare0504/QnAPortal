({
    
    closeModal: function(component, event, helper) {
        component.set('v.showModal', false);
        //Reloading all the answer list to get the latest changes
        var cmpEvent = component.getEvent("SortingEvent"); 
        cmpEvent.fire(); 
    },
    
    markAsBest : function (component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        var action = component.get('c.selectedAsBestAns'); 
        action.setParams({
            ans : component.get('v.Answer')
            
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                var response= actionResult.getReturnValue();                
                component.set('v.showModal', false);
                
                //Hiding the AnswerQuestion Component is clubComponents component when best answer is selected
                var cmpEvent = component.getEvent("HideAnswerInputFieldEvent"); 
                cmpEvent.fire(); 
                
            } else if(status =='ERROR') {
                
                var errors = actionResult.getError();
                alert('erros' + errors);
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