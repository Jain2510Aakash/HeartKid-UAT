import { LightningElement,track,api } from 'lwc';
import getRecord from "@salesforce/apex/InterrogationComponent_Ctrl.getRecord";
import updateFieldInfo from "@salesforce/apex/InterrogationComponent_Ctrl.updateRecords";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class InterrogationEditComponent extends LightningElement {
    @track otherSectionShowHide = 'slds-show';
    @track picklistSectionShowHide = false;
    @api isModalOpen = false;
    @track getFieldData = [];
    @track isSaveDsbl = false;
    @api recordId; //= 'a1J5i00002VghDuEAJ';

    connectedCallback()
    {
        //this.handleGetRecordMethod('Lead');
        console.log('is open modal=>'+this.isModalOpen);
        console.log('record Id=>'+this.recordId);
        this.handleGetRecordMethod(this.recordId);
    }
     
     closeModal() {
         // to close modal set isModalOpen tarck value as false
         const event = new CustomEvent("close", {
            detail: false
        });
        this.dispatchEvent(event);

        //this.picklistSectionShowHide = 'slds-hide';
        this.otherSectionShowHide = 'slds-hide';
     }

     handleSubmit()
     {
        //alert('submit btn');
        const inputFields = this.template.querySelectorAll('.validate');
        let isValid = true;

        inputFields.forEach((field) => {
            if (field.required && !field.value) {
              field.setCustomValidity(field.messageWhenValueMissing);
              field.reportValidity();
              isValid = false;
            } else {
              field.setCustomValidity('');
              field.reportValidity();
            }
          });
          //console.log('isvalid value==>',isValid);
          if (isValid)
            {
                this.isSaveDsbl = true;
              let interrogationData = {
                Id: this.getFieldData.Id,
                Label__c: this.getFieldData.Label__c,
                DataType__c: this.getFieldData.DataType__c,
                Pick_Values__c: this.getFieldData.isPicklist || this.getFieldData.isMultiPicklist? this.getFieldData.Pick_Values__c:''
            } ;    
            console.log('interrogation data=>',JSON.stringify(this.getFieldData));
            const listData = [];
            listData.push(interrogationData);
            this.handleUpdateFieldInfo(listData);
            }
        }

     handleGetRecordMethod(recordId)
     {
        getRecord({recordId:recordId})
            .then(result => {
                console.log('result->'+JSON.stringify(result));
                this.getFieldData = JSON.parse(JSON.stringify(result));
                if(this.getFieldData.DataType__c === 'Picklist' || this.getFieldData.DataType__c === 'Picklist (Multi-Select)')
                {
                    this.picklistSectionShowHide = true;
                }
                if(this.getFieldData.DataType__c === 'Picklist')
                {
                    this.getFieldData.isPicklist = true; 
                    this.getFieldData.isMultiPicklist = false; 
                    this.getFieldData.isText = false;
                    this.getFieldData.isNumber = false;
                    this.getFieldData.isCheckbox = false;
                }
                else if(this.getFieldData.DataType__c === 'Picklist (Multi-Select)')
                {
                    this.getFieldData.isMultiPicklist = true; 
                    this.getFieldData.isPicklist = false; 
                    this.getFieldData.isText = false;
                    this.getFieldData.isNumber = false;
                    this.getFieldData.isCheckbox = false;
                }
                else if(this.getFieldData.DataType__c === 'Text')
                {
                    this.getFieldData.isText = true;
                    this.getFieldData.isPicklist = false; 
                    this.getFieldData.isMultiPicklist = false; 
                    this.getFieldData.isNumber = false;
                    this.getFieldData.isCheckbox = false; 
                }
                else if(this.getFieldData.DataType__c === 'Number')
                {
                    this.getFieldData.isNumber = true; 
                    this.getFieldData.isPicklist = false; 
                    this.getFieldData.isMultiPicklist = false; 
                    this.getFieldData.isText = false;
                    this.getFieldData.isCheckbox = false;
                }
                else if(this.getFieldData.DataType__c === 'Checkbox')
                {
                    this.getFieldData.isCheckbox = true;
                    this.getFieldData.isPicklist = false; 
                    this.getFieldData.isMultiPicklist = false; 
                    this.getFieldData.isText = false;
                    this.getFieldData.isNumber = false;
                }
                console.log('get field record=>',JSON.stringify(this.getFieldData));
            })
            .catch(error => {
                // TODO Error handling
                console.log('get field error=>',error);
            });
     }

     handleUpdateFieldInfo(interData)
     {
        updateFieldInfo({interList:interData})
        .then(result => {
            console.log('Result after update field info=>',result);
            if(result)
            {
                let msg = 'Field info updated successfully.';
                this.showSuccessToast(msg);
            }

            this.closeModal();
        })

        .catch(error => {
            // TODO Error handling
            console.log('Error=>',error);
            this.closeModal();
            //let msg = 'Record is not created. Please try again!';
            this.showErrorToast(error.body.message);
        });
     }
     handleInputs(event)
     {
         const name = event.currentTarget.dataset.field;
         console.log('name==>',name,'value==>',event.target.value);
         if(event.currentTarget.dataset.field === 'picklist')
        {
            console.log('picklist value==>',event.target.value);
            this.picklistSectionShowHide = true;
            this.getFieldData.DataType__c = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'multi_picklist')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = true;
            this.getFieldData.DataType__c = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'text')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.getFieldData.DataType__c = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'number')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.getFieldData.DataType__c = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'checkbox')
        {
            console.log('multi picklist value==>',event.target.value);
            this.picklistSectionShowHide = false;
            this.getFieldData.DataType__c = event.target.value;
        }
        else if(event.currentTarget.dataset.field === 'Label__c')
            {
                this.getFieldData[event.currentTarget.dataset.field] = event.target.value;
            }
        else if(event.currentTarget.dataset.field === 'Pick_Values__c')
            {
                this.getFieldData[event.currentTarget.dataset.field] = event.target.value;
            }

        console.log('data Tpe with object=>',JSON.stringify(this.getFieldData));
     }

    showSuccessToast(msg) {
        const event = new ShowToastEvent({
            //title: 'Toast message',
            message: msg,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
  
    showErrorToast(errorMsg) {
        const evt = new ShowToastEvent({
            //title: 'Toast Error',
            message: errorMsg,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}