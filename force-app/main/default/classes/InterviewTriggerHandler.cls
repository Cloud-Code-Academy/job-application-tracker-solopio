public with sharing class InterviewTriggerHandler extends TriggerHandler{

    private List <Interview__c> newInterviewes;
    private Map <Id, Interview__c> newInterviewMap;
    private List <Interview__c> oldInterviewes;
    private Map <Id, Interview__c> oldInterviewMap;

    public InterviewTriggerHandler() {
        this.newInterviewes = (List<Interview__c>) Trigger.new;
        this.newInterviewMap = (Map<Id, Interview__c>) Trigger.newMap;
        this.oldInterviewes = (List<Interview__c>) Trigger.old;
        this.oldInterviewMap = (Map<Id, Interview__c>) Trigger.oldMap;
    }

    public override void afterInsert(){
        for(Interview__c interview : this.newInterviewes){
            if (interview.Job_Aplication__c != null) {
            InterviewHelper.createEvent(this.newInterviewes);
            }
            //Check what day it is
            InterviewHelper.checkIfDataIsSundayOrSatrday(interview);  
        }
    }

    public override void afterUpdate(){
        List<Event>eventsToUdate = new List <Event>();
        Boolean result = false;
        for(Interview__c interview : this.newInterviewes){
            List<Event> existingEvent = [SELECT Id, StartDateTime, EndDateTime, Subject
            FROM Event
            WHERE WhatId = : interview.Job_Aplication__c
            LIMIT 1];
            //Check what day it is.
            InterviewHelper.checkIfDataIsSundayOrSatrday(interview); 
            if (interview.Job_Aplication__c != null) {
                if (!existingEvent.isEmpty()){
                    Event eventToUpdate = existingEvent[0];
                    eventToUpdate.StartDateTime = interview.Date_Of_Interview__c;
                    eventToUpdate.EndDateTime = interview.Date_Of_Interview__c.addHours(2);  
                    eventsToUdate.add(eventToUpdate);
                            //check if there is an overlap
                    result = InterviewHelper.doEventsOverlaping(eventToUpdate, interview);
                }
            }
        }
            if (result == false){
               update eventsToUdate;
            }  
    }
}