({
    startGame : function(component, event, helper) {
         let selectedComponent = component.find('gameMode');
         let selectedValue = selectedComponent.get('v.value');
         let selectedMode = selectedComponent.get('v.selectedMode');
         let boardComponent = component.find("boardComp")
        
        //  alert("select game mode is  "+selectedValue);
         component.set("v.selectedMode",selectedValue);
         console.log("game started with "+selectedValue);
         if(selectedValue){
           boardComponent.startGame();
         }
    },
    reshuffleBoard : function(component, event, helper) {
      let boardComponent = component.find("boardComp");
      boardComponent.reshuffleBoard();
    },
    onResultHandler:function (component, event, helper){
    console.log("onResultHandler called")

       const result = event.getParam('result');
       if(result == "win"){
        component.set("v.reshuffleDisabled",true);
        helper.addResultRecord(component,result)
       }
       else{
        component.set("v.reshuffleDisabled",false);
        helper.addResultRecord(component,result)
       }
    }
})
