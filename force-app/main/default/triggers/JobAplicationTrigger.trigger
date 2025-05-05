trigger JobAplicationTrigger on Job_Aplication__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
        new JobApplicationTriggerHandler().run();
}

