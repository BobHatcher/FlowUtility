
global with sharing class MyUtil{ 
  // This is included in a Class called MyUtil, since in my case there are other utilities in this Class that are used within Apex.

  global Class FlowUtilityRequest{
        @AuraEnabled @InvocableVariable(label='Request Test.IsRunningTest()' description='Requests Test.isRunningTest(). Heavy function, don\'t request it unless necessary.' required=true)
        global Boolean RequestIsRunningTest ;
        @AuraEnabled @InvocableVariable(label='Write to Debug' description='Enter a String here to write a value to the debug log.' required=false)
        global String DebugMsg ;
    }

  @InvocableMethod (label='Flow Apex Utility' description='Returns several variables that are not available in Flow. Send a value in DebugMessage field to write to Debug log.' category='System')
    public static List<List<FlowUtilityResponse>> flowUtility(List<FlowUtilityRequest> requests){
        try {
            Boolean requestIsRunningTest = false;
            if (requests != null && requests?.size() >= 1){
                if (requests[0].requestIsRunningTest != null){
                    requestIsRunningTest = requests[0]?.requestIsRunningTest;
                }
            }
            FlowUtilityResponse response = new FlowUtilityResponse(requestIsRunningTest);
            if (requests[0]?.DebugMsg != null && requests[0]?.DebugMsg != ''){
                System.debug(requests[0].DebugMsg);
            }

            // Instantiate the outer list
            List<List<FlowUtilityResponse>> outerList = new List<List<FlowUtilityResponse>>();
            // Instantiate the inner list
            List<FlowUtilityResponse> innerList = new List<FlowUtilityResponse>();
            
            // Pull the actual information we are trying to send back to the Flow.
            FlowUtilityResponse resultSingleObject = new FlowUtilityResponse(requestIsRunningTest);
            // Then add our one record to the inner list
            innerList.add(resultSingleObject);
            
            // Now add an inner list to the outer list, one for each input.
            // Result is that outer list size is the same size as the request list,
            // And each value on the outer list is a copy of the inner list with a FlowUtilityResponse inside.
            for (Integer x = 0; x < requests.size(); x ++){
                // Add one inner list for each outer list.
                outerList.add(innerList);
            }
            
            return outerList;

        } catch (Exception e){
            // Your error handling
            throw e;
        }
        
    }
}
