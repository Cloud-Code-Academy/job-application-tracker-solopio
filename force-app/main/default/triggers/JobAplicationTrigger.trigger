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

    if (Trigger.isAfter && Trigger.isUpdate) {
        //create tasks in JobApplication object
        List<Task> listOfTask = new List<Task>();
        for (Job_Aplication__c job : Trigger.new) {
            String oldStatus = Trigger.oldMap.get(job.Id).Status__c;
            if (job.Status__c != oldStatus && job.Status__c == 'Applying') {
                Task task1 = new Task(Subject = 'Find and research someone who works at the company and add them as a contact', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                Task task2 = new Task(Subject = 'Set up an informational interview to learn more about the role/company', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id);
                Task task3 = new Task(Subject = 'Identify potential referrals to help get your application on the top of the pile', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id);
                Task task4 = new Task(Subject = 'Customize your work achievements using the job description keywords', ActivityDate = System.today() + 3, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                Task task5 = new Task(Subject = 'Submit your application on the company website if possible', ActivityDate = System.today() + 2, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                listOfTask.add(task1);
                listOfTask.add(task2);
                listOfTask.add(task3);
                listOfTask.add(task4);
                listOfTask.add(task5);
            }
        }
        if (!listOfTask.isEmpty()) {
            insert listOfTask;
        }
    }
}
