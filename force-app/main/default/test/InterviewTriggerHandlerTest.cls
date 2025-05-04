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
        Interview__c interview = TestDataFactory.createInterviewObjectOnSunday(jobAppId); // UPEWNIJ SIĘ, ŻE TO JEST NIEDZIELA
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
}

