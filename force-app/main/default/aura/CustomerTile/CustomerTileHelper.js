({
    sendSobjectEvent : function(recId, sobject) 
    {
        var selectEvt = $A.get("e.ltng:selectSObject"); 
        
        selectEvt.setParams({
            "recordId": recId, 
            "channel": sobject 
        }); 
        
        selectEvt.fire(); 
    },
    
    // IGNORE ME FOR NOW
    sendMuteEvent : function(recId)
    {
        var mutes = new Set();
        mutes.add(recId);
        console.log('mutes set: ', mutes);
        var action = $A.get("e.c:muteTiles");
        
        action.setParams({
            "muteArray" : mutes,
            "channel": "reservationManager"
        });
        
        action.fire(); 
    }
})