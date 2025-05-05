@isTest
public with sharing class SchedulerOfStaleJobsTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2042';

    @IsTest
    static void testSchuldStatusBeChangedToClosed() {

        List<Job_Aplication__c> jobsList = new List<Job_Aplication__c>();
        Date myDate = Date.newInstance(1960, 2, 17);

        for (Integer i=0; i<10; i++) {
            Job_Aplication__c newJob = new Job_Aplication__c(
                Follow_up_date__c = myDate,
                Job_title__c = 'Salesforce Developer', 
                Status__c = 'Saved',
                Company_Name__c = 'testCVompany' + i             
            );
            jobsList.add(newJob);
        }
        insert jobsList;
        Map<Id, Job_Aplication__c> jobMap = new Map<Id, Job_Aplication__c>(jobsList);
        List<Id> jobsIds = new List<Id>(jobMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new SchedulerOfStaleJobs());
        Test.stopTest();

        List<Job_Aplication__c> lt = [SELECT Id, Status__c
            FROM Job_Aplication__c
            //WHERE WhatId IN :opptyIds];
            WHERE Id IN :jobsIds];

            for(Job_Aplication__c job : lt){
                    System.Assert.areEqual('Closed', job.Status__c, 'Job was not closed');
            }
    }

    @isTest()
    static void testSchuldStatusBeNotChanged() {
        List<Job_Aplication__c> jobsList = new List<Job_Aplication__c>();
        Date testDate = Date.today();
        for (Integer i=0; i<10; i++) {
            Job_Aplication__c newJob = new Job_Aplication__c(
                Follow_up_date__c = testDate,
                Job_Title__c = 'Salesforce Developer', 
                Status__c = 'Saved',
                Company_Name__c = 'testCVompany' + i             
            );
            jobsList.add(newJob);
        }
        insert jobsList;
        Map<Id, Job_Aplication__c> jobMap = new Map<Id, Job_Aplication__c>(jobsList);
        List<Id> jobsIds = new List<Id>(jobMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new SchedulerOfStaleJobs());
        Test.stopTest();
        List<Job_Aplication__c> lt = [SELECT Id, Status__c
            FROM Job_Aplication__c
            WHERE Id IN :jobsIds];

            for(Job_Aplication__c job : lt){
                System.Assert.areEqual('Saved', job.Status__c, 'Status of the job should not change.');
            }     
    }

    @isTest()
    static void testSchuldStatusBeNotChangedWhenAccepted() {
        List<Job_Aplication__c> jobsList = new List<Job_Aplication__c>();
        Date myDate = Date.newInstance(1960, 2, 17);
        for (Integer i=0; i<10; i++) {
            Job_Aplication__c newJob = new Job_Aplication__c(
                Follow_up_date__c = myDate,
                Job_Title__c = 'Salesforce Developer', 
                Status__c = 'Accepted',
                Company_Name__c = 'testCVompany' + i             
            );
            jobsList.add(newJob);
        }
        insert jobsList;
        Map<Id, Job_Aplication__c> jobMap = new Map<Id, Job_Aplication__c>(jobsList);
        List<Id> jobsIds = new List<Id>(jobMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new SchedulerOfStaleJobs());
        Test.stopTest();
        List<Job_Aplication__c> lt = [SELECT Id, Status__c
            FROM Job_Aplication__c
            WHERE Id IN :jobsIds];

            for(Job_Aplication__c job : lt){
                System.Assert.areEqual('Accepted', job.Status__c, 'Status of the job should not change.');
            }     
    }
}