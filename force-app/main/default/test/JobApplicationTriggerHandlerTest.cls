@IsTest
public with sharing class JobApplicationTriggerHandlerTest {

    @IsTest
    public static void createJobbApplicationStatusSavedWith3Tasks(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();

        Test.startTest();
        insert job;
        Test.stopTest();

        List<Task> listTasks = [SELECT Id, Subject, Status, Priority, WhatId FROM Task WHERE WhatId =: job.id];

        System.Assert.areEqual(3, listTasks.size(), 'There should be 3 tasks');
    }

    @IsTest
    public static void createJobbApplicationStatusApplying(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';

        Test.startTest();
        update job;
        Test.stopTest();

        List<Task> listTasks = [SELECT Id, Subject, Status, Priority, WhatId FROM Task WHERE WhatId =: job.id];

        System.Assert.areEqual(8, listTasks.size(), 'There should be 3 tasks');
    }

    @IsTest
    public static void canNotUpdateStatusOfApplicationToPrevious(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';
        update job;
        job.Status__c = 'Saved';
        String errorMessage;
        Test.startTest();
        try{
            update job;
        } catch (DmlException e){
            //errorMessage = e.getMessage();
            System.debug(' DML Exception: ' + e.getMessage());
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest(); 
    }

    @IsTest
    public static void canNotUpdateStatusOfApplicationToPreviousFromApplied(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';
        update job;
        job.Status__c = 'Applied';
        update job;
        job.Status__c = 'Saved';
        String errorMessage;
        Test.startTest();
        try{
            update job;
        } catch (DmlException e){
            //errorMessage = e.getMessage();
            System.debug(' DML Exception: ' + e.getMessage());
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest(); 
    }

    @IsTest
    public static void canNotUpdateStatusOfApplicationToPreviousFromNegotiating(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';
        update job;
        job.Status__c = 'Applied';
        update job;
        job.Status__c = 'Interviewing';
        update job;
        job.Status__c = 'Negotiating';
        update job;
        job.Status__c = 'Saved';
        String errorMessage;
        Test.startTest();
        try{
            update job;
        } catch (DmlException e){
            //errorMessage = e.getMessage();
            System.debug(' DML Exception: ' + e.getMessage());
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest(); 
    }

    @IsTest
    public static void canNotUpdateStatusOfApplicationToPreviousFromClosed(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';
        update job;
        job.Status__c = 'Applied';
        update job;
        job.Status__c = 'Interviewing';
        update job;
        job.Status__c = 'Negotiating';
        update job;
        job.Status__c = 'Closed';
        update job;
        job.Status__c = 'Saved';
        String errorMessage;
        Test.startTest();
        try{
            update job;
        } catch (DmlException e){
            //errorMessage = e.getMessage();
            System.debug(' DML Exception: ' + e.getMessage());
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest(); 
    }

    @IsTest
    public static void canNotUpdateStatusOfApplicationToAcceptedFromClosed(){

        Job_Aplication__c job = TestDataFactory.createJobAplicationObject();
        insert job;
        job.Status__c = 'Applying';
        update job;
        job.Status__c = 'Applied';
        update job;
        job.Status__c = 'Interviewing';
        update job;
        job.Status__c = 'Negotiating';
        update job;
        job.Status__c = 'Closed';
        update job;
        job.Status__c = 'Accepted';
        String errorMessage;
        Test.startTest();
        try{
            update job;
        } catch (DmlException e){
            //errorMessage = e.getMessage();
            System.debug(' DML Exception: ' + e.getMessage());
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest(); 
    }

    
}
