public with sharing class JobApplicationTriggerHandler extends TriggerHandler {

    private List <Job_Aplication__c> newJobAplications;
    private Map <Id, Job_Aplication__c> newJobAplicationMap;
    private List <Job_Aplication__c> oldJobAplications;
    private Map <Id, Job_Aplication__c> oldJobAplicationMap;

    public JobApplicationTriggerHandler() {
        this.newJobAplications = (List<Job_Aplication__c>) Trigger.new;
        this.newJobAplicationMap = (Map<Id, Job_Aplication__c>) Trigger.newMap;
        this.oldJobAplications = (List<Job_Aplication__c>) Trigger.old;
        this.oldJobAplicationMap = (Map<Id, Job_Aplication__c>) Trigger.oldMap;
    }

    public override void afterInsert(){
        //List<Task> listOfTask = new List<Task>();
        for (Job_Aplication__c job : this.newJobAplications) {
            if (job.Status__c == 'Saved') {      
                //JobAplicationHelper.crateTasksForStatusSaved(this.newJobAplications);          
            } 
        }   
    }

    public override void beforeUpdate(){
        for(Job_Aplication__c job : this.newJobAplications){
            if(job.Status__c != null){
                String oldStatus = this.oldJobAplicationMap.get(job.Id).Status__c;
                if((oldStatus == 'Applying' || oldStatus == 'Applied' || oldStatus == 'Interviewing' || oldStatus == 'Negotiating' || oldStatus == 'Accepted'
                || oldStatus == 'Closed') && job.Status__c == 'Saved'){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Applied' || oldStatus == 'Interviewing' || oldStatus == 'Negotiating' || oldStatus == 'Accepted'
                || oldStatus == 'Closed') && (job.Status__c == 'Applying' || job.Status__c == 'Saved')){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Interviewing' || oldStatus == 'Negotiating' || oldStatus == 'Accepted'
                || oldStatus == 'Closed') && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied')){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Negotiating' || oldStatus == 'Accepted'|| oldStatus == 'Closed') && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied'
                || job.Status__c == 'Interviewing')){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Accepted'|| oldStatus == 'Closed' ) && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied'
                || job.Status__c == 'Interviewing' || job.Status__c == 'Negotiating')){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Closed') && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied'
                || job.Status__c == 'Interviewing' || job.Status__c == 'Negotiating' || job.Status__c == 'Accepted')){
                    job.addError('You can not change the status to the previous one');
                }    
            }
        }
    }

    // public override void afterUpdate(){
    //     List<Task> listOfTask = new List<Task>();
    //     for (Job_Aplication__c job : this.newJobAplications) {
    //         String oldStatus = this.oldJobAplicationMap.get(job.Id).Status__c;
    //         if (job.Status__c != oldStatus && job.Status__c == 'Applying') {
    //             JobAplicationHelper.crateTasksForStatusApplying(this.newJobAplications);
    //         }else if(job.Status__c != oldStatus && job.Status__c == 'Applied'){
    //             JobAplicationHelper.crateTasksForStatusApplied(this.newJobAplications);
    //         }else if(job.Status__c != oldStatus && job.Status__c == 'Interviewing'){
    //             JobAplicationHelper.crateTasksForStatusInterviewing(this.newJobAplications);
    //         }else if(job.Status__c != oldStatus && job.Status__c == 'Negotiating'){
    //             JobAplicationHelper.crateTasksForStatusNegotiating(this.newJobAplications);
    //         }else if(job.Status__c != oldStatus && job.Status__c == 'Accepted'){
    //             JobAplicationHelper.crateTasksForStatusAccepted(this.newJobAplications);
    //         }else if(job.Status__c != oldStatus && job.Status__c == 'Closed'){
    //             JobAplicationHelper.crateTasksForStatusClosed(this.newJobAplications);
    //         }
    //     }
    // }
}