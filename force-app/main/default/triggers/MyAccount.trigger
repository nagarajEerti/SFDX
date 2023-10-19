trigger MyAccount on Account (before insert) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            // system.debug('hiiii nani');
 }
    }
}

/*
trigger MyAccount on Account (after insert,after update,after delete,after undelete) {
  switch on Trigger.operationType{
    when AFTER_INSERT {
     system.debug('hiii swami ');
       
    }
    when AFTER_UPDATE {
    
     }
  }
}
*/