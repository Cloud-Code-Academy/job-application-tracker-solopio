public with sharing class TestDataFactory {
    
    public static Job_Aplication__c  createJobAplicationObject (){
        Job_Aplication__c jobApp = new Job_Aplication__c(Status__c = 'Saved', Company_Name__c = 'TestCopmpanyName', 
        Job_title__c = 'TestTitleName');
        return jobApp;
        }
    
    public static Interview__c createInterviewObjectNotInWeekend (Id  jobAppId){

        DateTime myDate = generateDateNotInWeekend();
        Interview__c  interview = new Interview__c (Date_Of_Interview__c = myDate, Job_Aplication__c =  jobAppId);
        return interview;
    } 
     
    public static DateTime generateDateNotInWeekend() {
            DateTime startData = DateTime.now(); // Możesz zacząć od teraz lub od konkretnej daty
            //Integer addDay = 0;
            while (true) {
                if (startData.format('E') != 'Sat' && startData.format('E') != 'Sun') {
                    break; 
                }
                startData = startData.addDays(1);
            }
             return startData;
    }
}
