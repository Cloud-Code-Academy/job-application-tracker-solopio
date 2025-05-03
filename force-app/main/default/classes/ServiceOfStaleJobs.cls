public with sharing class ServiceOfStaleJobs {
   
    public static void cleanJobs(){
 
     List<Job_Aplication__c> listOfJobs = new List<Job_Aplication__c>();
     listOfJobs = [SELECT Id, Follow_up_date__c, Status__c, Notes__c FROM Job_Aplication__c];
     
      Date today = System.today();
      List<Job_Aplication__c>  jobsToUpdate  =  new List <Job_Aplication__c>();
     
     for(Job_Aplication__c job : listOfJobs){
     if (job.Follow_up_date__c != null && job.Follow_up_date__c.addDays(30) < today && job.Status__c != 'Accepted' && job.Status__c != 'Closed' ){
             job.Status__c = 'Closed';
             job.Notes__c = 'Status changed on Closed by automation activity';
             jobsToUpdate.add (job);
     }
     if(!jobsToUpdate.isEmpty()){
         update jobsToUpdate;
     }
            
     }
 }
 }