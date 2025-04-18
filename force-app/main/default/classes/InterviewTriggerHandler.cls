public with sharing class InterviewTriggerHandler extends TriggerHandler {

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
                Event event = new Event(StartDateTime = interview.Date_Of_Interview__c, EndDateTime = interview.Date_Of_Interview__c.addHours(2),
                WhatId = interview.Job_Aplication__c, Subject = 'Interview '+ interview.Name);
            insert event;
            }
        }
    }

    public override void afterUpdate(){
        for(Interview__c interview : this.newInterviewes){
            if (interview.Job_Aplication__c != null) {
                // Query for the existing Event related to this Job Application
                List<Event> existingEvents = [SELECT Id, StartDateTime, EndDateTime, Subject
                                              FROM Event
                                              WHERE WhatId = :interview.Job_Aplication__c
                                              LIMIT 1];
    
                if (!existingEvents.isEmpty()) {
                    Event eventToUpdate = existingEvents[0];
                    eventToUpdate.StartDateTime = interview.Date_Of_Interview__c;
                    eventToUpdate.EndDateTime = interview.Date_Of_Interview__c.addHours(2);
                    eventToUpdate.Subject = 'Interview ' + interview.Name;
                    update eventToUpdate;
                } 
            }
        }
    }
}
    
