public without sharing class QuestionAnswerApex{
    public static String userID = UserInfo.getUserId();
        
    @AuraEnabled
    public static String askQuestionPageSubmit(String question){
         String baseUrl ='';
        try{
            if(question!=null || question.trim().remove(' ')!=''){
                
                Integer descriptionLength = question.length();
                If(descriptionLength >30){
                    descriptionLength = 30;
                }
                Question__c newQuestion = new Question__c(Name = question.substring(0,descriptionLength) , Description__c = question );
                insert newQuestion;
                baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + newQuestion.Id;

		
            }       
        }catch (Exception e) {
            System.debug('Exception => ' + e.getMessage());
        }

       
        
        return baseUrl;
    }
    
    @AuraEnabled
    public static String answerQuestionRecord(String question, String answer){
        String returnString = '';
        try{
            
            if(answer !=null  && answer.trim().remove(' ')!='' ){
                List<Question__c> questionList = [SELECT Id, Name, Description__c,Best_Answer_Selected__c, CreatedById, OwnerId FROM Question__c where id =:question limit 1];
                Integer descriptionLength = Answer.length();
                If(descriptionLength >30){
                    descriptionLength = 30;
                }
                if(questionList[0].Best_Answer_Selected__c == false){
                    Answer__c a = new Answer__c( Name = answer.substring(0,descriptionLength) , Description__c = Answer, Question__c = questionList[0].Id,UpVote__c = 0, DownVote__c = 0);
                	insert a;
                    returnString =  '';
                }else{
                    returnString =  'Best Answer is already selected. Please reload the page to see the best answer';
                }
                
            }     
        }catch (Exception e) {
            System.debug('Exception => ' + e.getMessage());
        }
        return returnString;
    }
    
    @AuraEnabled
    public static List<Answer__c> getAllAnswerRecords(String questionId){
        List<Answer__c> allAnsSortedList = [SELECT Id, IsDeleted,Best_Answer__c,(SELECT Id, User__c , Question__c, Answer__c , LikeOrDislike__c FROM UserAnsQuesLikeDislikes__r where Question__c=:questionId and User__c =:userID limit 1 ), Name, CreatedById, Description__c, UpVote__c, DownVote__c, Rating__c,CreatedDate,Question__c FROM Answer__c where Question__c=:QuestionId order BY Rating__c DESC , CreatedDate DESC];
        return allAnsSortedList;
    }
   
    
    
    @AuraEnabled
    public static Answer__c vote(boolean upVote ,boolean downVote, String answerId,String questionId){
        
        List<Answer__c> allAnsList = [SELECT Id, IsDeleted,Best_Answer__c, Name, CreatedById, Description__c,(SELECT Id, User__c , Question__c, Answer__c , LikeOrDislike__c FROM UserAnsQuesLikeDislikes__r where Question__c=:questionId and User__c =:userID limit 1 ), UpVote__c, DownVote__c, Rating__c, Question__c FROM Answer__c where Id=:answerId]; 
        system.debug('****AllAnsL' + allAnsList[0]);
        List<UserAnsQuesLikeDislike__c> userActivityList = new List<UserAnsQuesLikeDislike__c>();
        userActivityList = allAnsList[0].UserAnsQuesLikeDislikes__r;
        system.debug('****userActivityList' + userActivityList);
        if(!userActivityList.isEmpty() && userActivityList.size()==1){
            if(userActivityList[0].LikeOrDislike__c== '' || userActivityList[0].LikeOrDislike__c == null){
                if(upVote==true){
                    allAnsList[0].UpVote__c = allAnsList[0].UpVote__c + 1;
                    userActivityList[0].LikeOrDislike__c = Utility.UPVOTE;
                }else if(downVote == true){
                    allAnsList[0].DownVote__c = allAnsList[0].DownVote__c + 1;
                    userActivityList[0].LikeOrDislike__c = Utility.DOWNVOTE;
                }
            }else if(userActivityList[0].LikeOrDislike__c== Utility.UPVOTE){
                if(UpVote==true){
                    allAnsList[0].UpVote__c = allAnsList[0].UpVote__c - 1;
                    userActivityList[0].LikeOrDislike__c = Utility.NONE;
                }else if(DownVote==true){ //new if else
                    allAnsList[0].UpVote__c = allAnsList[0].UpVote__c - 1;
                     allAnsList[0].DownVote__c = allAnsList[0].DownVote__c + 1;
                    userActivityList[0].LikeOrDislike__c = Utility.DOWNVOTE;
                }
            }else if(userActivityList[0].LikeOrDislike__c== Utility.DOWNVOTE){
                if(DownVote==true){
                    allAnsList[0].DownVote__c = allAnsList[0].DownVote__c - 1;
                    userActivityList[0].LikeOrDislike__c = '';
                }else if(UpVote==true){ //new if else
                    allAnsList[0].DownVote__c = allAnsList[0].DownVote__c - 1;
                    allAnsList[0].UpVote__c = allAnsList[0].UpVote__c + 1;
                    userActivityList[0].LikeOrDislike__c = Utility.UPVOTE;
                }
         
            }
            
            update userActivityList[0];
            
        }else{
            system.debug('****else');
            UserAnsQuesLikeDislike__c userActivity = new UserAnsQuesLikeDislike__c();
            userActivity.User__c  = userID;
            userActivity.Answer__c = answerId;
            userActivity.Question__c = questionId;
             system.debug('****else2');
            if(upVote == true){
                 userActivity.LikeOrDislike__c = Utility.UPVOTE;
                system.debug('****else3');
            	 allAnsList[0].UpVote__c = allAnsList[0].UpVote__c + 1;
                system.debug('****else4');
            }
               
            if(downVote == true){
                userActivity.LikeOrDislike__c = Utility.DOWNVOTE;
            	 allAnsList[0].DownVote__c = allAnsList[0].DownVote__c + 1;
            }
                
            system.debug('****elseuserActivity ' + userActivity);
            insert userActivity;
            
        }
        
        update allAnsList[0];
        return allAnsList[0];
    }    
    
    
    
    @AuraEnabled
    public static Answer__c selectedAsBestAns(Answer__c ans){
        
        List<Answer__c> ansList = new List<Answer__c>();        
        ans.Best_Answer__c = true;
        ansList.add(Ans);
        
        
        List<Question__c> questionList = [SELECT Id, Name, Description__c,Best_Answer_Selected__c,(SELECT Id, IsDeleted,Best_Answer__c FROM Answers__r), CreatedById, OwnerId FROM Question__c where id =:Ans.Question__c];
        
        for(Answer__c a: questionList[0].Answers__r){
            
            if(Ans.id != a.id && a.Best_Answer__c == true){
                a.Best_Answer__c = false;
                ansList.add(a); 
            }
            
        }
         
        questionList[0].Best_Answer_Selected__c =true;
        
        Database.update(ansList,false) ;
        update questionList[0];
        return ans;
    }
    
    @AuraEnabled
    public static String getCurrentUserId(){
        
        String userID = userID;
        return userID;
        
    }
    
    @AuraEnabled
    public static Question__c getQuesRecord(String questionId){
        
        List<Question__c> questionList = [SELECT Id, Name, Description__c,Best_Answer_Selected__c, CreatedById, OwnerId FROM Question__c where id =:QuestionId];
        
        return questionList[0];
    }
    
}