@IsTest
public with sharing class JoobleJSONCalloutTest {
 
    @isTest
    static void testGetJobFromJOOBLE() {
    
    Test.setMock(HttpCalloutMock.class, new JoobleCalloutMock());

    Test.startTest();
    //JoobleJSONCallout callout = new JoobleJSONCallout();
    JoobleJSONCallout.getJobFromJOOBLE();
    Test.stopTest();

    List<Job_Aplication__c> jobApplications = [SELECT Company_Name__c, Job_title__c FROM Job_Aplication__c];
    System.assertEquals(2, jobApplications.size(), 'There should be 2 job applications.');
    System.assertEquals('Company A', jobApplications[0].Company_Name__c, 'Name of a company is incorrect.');
    System.assertEquals('Job Title 1', jobApplications[0].Job_title__c, 'The title is incorrect.');
}
}