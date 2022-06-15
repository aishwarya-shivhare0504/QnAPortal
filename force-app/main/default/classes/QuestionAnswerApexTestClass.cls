@isTest
public class QuestionAnswerApexTestClass {
    
    @TestSetUp
    public static void Init(){
       List<Question__c> QList = TestDataFactory.CreateQuestions();
       
        List<Answer__c> AList = TestDataFactory.CreateAnswer();
        
    }
    
    @isTest
    public static void AskQuestionPageSubmit_Test(){
        Test.startTest();
        String Question = 'Which is the best city in India';
        QuestionAnswerApex.askQuestionPageSubmit(Question);
        List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c, CreatedById FROM Question__c where Name LIKE '%Which is the%' limit 1];                  
        Test.stopTest();
        System.assertEquals(Question, QList[0].Description__c);
    }

	@isTest
    public static void AswerQuestionRecord_Test(){
        List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c, CreatedById FROM Question__c limit 1];
        Test.startTest();
        QuestionAnswerApex.answerQuestionRecord(QList[0].id, 'Answer String');
        Test.stopTest();
        List<Answer__c> AllAnsL = [SELECT Id, IsDeleted, Name, CreatedById, Description__c, UpVote__c, DownVote__c, Rating__c,CreatedDate,Question__c FROM Answer__c where Question__c=:QList[0].id and Name LIKE '%Answer S%'limit 1];
     
         System.assertEquals('Answer String', AllAnsL[0].Description__c);
    }

	@isTest
    public static void GetAllAnswerRecords_Test(){
        List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c,(SELECT Id, IsDeleted, Name from Answers__r), CreatedById FROM Question__c limit 1];
        Test.startTest();
        List<Answer__c> All = QuestionAnswerApex.getAllAnswerRecords(QList[0].id);
        Test.stopTest();
        System.assert(All.size()!=null);
    }    
    
    @isTest
    public static void Vote_Test(){
        List<Answer__c> AllAnsL = [SELECT Id, IsDeleted, Name, CreatedById, Description__c, UpVote__c, DownVote__c, Rating__c,CreatedDate from Answer__c limit 1];
  		List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c,(SELECT Id, IsDeleted, Name from Answers__r), CreatedById FROM Question__c limit 1];
     
        Test.startTest();
        Answer__c a = QuestionAnswerApex.vote(true ,false, AllAnsL[0].id,QList[0].id);
        Test.stopTest();
        System.assert(a!=null);
    }   
    
    @isTest
    public static void Vote_Test2(){
        List<Answer__c> AllAnsL = [SELECT Id, IsDeleted, Name, CreatedById, Description__c, UpVote__c, DownVote__c, Rating__c,CreatedDate from Answer__c limit 1];
  		List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c,(SELECT Id, IsDeleted, Name from Answers__r), CreatedById FROM Question__c limit 1];
     
        Test.startTest();
        Answer__c a = QuestionAnswerApex.vote(false ,true, AllAnsL[0].id,QList[0].id);
        Test.stopTest();
        System.assert(a!=null);
    }   

    @isTest
    public static void Vote_Test3(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
        UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = '');
        insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(true ,false, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    }   
    
    @isTest
    public static void Vote_Test4(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
        UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = 'like');
        insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(true ,false, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    }   

    @isTest
    public static void Vote_Test5(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
        UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = 'dislike');
        insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(true ,false, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    }   

    @isTest
    public static void Vote_Test6(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
        UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = 'dislike');
        insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(false ,true, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    }   
    
    @isTest
    public static void Vote_Test7(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
        UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = 'dislike');    insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(false ,true, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    } 
    @isTest
    public static void Vote_Test8(){
        Question__c q = new Question__c(Name = 'Question', Description__c = 'Question');
        insert q;
        Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=q.id,DownVote__c=0,UpVote__c=0);
        insert a;
         UserAnsQuesLikeDislike__c u = new UserAnsQuesLikeDislike__c(User__c = QuestionAnswerApex.getCurrentUserId(), Question__c =q.id, Answer__c = a.id, LikeOrDislike__c = 'dislike');
        insert u;
        Test.startTest();
        Answer__c ans = QuestionAnswerApex.vote(false ,true, a.id,q.id);
        Test.stopTest();
        System.assert(ans!=null);
    }  

    @isTest
    public static void getCurrentUserId_Test(){
        Test.startTest();
        String u = QuestionAnswerApex.getCurrentUserId();
        Test.stopTest();
        System.assert(u!=null);
    }   

    @isTest
    public static void SelectedAsBestAns_Test(){
       	List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c, CreatedById FROM Question__c limit 1];                  
		Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=QList[0].id);
        insert a;
        Test.startTest();
        Answer__c a2 = QuestionAnswerApex.selectedAsBestAns(a);
        Test.stopTest();
        System.assert(a2!=null);
    }  
    @isTest
    public static void SelectedAsBestAns_Test2(){
       	List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c, CreatedById FROM Question__c limit 1];                  
		Answer__c a = new Answer__c(Name='ss',Description__c='ddff',Question__c=QList[0].id);
        insert a;
        Answer__c b = new Answer__c(Name='ss',Description__c='ddff',Question__c=QList[0].id);
        insert b;
        Test.startTest();
        Answer__c a2 = QuestionAnswerApex.selectedAsBestAns(a);
        Test.stopTest();
        System.assert(a2!=null);
    }   
    
    @isTest
    public static void GetQuesRecord_Test(){
       	List<Question__c> QList = [SELECT Id, Name, Description__c, Best_Answer_Selected__c, CreatedById FROM Question__c limit 1];                  
	
        Test.startTest();
        Question__c a2 = QuestionAnswerApex.getQuesRecord(QList[0].id);
        Test.stopTest();
        System.assert(a2!=null);
    }   
}