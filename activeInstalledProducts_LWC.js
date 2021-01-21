import { LightningElement,track,wire,api } from 'lwc';
import fetchIP from '@salesforce/apex/SVMX_PS_ActiveInstalledProducts.fetchIP';
import LOC_FIELD from '@salesforce/schema/SVMXC__Service_Order__c.SVMXC__Site__c';

const dataTablecolumns = [
{
    label : 'Serial/Lot Number',
    fieldName : 'SVMXC__Serial_Lot_Number__c',
    type : 'text',
    sortable : true
},
{
    label : 'Product',
    fieldName : 'SVMXC__Product_Name__c',
    type : 'text',
    sortable : true
},
{
    label : 'Date Installed',
    fieldName : 'SVMXC__Date_Installed__c',
    type : 'text',
    sortable : true
}
]

export default class IPListServerSort extends LightningElement {
  @track results=[];
  @track columns = dataTablecolumns;
  @track sortBy='Name';
  @track sortDirection='asc';
  @api recordId;

  //since we have used the dynamic wiring, 
  //the list is automatically refreshed when the sort direction or order changes.
  @wire(fetchIP,{field : '$sortBy',sortOrder : '$sortDirection', woId : '$recordId'}) IPList({error, data}) {
    if(data)
      this.results=Object.assign([], data);
    if(error)
      console.log(error);
  }
  updateColumnSorting(event){
    let fieldName = event.detail.fieldName;
    let sortDirection = event.detail.sortDirection;
    //assign the values. This will trigger the wire method to reload.
    this.sortBy = fieldName;
    this.sortDirection = sortDirection;
  }
  
}
