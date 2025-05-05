public with sharing class EmailNotificationService implements Schedulable {

    public void execute(SchedulableContext ctx) {
   
    List<Interview__c> interviews = [SELECT Id, Name, Date_Of_Interview__c, Job_Aplication__r.OwnerId, Job_Aplication__c FROM Interview__c 
    WHERE Date_Of_Interview__c = TOMORROW];
            InterviewHelper.remindOwnerOfTomorrowInterviews(interviews);
    }
}