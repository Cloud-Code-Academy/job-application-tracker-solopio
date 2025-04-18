trigger InterviewTrigger on interview__c (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        for(interview__c interview : Trigger.new){
          
            if (interview.Job_Aplication__c != null) {
                //DateTime newDateTime = interview.DateOfInterview__c.addHours(3);
                Event event = new Event(StartDateTime = interview.Date_Of_Interview__c, EndDateTime = interview.Date_Of_Interview__c.addHours(2),
                WhatId = interview.Job_Aplication__c, Subject = 'Interview '+ interview.Name);
            insert event;
            }
        }
    }
}
