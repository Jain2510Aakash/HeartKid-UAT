import { LightningElement,api,track } from 'lwc';
import getImageUrl from "@salesforce/apex/CreateDiagram_Cls.getImageUrl";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class ViewAllObjectData extends LightningElement {
@api modal;
@api allObjectData;
@api allObjectScoreData;
@track leadObjectData ;
@track accountObjectData;
@track opportunityObjectData;
@track diagramBody = {};
@track spinner = true;
@track imageUrl;
@track isImageURLBtn = true;
@track eraserUrl;
@track imageMsg;
@track eraserUrlHide = 'slds-hide';
@track imageMsgHide = 'slds-hide';
@track apiFormattedData = '';

    connectedCallback()
    {
     console.log('is modal open=>',this.modal);
     console.log('all object score data=>',JSON.stringify(this.allObjectScoreData));
     if(this.allObjectScoreData)
     {
        this.apiFormattedData = this.allObjectScoreData.Lead_Business_Process__c;
        this.apiFormattedData += this.allObjectScoreData.Account_Business_Process__c;
        this.apiFormattedData += this.allObjectScoreData.Contact_Business_Process__c;
        this.apiFormattedData += this.allObjectScoreData.Opportunity_Business_Process__c;
     }
     console.log('api formated data:',this.apiFormattedData);
     
        // this.handleAllObjectData();
        if(this.apiFormattedData.length>0)
        {
            this.handleImageUrlMethod(this.apiFormattedData);
        }
    }

    handleAllObjectData()
    {
        if(this.allObjectData.length >0)
        {
            this.diagramBody.scoreData = this.allObjectScoreData;
            this.allObjectData.forEach(item=>{
                if(item.leadData)
                {
                    this.leadObjectData = item.leadData;
                    this.diagramBody.leadData = item.leadData;
                    console.log('lead data=>',this.leadObjectData);
                    this.apiFormattedData = 'Prospective client come into the company via the following lead sources:';
                    let leadSource = this.leadObjectData.leadSource.map(row => row.Key);
                    if(leadSource.length > 2)
                    {
                        let lastElement = leadSource.pop();
                        this.apiFormattedData += leadSource.join(', ') + ', and '+lastElement;
                    }
                    else if(leadSource.length === 2 )
                    {
                        let lastElement = leadSource.pop()
                        this.apiFormattedData += leadSource.join(', ') + ', and '+lastElement;
                    }
                    else
                    {
                        this.apiFormattedData += leadSource.join(',');
                    }

                    this.apiFormattedData += '. The company also has a third party integration from ';
                    this.apiFormattedData += this.leadObjectData.progress +' which sends leads into Salesforce.';

                    this.apiFormattedData +='The lead process services ';
                    this.apiFormattedData += this.leadObjectData.bsprocesses +' distinct business processes. Each of which has a different business process diagram.';

                    this.apiFormattedData +='Leads are then converted into Opportunities, Accounts and Contacts.';
                        
                    }
                if(item.accountData)
                {
                    this.accountObjectData = item.accountData;
                    this.diagramBody.accountData = item.accountData;
                    console.log('account data=>',this.accountObjectData);

                    if(this.accountObjectData.recordTypes.length >0)
                    {
                        this.apiFormattedData += 'Accounts is an object and are created from both the lead conversion and manual creation. Accounts are broken down into a the following types: ';
                        let recordType = this.accountObjectData.recordTypes.map(row => row.value);
                        if(recordType.length > 2)
                        {
                            let lastElement = recordType.pop();
                            this.apiFormattedData += recordType.join(', ') + ', and '+lastElement;
                        }
                        else if(recordType.length === 2 )
                        {
                            let lastElement = recordType.pop()
                            this.apiFormattedData += recordType.join(', ') + ', and '+lastElement;
                        }
                        else
                        {
                            this.apiFormattedData += recordType.join(',');
                        }
                    }

                    this.apiFormattedData +='. '+this.accountObjectData.accountHierarchies+'.';
                    this.apiFormattedData +=' The contact sits below the account object.';
                }
                if(item.opportunityData)
                {
                    this.opportunityObjectData = item.opportunityData;
                    this.diagramBody.opportunityData = item.opportunityData;
                    console.log('account data=>',this.opportunityObjectData);

                    this.apiFormattedData += 'When ideal clients are found their potential value is created as an opportunity object, and they follow the pipeline in the following order:';
                    let stages = this.opportunityObjectData.stages.map(row => row.value); 
                    if(stages.length > 2)
                    {
                        let lastElement = stages.pop();
                        this.apiFormattedData += stages.join(', ') + ', and '+lastElement;
                    }
                    else if(stages.length === 2 )
                    {
                        let lastElement = stages.pop()
                        this.apiFormattedData += stages.join(', ') + ', and '+lastElement;
                    }
                    else
                    {
                        this.apiFormattedData += stages.join(',');
                    }

                    if(this.opportunityObjectData.recordType.length >0)
                    {
                        this.apiFormattedData += 'Here are the different types of opportunities that exist: ';
                        let recordType = this.opportunityObjectData.recordType.map(row => row.value);
                        if(recordType.length > 2)
                        {
                            let lastElement = recordType.pop();
                            this.apiFormattedData += recordType.join(', ') + ', and '+lastElement;
                        }
                        else if(recordType.length === 2 )
                        {
                            let lastElement = recordType.pop()
                            this.apiFormattedData += recordType.join(', ') + ', and '+lastElement;
                        }
                        else
                        {
                            this.apiFormattedData += recordType.join(',');
                        }
                    }

                    if(this.opportunityObjectData.relatedObject.length >0)
                    {
                        this.apiFormattedData += 'The opportunity object is also connected to the following objects, ';
                        let relatedObject = this.opportunityObjectData.recordType.map(row => row.value);
                        if(relatedObject.length > 2)
                        {
                            let lastElement = relatedObject.pop();
                            this.apiFormattedData += relatedObject.join(', ') + ', and '+lastElement;
                        }
                        else if(relatedObject.length === 2 )
                        {
                            let lastElement = relatedObject.pop()
                            this.apiFormattedData += relatedObject.join(', ') + ', and '+lastElement;
                        }
                        else
                        {
                            this.apiFormattedData += relatedObject.join(',');
                        }
                    }
                }
            });
            console.log('diagram body=>',JSON.stringify(this.diagramBody));
            console.log('api formatted data=>',this.apiFormattedData);
            //const formattedString = JSON.stringify(this.diagramBody).replace(/['"]+/g, '')
            this.handleImageUrlMethod(this.apiFormattedData);
        }
    } 

  handleImageUrlMethod(body)
  {
    //this.spinner = true;
    getImageUrl({body:body})
        .then(result => {
            this.spinner = false;
            console.log('image Success',JSON.parse(result));
            let data = JSON.parse(result);
            console.log('image data=>',data);
            if(data.Message === 'Success')
            {
                this.eraserUrlHide = 'slds-show';
                this.imageMsgHide = 'slds-hide';
                this.eraserUrl = data.EraserUrl;
                this.imageUrl = data.ImageURL;
                this.diagramBody.imageUrl = this.imageUrl;
                this.diagramBody.eraserUrl = this.eraserUrl;
                this.isImageURLBtn = false;
                console.log('after adding image url in diagram body=>',JSON.stringify(this.diagramBody));
                let msg = 'Diagram is created successfully. Please see by click on button.';
                this.showSuccessToast(msg);
            }
            else if(data.Message === 'Error')
            {
                this.imageMsgHide = 'slds-show';
                this.eraserUrlHide = 'slds-hide';
                this.imageMsg = data.Status + '! Please try again after 30 second.';
                let erormsg = 'Something went wrong! Please try after 30 second.';
                this.showErrorToast(erormsg);
            }
        })
        .catch(error => {
            this.spinner = false;
            this.isImageURLBtn = true;
            // TODO Error handling
            console.log('image error',error);
            this.showErrorToast(error);
        });

  }

  openImageUrl()
  {
    window.open(this.imageUrl, '_blank');
  }

  handlePDF()
  {
    window.open('/apex/CompanyFormAsPDF?allObjectdata='+JSON.stringify(this.diagramBody), '_blank');
  } 

    hideModalBox() {  
        //this.isShowModal = false;
        this.apiFormattedData = '';
        const event = new CustomEvent("close", {
            detail: false
        });
        this.dispatchEvent(event);
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