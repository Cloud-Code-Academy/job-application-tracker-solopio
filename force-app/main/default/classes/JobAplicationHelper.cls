public with sharing class JobAplicationHelper {

    public static void crateTasksForStatusSaved(List <Job_Aplication__c> jobs){
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
                Task task1 = new Task(Subject = 'Check if the job description aligns with your interests and values', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                Task task2 = new Task(Subject = 'Review the highlighted skills to see if the role is a good fit', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id);
                Task task3 = new Task(Subject = 'Research the company or role and mark your excitement level', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id);
                listOfTask.add(task1);
                listOfTask.add(task2);
                listOfTask.add(task3);
               }
                if (!listOfTask.isEmpty()) {
                    insert listOfTask;
        }                  
    } 
    
    public static void crateTasksForStatusApplying(List <Job_Aplication__c> jobs){
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
                Task task1 = new Task(Subject = 'Find and research someone who works at the company and add them as a contact', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                Task task2 = new Task(Subject = 'Set up an informational interview to learn more about the role/company', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id);
                Task task3 = new Task(Subject = 'Identify potential referrals to help get your application on the top of the pile', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id);
                Task task4 = new Task(Subject = 'Customize your work achievements using the job description keywords', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id);
                Task task5 = new Task(Subject = 'Submit your application on the company website if possible', ActivityDate = System.today() + 2, Priority = 'High', Status = 'Not Started', WhatId = job.Id);
                listOfTask.add(task1);
                listOfTask.add(task2);
                listOfTask.add(task3);
                listOfTask.add(task4);
                listOfTask.add(task5);
               }if (!listOfTask.isEmpty()) {
                insert listOfTask;
        }                  
    }  
    public static void crateTasksForStatusApplied(List <Job_Aplication__c> jobs){  
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
            Task task1 = new Task(Subject = 'Reach out to the hiring manager or recruiter', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task2 = new Task(Subject = 'Follow up on your application via email weekly', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task3 = new Task(Subject = 'Continue identifying and saving similar job opportunities', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task4 = new Task(Subject = 'Set up weekly networking calls to explore similar companies/roles', ActivityDate = System.today() + 3, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
        
            listOfTask.add(task1);
            listOfTask.add(task2);
            listOfTask.add(task3);
            listOfTask.add(task4);
            }if (!listOfTask.isEmpty()) {
            insert listOfTask;
            }           
    }    
    
    public static void crateTasksForStatusInterviewing(List <Job_Aplication__c> jobs){  
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
                Task task1 = new Task(Subject = 'Prepare your blurb or “tell me about yourself” response', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
                Task task2 = new Task(Subject = 'Practice answering behavioral interview questions', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
                Task task3 = new Task(Subject = 'Research the company and your interviewers', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
                Task task4 = new Task(Subject = 'Set up your virtual interview space and test your tech', ActivityDate = System.today() + 3, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
                Task task5 = new Task(Subject = 'Send thank you emails within 24 hours', ActivityDate = System.today() + 1, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
                listOfTask.add(task1);
                listOfTask.add(task2);
                listOfTask.add(task3);
                listOfTask.add(task4);
                listOfTask.add(task5);
            
        }if (!listOfTask.isEmpty()) {
        insert listOfTask;
        }           
    }    
    
    public static void crateTasksForStatusNegotiating(List <Job_Aplication__c> jobs){  
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
            Task task1 = new Task(Subject = 'Research your market value and know your numbers', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task2 = new Task(Subject = 'Prepare your negotiation scripts', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task3 = new Task(Subject = 'Evaluate your offer and decline or accept', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            
            listOfTask.add(task1);
            listOfTask.add(task2);
            listOfTask.add(task3);
            
        }if (!listOfTask.isEmpty()) {
        insert listOfTask;
        }           
    }   
    
    public static void crateTasksForStatusAccepted(List <Job_Aplication__c> jobs){  
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
            Task task1 = new Task(Subject = 'Take some time to relax and recharge', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task2 = new Task(Subject = 'Plan your resignation if applicable', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task3 = new Task(Subject = 'Prepare for your first day of onboarding', ActivityDate = System.today() + 5, Priority = 'Normal', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
    
            listOfTask.add(task1);
            listOfTask.add(task2);
            listOfTask.add(task3);
            
        }if (!listOfTask.isEmpty()) {
        insert listOfTask;
        }           
    }  
    
    public static void crateTasksForStatusClosed(List <Job_Aplication__c> jobs){  
        List<Task> listOfTask = new List<Task>();
        for(Job_Aplication__c job: jobs){
            Task task1 = new Task(Subject = 'Send a follow-up email thanking the interviewer and asking for feedback', ActivityDate = System.today() + 5, Priority = 'High', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
            Task task2 = new Task(Subject = 'Review your notes and reflect on areas of improvement', ActivityDate = System.today() + 5, Priority = 'Low', Status = 'Not Started', WhatId = job.Id, OwnerId = job.OwnerId);
    
            listOfTask.add(task1);
            listOfTask.add(task2);
            
        }if (!listOfTask.isEmpty()) {
        insert listOfTask;
        }           
    } 
    } 