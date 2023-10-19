({
    addResultRecord : function(component,gameResult) {

        const action = component.get("c.addResult");
        const mode = component.get("v.selectedMode").toUpperCase();

        action.setParams({
            result:gameResult,
            mode:mode
        })
        //set callback
        action.setCallback( this,function (response) {
            const state = response.getState()
            if(state !== 'SUCCESS'){
                console.error("ERROR while saving record");
            }
        })
        $A.enqueueAction(action);
    }
})
