({
	 GetAnswers : function (component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        
        var action = component.get('c.getAllAnswerRecords');
        action.setParams({
            questionId : component.get('v.recordId')
                        
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                 var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                
                component.set('v.AllAnswers',response)
                if(response == null || response == ''){
                   component.set('v.TableFlag',false); 
                }else{
                    component.set('v.TableFlag',true); 
                }
               // alert('yyyyyy');
                
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