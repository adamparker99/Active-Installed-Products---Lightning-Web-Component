/**
 * @description       : 
 * @author            : Adam Parker
 * @group             : 
 * @last modified on  : 12-16-2020
 * @last modified by  : Adam Parker
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   12-16-2020   Adam Parker   Initial Version
**/
@isTest
public with sharing class SVMX_PS_ActiveInstalledProducts_UT {

    public static testmethod void testClass_UT(){

        // Create Location
        SVMXC__Site__c newLoc = new SVMXC__Site__c();
        insert newLoc;

        // Create IP
        SVMXC__Installed_Product__c newIP = new SVMXC__Installed_Product__c();
        newIP.SVMXC__Site__c = newLoc.Id;
        insert newIP;
        
        // Create WO
        SVMXC__Service_Order__c newWO = new SVMXC__Service_Order__c();
        newWO.SVMXC__Site__c = newLoc.Id;
        insert newWO;

        Test.startTest();

        List<SVMXC__Installed_Product__c> listIPs = SVMX_PS_ActiveInstalledProducts.fetchIP('SVMXC__Site__c', 'ASC', newWO.Id);

        Test.stopTest();

        // Create assert statement to verify results
        System.assertEquals(1, listIPs.size(), 'Error Message: There are more than 1 IPs');

    }

}
    
