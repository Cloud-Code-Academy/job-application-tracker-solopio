public with sharing class SchedulerOfStaleJobs implements Schedulable{
   
    public void execute(SchedulableContext ctx){
        List<Job_Aplication__c> listOfJobs = new List<Job_Aplication__c>();
        listOfJobs = [SELECT Id, Follow_up_date__c, Status__c, Notes__c FROM Job_Aplication__c];
        ServiceOfStaleJobs.cleanJobs(listOfJobs);
    }
}