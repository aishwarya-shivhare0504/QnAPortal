public class TestDataFactory {
    
    Public static List<Question__c> CreateQuestions(){
        
        List<Question__c> QList = new List<Question__c>();
        for(Integer i = 0; i<5; i++){
            Question__c q = new Question__c(Name = 'Question' + i , Description__c = 'Question' + i);
            QList.add(q);
        }
        
       insert QList; 
       return QList; 
    }
    
    Public static List<Answer__c> CreateAnswer(){
        List<Question__c> QList = TestDataFactory.CreateQuestions();
        List<Answer__c> AList = new List<Answer__c>();
        for(Integer i = 0; i<5; i++){
            Answer__c q = new Answer__c(Name = 'Answer' + i , Description__c = 'Answer' + i, Question__c = QList[0].Id,UpVote__c = 0, DownVote__c = 0);
            AList.add(q);
        }
       
        insert AList;
       return AList; 
    }

}