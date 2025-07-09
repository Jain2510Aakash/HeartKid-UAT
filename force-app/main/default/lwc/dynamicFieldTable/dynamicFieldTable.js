import { LightningElement,api,track } from 'lwc';
import deleteRecord from "@salesforce/apex/InterrogationComponent_Ctrl.deleteRecord";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class DynamicFieldTable extends LightningElement {
    @api records;
    @track recordData = [];
    // @track _selected = [];

    // get selected() {
    //     return this._selected.length ? this._selected : 'none';
    //   }

    connectedCallback()
    {
        console.log('get field data=>',JSON.stringify(this.records));
    }

    handleInputChange(event)
    {
      console.log('name==>',event.currentTarget.dataset.field,'==Value:',event.detail.value,'Id==>',event.currentTarget.dataset.id);
      if(event.currentTarget.dataset.field === 'picklist')
        {
            //Find index of specific object using findIndex method.    
          const objIndex = this.recordData.findIndex(obj => obj.Id === event.currentTarget.dataset.id);
          console.log('Index=>',objIndex);
          if(objIndex > -1)
            {
              //Update object's name property.
              this.recordData[objIndex].Value__c = event.detail.value;
            }
            else
            {
              this.recordData.push({"Id":event.currentTarget.dataset.id,"Value__c":event.detail.value});
            }
        }
        else if(event.currentTarget.dataset.field === 'multi_picklist')
        {
          //Find index of specific object using findIndex method.
          // this._selected = event.detail.value; 
          // console.log('Selected values',JSON.stringify(this._selected));   
          const objIndex = this.recordData.findIndex(obj => obj.Id === event.currentTarget.dataset.id);
          console.log('Index=>',objIndex);
          if(objIndex > -1)
            {
              //Update object's name property.
              this.recordData[objIndex].Value__c = (event.detail.value).join(';');
            }
            else
            {
              this.recordData.push({"Id":event.currentTarget.dataset.id,"Value__c":(event.detail.value).join(';')});
            }
        }
        else if(event.currentTarget.dataset.field === 'text')
        {
          console.log('Id==>',event.currentTarget.dataset.id)
          //Find index of specific object using findIndex method.    
          const objIndex = this.recordData.findIndex(obj => obj.Id === event.currentTarget.dataset.id);
          console.log('Index=>',objIndex);
          if(objIndex > -1)
            {
              //Update object's name property.
              this.recordData[objIndex].Value__c = event.detail.value;
            }
            else
            {
              this.recordData.push({"Id":event.currentTarget.dataset.id,"Value__c":event.detail.value});
            }
         
        }
        else if(event.currentTarget.dataset.field === 'number')
        {
          //Find index of specific object using findIndex method.    
          const objIndex = this.recordData.findIndex(obj => obj.Id === event.currentTarget.dataset.id);
          console.log('Index=>',objIndex);
          if(objIndex > -1)
            {
              //Update object's name property.
              this.recordData[objIndex].Value__c = event.detail.value;
            }
            else
            {
              this.recordData.push({"Id":event.currentTarget.dataset.id,"Value__c":event.detail.value});
            }
        }
        else if(event.currentTarget.dataset.field === 'checkbox')
        {
          console.log('Checkbox value=>',event.detail.checked);
          //Find index of specific object using findIndex method.    
          const objIndex = this.recordData.findIndex(obj => obj.Id === event.currentTarget.dataset.id);
          console.log('Index=>',objIndex);
          if(objIndex > -1)
            {
              //Update object's name property.
              this.recordData[objIndex].Value__c = event.detail.checked ? 'true':'false';
            }
            else
            {
              this.recordData.push({"Id":event.currentTarget.dataset.id,"Value__c":event.detail.checked ? 'true':'false'});
            }
        }
        console.log('record data=>',JSON.stringify(this.recordData));

        const evnt = new CustomEvent("save", {
            detail: {'recordData':this.recordData}
        });
        this.dispatchEvent(evnt);
        
    }

    handleDeleteRecord(event)
     {
        const recordId = event.currentTarget.dataset.id;
        console.log('recordId=>'+recordId);
        deleteRecord({id:recordId})
            .then(result => {
                let msg;
              if(result === 'Success')
                {
                  msg = 'Record has been deleted.'
                  this.dispatchEvent(new CustomEvent("delete"));
                }
              else
                {
                  msg = 'Record is not deleted. Please try again.'
                }
                this.showSuccessToast(msg);
            })
            .catch(error => {
                // TODO Error handling
                this.showErrorToast(error.body.message);
            });
     }

     handleEditRecord(event)
     {
      const recordId = event.currentTarget.dataset.id;
      console.log('recordId=>'+recordId);
      const evnt = new CustomEvent("edit", {
          detail: {'recordId':recordId,'isModal':true}
      });
      this.dispatchEvent(evnt);
     }

     showSuccessToast(msg) {
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: msg,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
  
    showErrorToast(errorMsg) {
        const evt = new ShowToastEvent({
            title: 'Toast Error',
            message: errorMsg,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}