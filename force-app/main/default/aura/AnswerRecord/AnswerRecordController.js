({
    doInit : function(component, event, helper) {
        //UpVote ,boolean DownVote, String AnswerId
    },
    voteMethod : function (component, event, helper) {
        if(event.getSource().get("v.label") == 'upvote'){            
            component.set('v.UpVote',true);
            component.set('v.DownVote',false);
            
        }
        if(event.getSource().get("v.label") == 'downvote'){
            component.set('v.UpVote',false);
            component.set('v.DownVote',true);
        }
        
        var action = component.get('c.vote');
        action.setParams({
            
            upVote : component.get('v.UpVote'),
            downVote : component.get('v.DownVote'),
            answerId : component.get('v.AnswerFromParent.Id'),
            questionId : component.get('v.Question.Id')
            
            
        });
        action.setCallback(this,function(actionResult){
            var status = actionResult.getState();
            if(status=='SUCCESS'){
                var response= actionResult.getReturnValue();
                //alert('JSON.parse(response)' + JSON.parse(response));
                
                component.set('v.AnswerFromParent',response);
                
                var cmpEvent = component.getEvent("SortingEvent"); 
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
        //$A.get('e.force:refreshView').fire();
    },
    openModal: function(component, event, helper) {
        component.set('v.showModal', true);
        
        
    },
    
    editAnswer: function(component, event, helper) {
        if(component.get('v.showEditScreen') == true){
            component.set('v.showEditScreen', false);
        }else{
            component.set('v.showEditScreen', true);
        }      
    },
    
    handleSubmit: function(component, event, helper) {
        
        var cmpEvent = component.getEvent("SortingEvent"); 
        cmpEvent.fire(); 
    }
    
    
})