({
    doInit : function(component, event, helper) {

        let gameMode = component.get('v.mode');
       

        console.log(gameMode +" is ur new game mode ")
          let colum = 0;
          if(gameMode && gameMode == "Hard"){
              colum = 6;
          }else if (gameMode == "Medium"){
              colum = 4;
        
          }
          else{
            colum=3;
          }
    
          let blockWidth= 12/colum;
          component.set("v.blockSize",blockWidth);
        
          
         
          let gameArray = helper.getWords(colum * colum)
          console.log("GAME WORDS:"+gameArray)
          component.set("v.words",gameArray);


          let winWord = helper.getWinWord(gameArray); 
          component.set("v.winWord",winWord);
          console.log("WIN WORD:"+winWord)
          helper.resetGame(component);
          
    },
    doRender : function(component, event, helper) {
           console.log("render")
    },
    blockClickHandler: function(component, event, helper) {
      console.log("block click handler")
        let value = event.getParam("value");
        let winWord = component.get("v.winWord");
        let clickCount = component.get("v.clickCount") + 1;
         if(value === winWord){ 
            //user won
            component.set("v.result", "you won the game")
            component.set("v.boardDisable",true)
            // helper.boardDisable(component)
            console.log("v.result", "you won the game")
            helper.fireResultEvent("win")
         }
         else if(clickCount === 3 ){
            // user lose
            component.set("v.result", "you lose")
            component.set("v.boardDisable",true)
            console.log(component.get("v.boardDisable") + "---------------hi")
            // helper.boardDisable(component)
           console.log("v.result", "you lose the game")
           helper.fireResultEvent("lose");
         } 
         component.set("v.clickCount",clickCount)
         
 },
 reshuffleBoard:function(component ,event,helper){
    const words = component.get("v.words");
    const randomize = helper.randomizeArray(words);
    component.set("v.words",randomize);

    helper.resetGame()
 }
})
