({
    blockClickHandler : function(component, event, helper) {
          let open = component.get("v.open");
          let label = component.get("v.label");
          console.log(label,"label.................")
          if(!open){
            component.set("v.open",true);
            //fire the event 
            let compEvent = component.getEvent("onClick");
            compEvent.setParams({value:label});
            compEvent.fire();
          }
    },
    scriptsLoaded : function(component, event, helper) {
      let divElement = component.getElement(".board-block") ;
      fitText(divElement);
         
    }
})
