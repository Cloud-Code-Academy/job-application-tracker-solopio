@IsTest
public with sharing class JobAppAutomationStatusForTasksTest {
    @Istest
    public static void checkAutomationTasksForSavedStauts(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Saved',
        Application_Date__c = System.today());
        
        Test.startTest();
        insert job;
        Test.stopTest();

        List<Task> listTasks = [SELECT Id, Subject, Status, Priority, WhatId FROM Task WHERE WhatId =: job.id]; 
        Assert.areEqual(3, listTasks.size(), 'There should be 3 tasks');
    }   
    
    @Istest
    public static void checkAutomationTasksForApplyingStauts(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Saved',
        Application_Date__c = System.today());
        
        Test.startTest();
        insert job;
        job.Status__c = 'Applying';
        update job;
        Test.stopTest();

        List<Task> listTasks = [SELECT Id, Subject, Status, Priority, WhatId FROM Task WHERE WhatId =: job.id]; 
        Assert.areEqual(8, listTasks.size(), 'There should be 8 tasks');
    }  
}