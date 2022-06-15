({
    doInit : function(component, event, helper) {
        
    },
    
    submitQuestion : function (component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        var action = component.get('c.askQuestionPageSubmit');
        action.setParams({
            question : component.get('v.QuestionDescription'),
            
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                //alert('url' + response);
               
                component.set('v.QuestionDescription','');
                window.location.replace(response);
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