trigger InterviewTrigger on Interview__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    new InterviewTriggerHandler().run();
}
