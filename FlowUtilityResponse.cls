// Use at your own risk. No warranty or liability expressed or implied.

global with sharing class FlowUtilityResponse {
    @AuraEnabled @InvocableVariable (label='Org Name' description='The org name derived from the base URL.' required=false)
    global String OrgName ;
    @AuraEnabled  @InvocableVariable (label='Org Type' description='The org type: Developer Edition, Developer, Developer Pro, Partial Copy, Full Copy, Production' required=false)
    global String OrgType;
    @AuraEnabled  @InvocableVariable (label='Is Running Test' description='Boolean, reflecting Test.isRunningTest()')
    global Boolean IsRunningTest ;
    global Boolean IsProduction ;
    @AuraEnabled  @InvocableVariable (label='Is Success' description='Indicates if this object is populated properly. For use identifying the populated one in Loops.' required=false)
    global Boolean IsSuccess ;
    global FlowUtilityResponse(){
        this(false);
    }
    global FlowUtilityResponse (Boolean pullIsRunningTest) {
        try{ 
            OrgName = TMUtil.getOrgName();
            OrgType = TMUtil.getOrgType();
            if (pullIsRunningTest) {
                IsRunningTest = Test.IsRunningTest();
            }
            IsSuccess=true;
        } catch (Exception e){
			    // Your error handling here
            IsSuccess = false;
            throw e;
        }
    }
    
}
