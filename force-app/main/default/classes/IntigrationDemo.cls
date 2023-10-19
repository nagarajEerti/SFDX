global class IntigrationDemo {
    
    global static void callApi(){
        try{
            system.debug('GET API call method');
            Http http = new Http();
            HttpRequest request =new  HttpRequest();
            request.setEndpoint('https://jsonplaceholder.typicode.com/posts');
            request.setHeader('x-hamlet-sessiontoken','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGVObyI6Ijg5MTkzNDU0ODUiLCJjbGllbnRJZCI6IjYwYjc1Y2UzMDkxZjM0NjA4NDE3MWI2ZiIsInVzZXJUeXBlIjoiYWRtaW4iLCJ1c2VySWQiOiI2M2VmMzc2MDViZjJiM2Y4NzFkYTVlZDYiLCJ1c2VybmFtZSI6Ik5ldyBVc2VyIiwicHJvZmlsZVBpYyI6IiIsImlhdCI6MTY4NzUwMDE2NiwiZXhwIjoxNjg4MzY0MTY2fQ.t3eMrJv65JVzqCefkUY8JvhmfmxePp9Jv2wF-hwquIY');
            request.setHeader('x-hamlet-api-key','abc123');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
                System.debug(response.getBody());
                // Parse the response JSON into an instance of ApiRespons
                 Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(response.tostring());
                System.debug(params);
            }
            else{
                System.debug(response.toString());
               
            }
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
        
    }
    public static void msg(){
        
    }
}