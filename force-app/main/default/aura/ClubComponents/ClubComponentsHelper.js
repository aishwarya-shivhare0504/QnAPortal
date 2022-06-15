({
    getQuestionRecord : function(component, event, helper) {
        
        var action = component.get('c.getQuesRecord');
        
        action.setParams({
            questionId : component.get('v.recordId')
            
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                
                component.set('v.showModal', false); 
                component.set('v.Question',response)
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
    },
    
    getCurrentUserDet : function(component, event, helper) {
        
        
        var action = component.get('c.getCurrentUserId');
        
        action.setParams({
            
            
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                
                component.set('v.UserID', response); 
                
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
    },
})