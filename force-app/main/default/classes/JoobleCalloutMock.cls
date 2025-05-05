@isTest
global class JoobleCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        
        HTTPResponse res = new HTTPResponse();
        res.setStatus('OK');
        res.setStatusCode(200);

        String jsonResponse =
            '{"jobs": [' +
            '{"company": "Company A", "title": "Job Title 1", "id": "123", "Salary": 75000, "location": "Miami, Florida", "link": "https://example.com/job1", "snippet": "Job description 1"},' +
            '{"company": "Company B", "title": "Job Title 2", "id": "456", "Salary": 90000, "location": "Miami, Florida", "link": "https://example.com/job2", "snippet": "Job description 2"}' +
            ']}';
        res.setBody(jsonResponse);
        return res;
    }
}