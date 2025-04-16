trigger JobAplicationTrigger on Job_Aplication__c (before update, after update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Job_Aplication__c job : Trigger.new){
            if(job.Status__c != null){
                String oldStatus = Trigger.oldMap.get(job.Id).Status__c;
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
                } else if((oldStatus == 'Accepted') && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied'
                || job.Status__c == 'Interviewing' || job.Status__c == 'Negotiating' || job.Status__c == 'Closed')){
                    job.addError('You can not change the status to the previous one');
                } else if((oldStatus == 'Closed') && (job.Status__c == 'Applying' || job.Status__c == 'Saved' || job.Status__c == 'Applied'
                || job.Status__c == 'Interviewing' || job.Status__c == 'Negotiating' || job.Status__c == 'Accepted')){
                    job.addError('You can not change the status to the previous one');
                }    
            }
        }
    }    
}