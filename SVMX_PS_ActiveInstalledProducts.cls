/**
 * @description       : 
 * @author            : Adam Parker
 * @group             : 
 * @last modified on  : 12-16-2020
 * @last modified by  : Adam Parker
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   12-08-2020   Adam Parker   Initial Version
**/
public with sharing class SVMX_PS_ActiveInstalledProducts {

    @AuraEnabled (Cacheable=true)
    public static List<SVMXC__Installed_Product__c> fetchIP(String field, String sortOrder, String woId){

        Id locId = [SELECT SVMXC__Site__c FROM SVMXC__Service_Order__c WHERE Id =: woId].SVMXC__Site__c;

        return Database.query('SELECT Id, Name, SVMXC__Product_Name__c, SVMXC__Serial_Lot_Number__c, SVMXC__Date_Installed__c, 	SVMXC__Company__r.Name FROM SVMXC__Installed_Product__c WHERE SVMXC__Site__c = :locId AND SVMXC__Status__c = \'Installed\' ORDER BY '+field+' '+sortOrder);
    
    }
}
