@isTest
public with sharing class InterviewTriggerHandlerTest {

    @IsTest
    public static void shouldCreateEventSucesfully(){

        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;

        Id jobAppId = jobApp.Id;
        Test.startTest();
        Interview__c interview = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId);
        insert interview;
        Test.stopTest();
        Assert.isTrue(interview.Id != null, 'Record is not created');

        List<Event> relatedEvents = [SELECT Id, Subject, StartDateTime FROM Event WHERE WhatId  = :jobAppId];
        Assert.areEqual(1, relatedEvents.size(), 'Event should be created');
    } 

    @IsTest
    public static void shouldNotCreateInterwievOnSunday(){

        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;

        Id jobAppId = jobApp.Id;

        Test.startTest();
        Interview__c interview = TestDataFactory.createInterviewObjectOnSunday(jobAppId);
        try {
            insert interview;
        } catch (DmlException e) {
            System.debug(' DML Exception: ' + e.getMessage());
        }
        Test.stopTest();
        Assert.isTrue(interview.Id == null, 'Record is created');

        List<Event> relatedEvents = [SELECT Id, Subject, StartDateTime FROM Event WHERE WhatId  = :jobAppId];
        Assert.areEqual(0, relatedEvents.size(), 'Event should be not created.');
    } 

    @IsTest
    public static void shouldNotCreatedNewInterviewWithSameDateTime(){

        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;

        Id jobAppId = jobApp.Id;

        Job_Aplication__c jobApp1 = TestDataFactory.createJobAplicationObject();
    
        Test.startTest();
        insert jobApp1;

        Id jobAppId1 = jobApp1.Id;

        Interview__c interview = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId);
        insert interview;

        Interview__c interview1 = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId1);
        try {
        insert interview;
        } catch (DmlException e) {
        System.debug(' DML Exception: ' + e.getMessage());
        }
        Test.stopTest();

        Assert.isTrue(interview1.Id == null, 'Record is created');

        List<Event> relatedEvents = [SELECT Id, Subject, StartDateTime FROM Event WHERE WhatId  = :jobAppId];
        Assert.areEqual(1, relatedEvents.size(), 'Event should be created.');
        List<Event> relatedEvents1 = [SELECT Id, Subject, StartDateTime FROM Event WHERE WhatId  = :jobAppId1];
        Assert.areEqual(0, relatedEvents1.size(), 'Event should be not created.');
    }

    @IsTest
    public static void shouldNotUpdateInterviewDateTimeOnWeekend(){ 
        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;

        Id jobAppId = jobApp.Id;
        
        Interview__c interview = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId );
        insert interview;

        DateTime originalDate = interview.Date_Of_Interview__c;

        Test.startTest();
        interview.Date_Of_Interview__c = DateTime.valueOf('2025-05-04 12:00:00');

        try {
             update interview;
         } catch (DmlException e) {
             System.debug(' DML Exception: ' + e.getMessage());
             System.assertEquals(true, e.getMessage().contains('You cannot create an interview on the weekend'), 'There should be the expected mesage');
         }
        Test.stopTest();
        List<Interview__c> interviewToCompare = [SELECT Id, Date_Of_Interview__c FROM Interview__c WHERE Job_Aplication__c = :jobAppId];

        if (!interviewToCompare.isEmpty()) {
        Assert.areEqual(originalDate, interviewToCompare[0].Date_Of_Interview__c, 'Interview date should be the same.');
        } else {
        Assert.fail('No interviews found to compare.');
        }
    }

    @IsTest
    public static void shouldNotInsertInterviewWithTheSameOtherTimeInterwiev(){ 
 
        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;
        Id jobAppId = jobApp.Id;

        Job_Aplication__c jobApp1 = TestDataFactory.createJobAplicationObject();
        insert jobApp1;
        Id jobAppId1 = jobApp1.Id;
        
        Interview__c interview = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId);
        insert interview;
        DateTime firstDate = interview.Date_Of_Interview__c;
        Interview__c interview1 = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId1);
        Test.startTest();
        //interview1.Date_Of_Interview__c = firstDate;

        try {
             insert interview1;
         } catch (DmlException e) {
             System.debug(' DML Exception: ' + e.getMessage());
             System.assertEquals(true, e.getMessage().contains('The new time interval overlaps with an existing event.'), 'There should be the expected mesage');
         }
        Test.stopTest();
    }

    @IsTest
    public static void shouldNotUpdateWhenOtherInterviewExists(){ 
 
        Job_Aplication__c jobApp = TestDataFactory.createJobAplicationObject();
        insert jobApp;
        Id jobAppId = jobApp.Id;

        Job_Aplication__c jobApp1 = TestDataFactory.createJobAplicationObject();
        insert jobApp1;
        Id jobAppId1 = jobApp1.Id;
        
        Interview__c interview = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId);
        insert interview;
        DateTime firstDate = interview.Date_Of_Interview__c;
        Interview__c interview1 = TestDataFactory.createInterviewObjectNotInWeekend(jobAppId1);
        interview1.Date_Of_Interview__c = interview1.Date_Of_Interview__c.addHours(4);
        insert interview1;

        Test.startTest();

        try {
             update interview1;
         } catch (DmlException e) {
             System.debug(' DML Exception: ' + e.getMessage());
             System.assertEquals(true, e.getMessage().contains('The new time interval overlaps with an existing event.'), 'There should be the expected mesage');
         }
        Test.stopTest();
    }
}


