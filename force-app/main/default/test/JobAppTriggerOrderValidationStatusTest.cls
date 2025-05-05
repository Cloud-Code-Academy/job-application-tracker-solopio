@isTest
public with sharing class JobAppTriggerOrderValidationStatusTest {

    @isTest
    private static void checkHappyPath(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Saved',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Applied';
        update job;
        job.Status__c = 'Interviewing';
        update job;
        job.Status__c = 'Negotiating';
        update job;
        job.Status__c = 'Accepted';
        update job;
        Test.stopTest();

        Assert.areEqual('Accepted', job.Status__c, 'Expected job.Status__c is Accepted');
    }

    @isTest
    private static void checkValidationForApplyingStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Applying',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Saved';
        //update job;
        try {
            update job;
            // If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            // 4. Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }

    @isTest
    private static void checkValidationForAppliedStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Applied',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Applying';
        try {
            update job;
            //If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            //Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }

    @isTest
    private static void checkValidationForInterviewingStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Interviewing',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Applied';
        try {
            update job;
            //If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            //Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }

    @isTest
    private static void checkValidationForNegotiatingStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Negotiating',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Interviewing';
        try {
            update job;
            //If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            //Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }

    @isTest
    private static void checkValidationForAcceptedStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Accepted',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Negotiating';
        try {
            update job;
            //If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            //Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }

    @isTest
    private static void checkValidationForClosedStatus(){

        Job_Aplication__c job = new Job_Aplication__c(Job_title__c = 'Salesforce Developer', Company_Name__c = 'testCVompany', Status__c ='Closed',
        Application_Date__c = System.today());
        insert job;

        Test.startTest();
        job.Status__c = 'Accepted';
        try {
            update job;
            //If no exception is thrown, this means the validation rule didn't work.
            System.assert(false, 'Expected a DML exception due to validation rule.');
        } catch (DmlException e) {
            //Assert that a DmlException is thrown and contains the expected error message.
            System.assertEquals(true, e.getMessage().contains('You can not change the status to the previous one'), 'There should be the expected mesage');
        }
        Test.stopTest();
    }
}