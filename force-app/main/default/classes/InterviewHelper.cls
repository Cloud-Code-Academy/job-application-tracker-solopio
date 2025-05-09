public with sharing class InterviewHelper {

    public static void createEvent(List <Interview__c> listOfinterwiev){
        List<Event> eventsToInsert = new List<Event>();
        for(Interview__c interview : listOfinterwiev){
            Event event = new Event(StartDateTime = interview.Date_Of_Interview__c,
                                    EndDateTime = interview.Date_Of_Interview__c.addHours(2),
                                    WhatId = interview.Job_Aplication__c,
                                    Subject = 'Interview '+ interview.Name);
    
            // Pass the interview record to the doEventsOverlaping method
            if (!doEventsOverlaping(event, interview)) {
                eventsToInsert.add(event);
            }
        }
    
        // Insert the events only after checking all interviews for overlaps
        if (!eventsToInsert.isEmpty()) {
            try {
                insert eventsToInsert;
            } catch (DmlException e) {
                // Handle any errors during event insertion if needed
                System.debug('Error inserting events: ' + e.getMessage());    
              }
        }
    }
    
    public static Boolean doEventsOverlaping(Event newEvent, Interview__c interviewRecord){
        List<Event> overlappingEvents = [SELECT Id, StartDateTime, EndDateTime
                                            FROM Event
                                            WHERE EndDateTime > :newEvent.StartDateTime
                                            AND StartDateTime < :newEvent.EndDateTime];
        Boolean isOverlap = false;
    
        for (Event existingEvent : overlappingEvents) {
            if (doesItOverlap(existingEvent.StartDateTime, existingEvent.EndDateTime, newEvent.StartDateTime, newEvent.EndDateTime)) {
                isOverlap = true;
                break;
            }
        }
    
        if (isOverlap) {
            System.debug('The new time interval overlaps with an existing event.');
            interviewRecord.addError('The new time interval overlaps with an existing event.');
            return true;
        } else {
            System.debug('The new time interval does not overlap with any existing event.');
            return false;
        }
    }
    
    public static Boolean doesItOverlap(DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
        return start1 < end2 && end1 > start2;
    }

       public static void checkIfDataIsSundayOrSatrday(Interview__c interview){
        Datetime dt = (DateTime)interview.Date_Of_Interview__c;
        String dayOfWeek = dt.format('EEEE');
        if (dayOfWeek == 'Sunday' || dayOfWeek == 'Saturday'){
            interview.addError('You cannot create an interview on the weekend');    
    }
    }

    public static void remindOwnerOfTomorrowInterviews(List<Interview__c> interviews) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Set<Id> ownerIds = new Set<Id>();
        for(Interview__c interview : interviews){
            if (interview.Job_Aplication__c != null) {
                ownerIds.add(interview.Job_Aplication__r.OwnerId); // Access the OwnerId via the relationship
            }
        }
        Map<Id, User> ownersEmailMap = new Map<Id, User>([SELECT Id, Email FROM User WHERE Id IN :ownerIds]);
        for (Interview__c interview : interviews){
            if (interview.Job_Aplication__c != null && ownersEmailMap.containsKey(interview.Job_Aplication__r.OwnerId)) {
                User owner = ownersEmailMap.get(interview.Job_Aplication__r.OwnerId);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {owner.Email};
                mail.setToAddresses(toAddresses);
                mail.setSubject('You have an Interview Tomorrow: ' + interview.Name);
                mail.setPlainTextBody('Your Job Interview: ' + interview.Name +' is tomorrow at '+ interview.Date_Of_Interview__c+'.');
                mails.add(mail);
            }
        }
    
        try {
            Messaging.sendEmail(mails);
        } catch (Exception e){
            System.debug('Exception: ' + e.getMessage());
        }
    }

}