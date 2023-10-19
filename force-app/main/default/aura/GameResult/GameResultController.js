({
    doInit : function(component, event, helper) {
           const columns = [
            { label:"Game Number" ,fieldName:"name",type:"text"},
            {label:"mode" ,fieldName:"gameMode__c",type:"text"},
            {label:"Played On" ,fieldName:"createdDate",type:"date"},
            {label:"Result" ,fieldName:"gameResult__c",type:"text"}
           ]
           component.set("v.columns",columns);

           helper.fetchResults(component);
    },
    onResultHandler:function(component, event, helper){
               helper.fetchResults(component);
    }
})
