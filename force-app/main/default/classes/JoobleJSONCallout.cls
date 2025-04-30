public with sharing class JoobleJSONCallout {
   
    public  void getJobFromJOOBLE() {
		// Create HTTP request to send.               
		HttpRequest req = new HttpRequest();

        req.setEndpoint('https://jooble.org/api/'+'8448854a-717f-4293-8657-1b1e2e4e3868');
		// Set the HTTP method to GET.
		req.setMethod('POST');
		//tu rzeczy właściwe do metody POST
		req.setHeader('Content-Type', 'application/json;charset=UTF-8');
		req.setBody('{"location" : "Miami, Florida",  "keywords" : "Apothecarie"}');
		// Send the HTTP request and get the response.
		Http http = new Http();
		HTTPResponse res = http.send(req);
		res.getStatus();
		res.getStatusCode();
		String jsonResponse = res.getBody();
		// If the HTTP response code is successful, parse the JSON response and update the Job_Aplication__c.
	    // If the status code is 200, the request was successful
		List <Job_Aplication__c> listOfAPP = new List <Job_Aplication__c>();
		if (res.getStatusCode() == 200) {
            listOfAPP = createJobAppFromJson(jsonResponse);
			//insert/update from the JSON response using the external id (dummyUserId)
			insert listOfAPP; 
            //upsert job Job_Aplication_c__c; 
        } else {
            // If the status code is not 200, something went wrong with the request
            System.debug('HTTP request failed. Status code: ' + res.getStatusCode());
            System.debug('Response body: ' + res.getBody());
        }
	}

    @TestVisible
	private static List <Job_Aplication__c> createJobAppFromJson(String jsonResponse) {

		List <Job_Aplication__c> liostOfJObs = new List<Job_Aplication__c>();
		Map<String, Object> parsedResponse = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);

//https://www.youtube.com/watch?v=subi8zaSQ9g

		List<Object> jobs = (List<Object>) parsedResponse.get('jobs');
		for(Object job: jobs) {
			Map<String, Object> jobMap = (Map<String, Object>) job;
		Job_Aplication__c aplication = new  Job_Aplication__c();
		// Set the contact fields from the JSON response.
        aplication.Company_Name__c = (String)jobMap.get('company');
        //aplication.Job_title__c = (String)parsedResponse.get('title');jobMap.get
		aplication.Job_title__c = (String)jobMap.get('title');
		aplication.Jooble_Application__c = String.valueOf(jobMap.get('id')); 
        //job.Job_Aplication_c__c = (Integer)(parsedResponse.get('id')); 
		aplication.Salary__c = (Integer)jobMap.get('Salary');
		aplication.Status__c = 'Saved';
		aplication.Location__c = (String) jobMap.get('location');
		aplication.URL__c = (String) jobMap.get('link');
		//aplication.Notes__c = (String) jobMap.get('snippet');
		liostOfJObs.add(aplication);
		}
		return liostOfJObs;
	    }

	}