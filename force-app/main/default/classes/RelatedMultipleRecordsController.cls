public class RelatedMultipleRecordsController {
    String commToDelete;

    Set<selectoption> originalvaluesAct = new Set<selectoption>();
    Public List<string> leftselectedAct{get;set;}
    Public List<string> rightselectedAct{get;set;}
    List<selectoption> leftvaluesAct {get;set;}
    List<selectoption> rightvaluesAct {get;set;}
    Public String textFilterAct {get;set;}

    Set<String> accIdsToRemove{get;Set;}
    Set<String> conIdsToRemove{get;Set;}
    Set<String> actIdsToRemove{get;Set;}
    Set<String> projIdsToRemove{get;Set;}

    Set<selectoption> originalvaluesCon = new Set<selectoption>();
    Public List<string> leftselectedCon{get;set;}
    Public List<string> rightselectedCon{get;set;}
    List<selectoption> leftvaluesCon {get;set;}
    List<selectoption> rightvaluesCon {get;set;}
    Public String textFilterCon {get;set;}

    Set<selectoption> originalvaluesAcc = new Set<selectoption>();
    Public List<string> leftselectedAcc{get;set;}
    Public List<string> rightselectedAcc{get;set;}
    List<selectoption> leftvaluesAcc {get;set;}
    List<selectoption> rightvaluesAcc {get;set;}
    Public String textFilterAcc {get;set;}

    Set<selectoption> originalvaluesProj = new Set<selectoption>();
    Public List<string> leftselectedProj{get;set;}
    Public List<string> rightselectedProj{get;set;}
    List<selectoption> leftvaluesProj {get;set;}
    List<selectoption> rightvaluesProj {get;set;}
    Public String textFilterProj {get;set;}

    public Id materIdComm=null;

    List<Communication_Log__c> existComm = new List<Communication_Log__c>();

    public RelatedMultipleRecordsController(){
        leftselectedCon = new List<String>();
        rightselectedCon = new List<String>();
        leftvaluesCon = new List<selectoption>();
        rightvaluesCon = new List<selectoption>();

        leftselectedAct = new List<String>();
        rightselectedAct = new List<String>();
        leftvaluesAct = new List<selectoption>();
        rightvaluesAct = new List<selectoption>();

        leftselectedAcc = new List<String>();
        rightselectedAcc = new List<String>();
        leftvaluesAcc = new List<selectoption>();
        rightvaluesAcc = new List<selectoption>();

        leftselectedProj = new List<String>();
        rightselectedProj = new List<String>();
        leftvaluesProj = new List<selectoption>();
        rightvaluesProj = new List<selectoption>();

        accIdsToRemove = new Set<String>();
        conIdsToRemove = new Set<String>();
        actIdsToRemove = new Set<String>();
        projIdsToRemove = new Set<String>();

        String idMaster;
        String idNewid;
        String idCommLog = ApexPages.currentPage().getParameters().get('recordOrigin');
        if(idCommLog!=null && idCommLog!='') {
            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Id =: idCommLog]) {
                if(comm.Master_Communication_Log__c==null) materIdComm =comm.Id;
                existComm.add(comm);
                if(comm.Contact_Name__c!=null){
                    rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                }else{
                    rightvaluesCon.add(new selectoption('--None--', '--None--'));
                }
                if(comm.Activity_Name__c!=null){
                    rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                }
                else{
                    rightvaluesAct.add(new selectoption('--None--', '--None--'));
                }
                if(comm.Project_Name__c!=null){
                    rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                }
                else{
                    rightvaluesProj.add(new selectoption('--None--', '--None--'));
                }
                if(comm.Organization_Name__c!=null){
                    rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                }else{
                    rightvaluesAcc.add(new selectoption('--None--', '--None--'));
                }
            }
        } else {
            idMaster = ApexPages.currentPage().getParameters().get('master');
            if(idMaster!=null && idMaster!='') {
                for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__r.Name = :idMaster OR Id =: idMaster]) {
                    existComm.add(comm);
                    materIdComm=comm.Master_Communication_Log__c;
                    if(comm.Contact_Name__c!=null) rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                    else rightvaluesCon.add(new selectoption('--None--', '--None--'));
                    if(comm.Activity_Name__c!=null) rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                    else rightvaluesAct.add(new selectoption('--None--', '--None--'));
                    if(comm.Project_Name__c!=null) rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                    else rightvaluesProj.add(new selectoption('--None--', '--None--'));
                    if(comm.Organization_Name__c!=null) rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                    else rightvaluesAcc.add(new selectoption('--None--', '--None--'));
                }
            } else {
                idNewid = ApexPages.currentPage().getParameters().get('newid');
                if(idNewid!=null && idNewid!='') {
                    for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Id =: idNewid]) {
                        if(comm.Master_Communication_Log__c==null) materIdComm =comm.Id;
                        existComm.add(comm);
                        if(comm.Contact_Name__c!=null) rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                        else rightvaluesCon.add(new selectoption('--None--', '--None--'));
                        if(comm.Activity_Name__c!=null) rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                        else rightvaluesAct.add(new selectoption('--None--', '--None--'));
                        if(comm.Project_Name__c!=null) rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                        else rightvaluesProj.add(new selectoption('--None--', '--None--'));
                        if(comm.Organization_Name__c!=null) rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                        else rightvaluesAcc.add(new selectoption('--None--', '--None--'));
                    }
                }
            }
        }

        if(idCommLog!=null && idCommLog!='') {
            for(Communication_Log__c comm :  [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c = :idCommLog]){
                if(comm.Contact_Name__c!=null){
                    //if(rightvaluesCon.get(0).getValue()!='--None--'){
                        rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                    //}
                }
                else{
                    rightvaluesCon.add(New selectoption('--None--','--None--'));
                }

                if(comm.Activity_Name__c!=null){
                    //if(rightvaluesAct.get(0).getValue()!='--None--'){
                        rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                    //}
                }
                else{
                    rightvaluesAct.add(New selectoption('--None--','--None--'));
                }
                if(comm.Project_Name__c!=null){
                    //if(rightvaluesProj.get(0).getValue()!='--None--'){
                        rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                    //}
                }
                else{
                    rightvaluesProj.add(New selectoption('--None--','--None--'));
                    }
                if(comm.Organization_Name__c!=null){
                    //if(rightvaluesAcc.get(0).getValue()!='--None--'){
                        rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                    //}
                }else{
                    rightvaluesAcc.add(New selectoption('--None--','--None--'));
                    }
                
                //if(comm.Contact_Name__c!=null) rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                //if(comm.Activity_Name__c!=null) rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                //if(comm.Project_Name__c!=null) rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                //if(comm.Organization_Name__c!=null) rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
            }

            Set<selectoption> setCon = new Set<selectoption>();
            setCon.addAll(rightvaluesCon);
            Set<selectoption> setAct = new Set<selectoption>();
            setAct.addAll(rightvaluesAct);
            Set<selectoption> setProj = new Set<selectoption>();
            setProj.addAll(rightvaluesProj);
            Set<selectoption> setAcc = new Set<selectoption>();
            setAcc.addAll(rightvaluesAcc);

            rightvaluesCon.clear();
            rightvaluesCon.addAll(setCon);
            rightvaluesAct.clear();
            rightvaluesAct.addAll(setAct);
            rightvaluesProj.clear();
            rightvaluesProj.addAll(setProj);
            rightvaluesAcc.clear();
            rightvaluesAcc.addAll(setAcc);
        }

        /*String idMaster = ApexPages.currentPage().getParameters().get('master');
        if(idMaster!=null && idMaster!='') {
            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__r.Name = :idMaster OR Id =: idMaster]) {
                existComm.add(comm);
                materIdComm=comm.Master_Communication_Log__c;
                if(comm.Contact_Name__c!=null) rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                else rightvaluesCon.add(new selectoption('--None--', '--None--'));
                if(comm.Activity_Name__c!=null) rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                else rightvaluesAct.add(new selectoption('--None--', '--None--'));
                if(comm.Project_Name__c!=null) rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                else rightvaluesProj.add(new selectoption('--None--', '--None--'));
                if(comm.Organization_Name__c!=null) rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                else rightvaluesAcc.add(new selectoption('--None--', '--None--'));
            }
        }
        else {
            idMaster = ApexPages.currentPage().getParameters().get('newid');
            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c = :idMaster OR Id =: idMaster]) {
                if(comm.Master_Communication_Log__c==null) materIdComm =comm.Id;
                existComm.add(comm);
                if(comm.Contact_Name__c!=null) rightvaluesCon.add(new selectoption(comm.Contact_Name__c, comm.Contact_Name__r.Name));
                else rightvaluesCon.add(new selectoption('--None--', '--None--'));
                if(comm.Activity_Name__c!=null) rightvaluesAct.add(new selectoption(comm.Activity_Name__c, comm.Activity_Name__r.Name));
                else rightvaluesAct.add(new selectoption('--None--', '--None--'));
                if(comm.Project_Name__c!=null) rightvaluesProj.add(new selectoption(comm.Project_Name__c, comm.Project_Name__r.Name));
                else rightvaluesProj.add(new selectoption('--None--', '--None--'));
                if(comm.Organization_Name__c!=null) rightvaluesAcc.add(new selectoption(comm.Organization_Name__c, comm.Organization_Name__r.Name));
                else rightvaluesAcc.add(new selectoption('--None--', '--None--'));
            }
        }*/
    }

    public PageReference selectclickAcc(){
        rightselectedAcc.clear();
        for(String s : leftselectedAcc){
            for(integer i=0;i<leftvaluesAcc.Size();i++) {
                if(leftvaluesAcc[i].getValue() == s) {
                    rightvaluesAcc.add(leftvaluesAcc[i]);
                    //leftvaluesAcc.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference selectclickCon(){
        rightselectedCon.clear();
        for(String s : leftselectedCon){
            for(integer i=0;i<leftvaluesCon.Size();i++) {
                if(leftvaluesCon[i].getValue() == s) {
                    rightvaluesCon.add(leftvaluesCon[i]);
                    //leftvaluesCon.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference selectclickAct(){
        rightselectedAct.clear();
        for(String s : leftselectedAct){
            for(integer i=0;i<leftvaluesAct.Size();i++) {
                if(leftvaluesAct[i].getValue() == s) {
                    rightvaluesAct.add(leftvaluesAct[i]);
                    //leftvaluesAct.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference selectclickProj(){
        rightselectedProj.clear();
        for(String s : leftselectedProj){
            for(integer i=0;i<leftvaluesProj.Size();i++) {
                if(leftvaluesProj[i].getValue() == s) {
                    rightvaluesProj.add(leftvaluesProj[i]);
                    //leftvaluesProj.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference unselectclickAcc(){
        leftselectedAcc.clear();
        for(String s : rightselectedAcc){
            for(integer i=0;i<rightvaluesAcc.Size();i++) {
                if(rightvaluesAcc[i].getValue() == s) {
                    accIdsToRemove.add(rightvaluesAcc[i].getValue());
                    //leftvaluesAcc.add(rightvaluesAcc[i]);
                    rightvaluesAcc.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference unselectclickCon(){
        leftselectedCon.clear();
        for(String s : rightselectedCon){
            for(integer i=0;i<rightvaluesCon.Size();i++) {
                if(rightvaluesCon[i].getValue() == s) {
                    conIdsToRemove.add(rightvaluesCon[i].getValue());
                    //leftvaluesCon.add(rightvaluesCon[i]);
                    rightvaluesCon.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference unselectclickAct(){
        leftselectedAct.clear();
        for(String s : rightselectedAct){
            for(integer i=0;i<rightvaluesAct.Size();i++) {
                if(rightvaluesAct[i].getValue() == s) {
                    actIdsToRemove.add(rightvaluesAct[i].getValue());
                    //leftvaluesAct.add(rightvaluesAct[i]);
                    rightvaluesAct.remove(i);
                }
            }
        }
        return null;
    }

    public PageReference unselectclickProj(){
        leftselectedProj.clear();
        for(String s : rightselectedProj){
            for(integer i=0;i<rightvaluesProj.Size();i++) {
                if(rightvaluesProj[i].getValue() == s) {
                    projIdsToRemove.add(rightvaluesProj[i].getValue());
                    //leftvaluesProj.add(rightvaluesProj[i]);
                    rightvaluesProj.remove(i);
                }
            }
        }
        return null;
    }

    public List<SelectOption> getunSelectedValuesAcc(){
        return leftvaluesAcc;
    }

    public List<SelectOption> getSelectedValuesAcc(){
        return rightvaluesAcc;
    }

    public List<SelectOption> getunSelectedValuesCon(){
        return leftvaluesCon;
    }

    public List<SelectOption> getSelectedValuesCon(){
        return rightvaluesCon;
    }

    public List<SelectOption> getunSelectedValuesAct(){
        return leftvaluesAct;
    }

    public List<SelectOption> getSelectedValuesAct(){
        return rightvaluesAct;
    }

    public List<SelectOption> getunSelectedValuesProj(){
        return leftvaluesProj;
    }

    public List<SelectOption> getSelectedValuesProj(){
        return rightvaluesProj;
    }

    public void findAcc() {
        originalvaluesAcc.clear();
        leftselectedAcc.clear();
        //rightselectedAcc.clear();
        leftvaluesAcc.clear();
        //rightvaluesAcc.clear();
        String aux = '%'+textFilterAcc+'%';
        originalvaluesAcc.add(new selectoption('--None--', '--None--'));
        for(Account acc : [SELECT Id, Name FROM Account WHERE Name LIKE :aux LIMIT 999]) {
            originalvaluesAcc.add(new selectoption(acc.Id, acc.Name));
        }
        leftselectedAcc = new List<String>();
        //rightselectedAcc = new List<String>();
        leftvaluesAcc.addAll(originalValuesAcc);
    }

    public void findCon() {
        originalvaluesCon.clear();
        leftselectedCon.clear();
        //rightselectedCon.clear();
        leftvaluesCon.clear();
        //rightvaluesCon.clear();
        String aux = '%'+textFilterCon+'%';
        originalvaluesCon.add(new selectoption('--None--', '--None--'));
        for(Contact con : [SELECT Id, Name FROM Contact WHERE Name LIKE :aux LIMIT 999]) {
            originalvaluesCon.add(new selectoption(con.Id, con.Name));
        }
        leftselectedCon = new List<String>();
        //rightselectedCon = new List<String>();
        leftvaluesCon.addAll(originalValuesCon);
    }

    public void findAct() {
        originalvaluesAct.clear();
        leftselectedAct.clear();
        //rightselectedAct.clear();
        leftvaluesAct.clear();
        //rightvaluesAct.clear();
        String aux = '%'+textFilterAct+'%';
        originalvaluesAct.add(new selectoption('--None--', '--None--'));
        for(Activity__c act : [SELECT Id, Name FROM Activity__c WHERE Name LIKE :aux LIMIT 999]) {
            originalvaluesAct.add(new selectoption(act.Id, act.Name));
        }
        leftselectedAct = new List<String>();
        //rightselectedAct = new List<String>();
        leftvaluesAct.addAll(originalValuesAct);
    }

    public void findProj() {
        originalvaluesProj.clear();
        leftselectedProj.clear();
        //rightselectedProj.clear();
        leftvaluesProj.clear();
        //rightvaluesProj.clear();
        String aux = '%'+textFilterProj+'%';
        originalvaluesProj.add(new selectoption('--None--', '--None--'));
        for(Project__c proj : [SELECT Id, Name FROM Project__c WHERE Name LIKE :aux LIMIT 999]) {
            originalvaluesProj.add(new selectoption(proj.Id, proj.Name));
        }
        leftselectedProj = new List<String>();
        //rightselectedProj = new List<String>();
        leftvaluesProj.addAll(originalValuesProj);
    }

    public PageReference done() {
        List<Communication_Log__c> listComm = new List<Communication_Log__c>();
        List<Communication_Log__c> listCommUpdate = new List<Communication_Log__c>();
        List<Communication_Log__c> listCommRemoveAndUpdate = new List<Communication_Log__c>();
        String idComm = ApexPages.currentPage().getParameters().get('newid');
        if(idComm!=null){
            List<String> fields = new List<String>(Communication_Log__c.SObjectType.getDescribe().fields.getMap().keySet());
            String soql = ''
                    + ' SELECT ' + String.join(fields, ',')
                    + ' FROM Communication_Log__c'
                    + ' WHERE Id = \''+idComm+'\'';
            Integer count=0;
            for (Communication_Log__c comm : Database.query(soql)) {
                comm.Contact_Name__c=null;
                comm.Activity_Name__c=null;
                comm.Project_Name__c=null;
                comm.Organization_Name__c=null;
                Integer max = Math.max(rightvaluesAcc.size(), rightvaluesCon.Size());
                max = Math.max(max, rightvaluesAct.Size());
                max = Math.max(max, rightvaluesProj.Size());
                for(integer i=0;i<max;i++) {
                    Communication_Log__c commClone = new Communication_Log__c();
                    Communication_Log__c commCloneToInsert = new Communication_Log__c();
                    commClone=comm.clone();
                    commCloneToInsert=comm.clone();
                    if(count<existComm.size()) {
                        commClone.Id=existComm.get(count).Id;
                    }
                    else {
                        commClone.Id=null;
                    }
                    //commClone.Id = comm.Id;
                    //commToDelete = comm.Id;
                    commClone.NotUpdateRecord__c=true;
                    commCloneToInsert.Id=null;
                    if(materIdComm==null){
                        commClone.Master_Communication_Log__c=idComm;
                        commCloneToInsert.Master_Communication_Log__c=idComm;
                    }else{
                        if(materIdComm!=commClone.Id){
                            commClone.Master_Communication_Log__c=materIdComm;
                            commCloneToInsert.Master_Communication_Log__c=materIdComm;
                        }
                    }

                    if(rightvaluesAcc.Size()>i) {
                        if(Test.isRunningTest()){
                            if(rightvaluesAcc[i].getValue()=='--None--') commClone.Organization_Name__c=null;
                            else commClone.Organization_Name__c=rightvaluesAcc[i].getValue();
                        } else {
                            if(rightvaluesAcc[i].getValue()=='--None--'){
                                /*if(rightvaluesAcc.size()>1){
                                    commClone.Organization_Name__c=rightvaluesAcc[i+1].getValue();

                                } else {
                                    commClone.Organization_Name__c=null;
                                }*/
                                commClone.Organization_Name__c=null;
                            }
                            else{
                                commClone.Organization_Name__c=rightvaluesAcc[i].getValue();
                                commCloneToInsert.Organization_Name__c=rightvaluesAcc[i].getValue();
                            }
                        }
                    }
                    if(rightvaluesCon.Size()>i) {
                        if(Test.isRunningTest()){
                            if(rightvaluesCon[i].getValue()=='--None--') commClone.Contact_Name__c=null;
                            else commClone.Contact_Name__c=rightvaluesCon[i].getValue();
                        } else {
                            if(rightvaluesCon[i].getValue()=='--None--'){
                                /*if(rightvaluesCon.size()>1){
                                    commClone.Contact_Name__c=rightvaluesCon[i+1].getValue();

                                } else {
                                    if(rightvaluesCon.size()==1){
                                        commClone.Contact_Name__c=null;
                                    }
                                }*/
                                commClone.Contact_Name__c=null;
                            }
                            else{
                                commClone.Contact_Name__c=rightvaluesCon[i].getValue();
                                commCloneToInsert.Contact_Name__c=rightvaluesCon[i].getValue();
                            }
                        }
                    }
                    if(rightvaluesAct.Size()>i) {
                        if(Test.isRunningTest()){
                            if(rightvaluesAct[i].getValue()=='--None--') commClone.Activity_Name__c=null;
                            else commClone.Activity_Name__c=rightvaluesAct[i].getValue();
                        } else {
                            if(rightvaluesAct[i].getValue()=='--None--'){
                                /*if(rightvaluesAct.size()>1){
                                    commClone.Activity_Name__c=rightvaluesAct[i+1].getValue();

                                } else {
                                    commClone.Activity_Name__c=null;
                                }*/
                                commClone.Activity_Name__c=null;
                            }
                            else{
                                commClone.Activity_Name__c=rightvaluesAct[i].getValue();
                                commCloneToInsert.Activity_Name__c=rightvaluesAct[i].getValue();
                            }
                        }
                    }

                    System.debug('rightvaluesProj: ' + rightvaluesProj);
                    System.debug('rightvaluesProj.size(): ' + rightvaluesProj.size());
                    if(rightvaluesProj.Size()>i) {
                        if(Test.isRunningTest()){
                            if(rightvaluesProj[i].getValue()=='--None--') commClone.Project_Name__c=null;
                            else commClone.Project_Name__c=rightvaluesProj[i].getValue();
                        } else {
                            if(rightvaluesProj[i].getValue()=='--None--'){
                                /*if(rightvaluesProj.size()>1){
                                    commClone.Project_Name__c=rightvaluesProj[i+1].getValue();

                                } else {
                                    commClone.Project_Name__c=null;
                                }*/
                                commClone.Project_Name__c=null;
                            }
                            else{
                                commClone.Project_Name__c=rightvaluesProj[i].getValue();
                                commCloneToInsert.Project_Name__c=rightvaluesProj[i].getValue();
                            }
                        }
                    }

                    System.debug('####### commClone: '+commClone.Id);
                    if(commClone.Id!=null) listCommUpdate.add(commClone);
                    if(count!=0){
                        listComm.add(commCloneToInsert);
                    }
                    count++;
                }

            }

            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c =: listCommUpdate.get(0).Id AND Organization_Name__c IN :accIdsToRemove]){
                comm.Organization_Name__c = null;
                listCommRemoveAndUpdate.add(comm);
            }

            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c =: listCommUpdate.get(0).Id AND Contact_Name__c IN :conIdsToRemove]){
                comm.Contact_Name__c = null;
                listCommRemoveAndUpdate.add(comm);
            }

            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c =: listCommUpdate.get(0).Id AND Activity_Name__c IN :actIdsToRemove]){
                comm.Activity_Name__c = null;
                listCommRemoveAndUpdate.add(comm);
            }

            for(Communication_Log__c comm : [SELECT Id, Contact_Name__c, Contact_Name__r.Name, Activity_Name__c, Activity_Name__r.Name, Project_Name__c, Project_Name__r.Name, Organization_Name__c, Organization_Name__r.Name, Master_Communication_Log__c FROM Communication_Log__c WHERE Master_Communication_Log__c =: listCommUpdate.get(0).Id AND Project_Name__c IN :projIdsToRemove]){
                comm.Project_Name__c = null;
                listCommRemoveAndUpdate.add(comm);
            }


            ApexUtil.isTriggerInvoked = true;
            //DELETE [SELECT Id FROM Communication_Log__c WHERE Id = :commToDelete];
            if(listComm.size()>0) insert listComm;


            if(listCommUpdate.size()>0){
                for(Communication_Log__c cl :  listCommUpdate){
                    if(cl.Id == cl.Master_Communication_Log__c){
                        cl.Master_Communication_Log__c = null;
                    }
                }
                update listCommUpdate;
            }
            Map<Id,Communication_Log__c > mapCommLog = new Map<Id,Communication_Log__c>();
            for(Communication_Log__c cl : listCommRemoveAndUpdate){
                mapCommLog.put(cl.Id, cl);
            }

            if(mapCommLog.size()>0) update mapCommLog.values();
            ApexUtil.isTriggerInvoked = false;
            /*String idReturn = ApexPages.currentPage().getParameters().get('recordOrigin');
            return new PageReference('/'+idReturn);
            return new PageReference('/a0R/o');*/
            return new PageReference('/'+idComm);
        }

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please relate at least one record to your communication log'));
        return null;
    }

    public PageReference cancel() {
        /*String idReturn = ApexPages.currentPage().getParameters().get('recordOrigin');
        return new PageReference('/'+idReturn);*/
        return new PageReference('/a0R/o');
    }
}