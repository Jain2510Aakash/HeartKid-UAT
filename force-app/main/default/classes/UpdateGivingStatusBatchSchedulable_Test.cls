/* 
* Created By:   {Girikon(Sahil Khan)}
* Created On:   Aug 21, 2024
* Description/Purpose:  Test class for UpdateGivingStatusBatch and UpdateGivingStatusBatchSchedulable clases.
*
* Modification log --
*/
@isTest
public with sharing class UpdateGivingStatusBatchSchedulable_Test 
{
    @testSetup
    static void makeData()
    {
        List<Contact> conList = new List<Contact>();
        for(Integer i = 1; i <= 6; i++)
        {
            Contact con = new Contact();
            con.LastName = 'Donor Test ' + i;
            con.npo02__LastCloseDate__c = System.today().addYears(-i);
            conList.add(con);
        }
        for(Integer i = 1; i <= 6; i++)
        {
            Contact con = new Contact();
            con.LastName = 'Soft Donor Test ' + i;
            con.npsp__Last_Soft_Credit_Date__c = System.today().addYears(-i);
            conList.add(con);
        }
        Contact con1 = new Contact();
        con1.LastName = 'Test All 1';
        con1.npsp__Last_Soft_Credit_Date__c = System.today().addYears(-2);
        con1.npo02__LastCloseDate__c = System.today().addYears(-1);
        conList.add(con1);
        Contact con2 = new Contact();
        con2.LastName = 'Test All 2';
        con2.npsp__Last_Soft_Credit_Date__c = System.today().addYears(-1);
        con2.npo02__LastCloseDate__c = System.today().addYears(-2);
        conList.add(con2);
        INSERT conList;
    }
    @isTest
    static void executeTest()
    {
        Test.startTest();
        UpdateGivingStatusBatchSchedulable sObj = new UpdateGivingStatusBatchSchedulable();
        sObj.execute(null);
        Contact con = [SELECT Id, Giving_Status__c, npo02__LastCloseDate__c FROM Contact LIMIT 1];
        // System.assert(con.Giving_Status__c != null);
        Test.stopTest();
    }
}