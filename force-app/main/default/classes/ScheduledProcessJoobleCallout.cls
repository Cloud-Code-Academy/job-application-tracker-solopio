public with sharing class ScheduledProcessJoobleCallout implements Schedulable{

    public void execute(SchedulableContext ctx) {

        JoobleJSONCallout.getJobFromJOOBLE();
    }
    
}