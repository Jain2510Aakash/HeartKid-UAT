import { LightningElement,api, track } from 'lwc';
import getImageUrl from "@salesforce/apex/CreateDiagram_Cls.getImageUrl";
import updateDiagramBody from "@salesforce/apex/ExtractDataCls.updateDiagramBody";
import getDiagramBody from "@salesforce/apex/ExtractDataCls.getDiagramBody";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class ViewLeadComponent extends LightningElement {
    @api modal=false;
    @api leadMergeFieldOption;
    @api viewLeadData;
    @api viewAccountData;
    @api viewContactData;
    @api viewOpportunityData;
    @track isLeadSection = false;
    @track isAccountSection = false;
    @track isOpportunitySection = false;
    @track leadSource = [];
    @track isSpinner = false;
    @track eraserUrl;
    @track imageUrl;
    @track imageMsg;
    @track isImageURLBtn = true;
    @track eraserUrlHide = 'slds-hide';
    @track imageMsgHide = 'slds-hide';
    @track diagramBody = '';
    @track accTriggers;
    @track accDuplicateRules;
    @track contTriggers;
    @track contDuplicateRules;
    @track recordTypeData = [];
    @track leadDuplicateRules;
    @track leadTriggers;
    @track leadValidation;
    @track accValidation;
    @track contValidation;
    @track oppTriggers;
    @track oppValidation;
    @track isCreateDiagramBtnDsbl = false;

    connectedCallback()
    {
        this.isLeadSection = this.viewLeadData ? true:false;
        this.isAccountSection =this.viewAccountData ? true:false;
        this.isContactSection = this.viewContactData ? true:false;
        this.isOpportunitySection =this.viewOpportunityData ? true:false;
        this.handleGetDiagramBody();
        console.log('viewleadData',JSON.stringify(this.viewLeadData));
        console.log('viewAccountData',JSON.stringify(this.viewAccountData));
         console.log('viewContactData',JSON.stringify(this.viewContactData));
         console.log('viewOpportunityData',JSON.stringify(this.viewOpportunityData));
        // console.log('merge field data',JSON.stringify(this.leadMergeFieldOption));
        // console.log('status==>',this.viewLeadData.staticFieldValue.leadSource);
        //For Lead
        if(this.viewLeadData && this.viewLeadData.staticFieldValue)
        {
            let count = 0;
            for(let key in this.viewLeadData.staticFieldValue.leadSource) 
            {
                if (Object.hasOwn(this.viewLeadData.staticFieldValue.leadSource, key)) 
                {
                count++
                this.leadSource.push({index:count,Key:key,value:this.viewLeadData.staticFieldValue.leadSource[key]});
                }
            }
        }
        if(this.viewLeadData && this.viewLeadData.staticFieldValue && this.viewLeadData.staticFieldValue.duplicateRulesList)
        {
            this.leadDuplicateRules = this.viewLeadData.staticFieldValue.duplicateRulesList.length;
        }
        if(this.viewLeadData && this.viewLeadData.staticFieldValue && this.viewLeadData.staticFieldValue.isTriggers)
        {
            this.leadTriggers = this.viewLeadData.staticFieldValue.isTriggers.length;
        }
        if(this.viewLeadData && this.viewLeadData.staticFieldValue && this.viewLeadData.staticFieldValue.flowList)
        {
            this.leadTriggers += this.viewLeadData.staticFieldValue.flowList.length;
        }
        if(this.viewLeadData && this.viewLeadData.staticFieldValue && this.viewLeadData.staticFieldValue.validationRule)
        {
            this.leadValidation = this.viewLeadData.staticFieldValue.validationRule.length;
        }
        //For Account
        if(this.viewAccountData && this.viewAccountData.staticFieldValue && this.viewAccountData.staticFieldValue.duplicateRulesList)
        {
            this.accDuplicateRules = this.viewAccountData.staticFieldValue.duplicateRulesList.length;
        }
        if(this.viewAccountData && this.viewAccountData.staticFieldValue && this.viewAccountData.staticFieldValue.triggersList)
        {
            this.accTriggers = this.viewAccountData.staticFieldValue.triggersList.length;
        }
        if(this.viewAccountData && this.viewAccountData.staticFieldValue && this.viewAccountData.staticFieldValue.flowList)
        {
            this.accTriggers += this.viewAccountData.staticFieldValue.flowList.length;
        }
        if(this.viewAccountData && this.viewAccountData.staticFieldValue && this.viewAccountData.staticFieldValue.validationRule)
        {
            this.accValidation = this.viewAccountData.staticFieldValue.validationRule.length;
        }
        //For Contact
        if(this.viewContactData && this.viewContactData.staticFieldValue && this.viewContactData.staticFieldValue.duplicateRulesList)
        {
            this.contDuplicateRules = this.viewContactData.staticFieldValue.duplicateRulesList.length;
        }
        if(this.viewContactData && this.viewContactData.staticFieldValue && this.viewContactData.staticFieldValue.triggersList)
        {
            this.contTriggers = this.viewContactData.staticFieldValue.triggersList.length;
        }
        if(this.viewContactData && this.viewContactData.staticFieldValue && this.viewContactData.staticFieldValue.flowList)
        {
            this.contTriggers += this.viewContactData.staticFieldValue.flowList.length;
        }
        if(this.viewContactData && this.viewContactData.staticFieldValue && this.viewContactData.staticFieldValue.validationRule)
        {
            this.contValidation = this.viewContactData.staticFieldValue.validationRule.length;
        }

        //For Opportunity
        if(this.viewOpportunityData && this.viewOpportunityData.staticFieldValue && this.viewOpportunityData.staticFieldValue.isTriggers)
        {
            this.oppTriggers = this.viewOpportunityData.staticFieldValue.isTriggers.length;
        }
        if(this.viewOpportunityData && this.viewOpportunityData.staticFieldValue && this.viewOpportunityData.staticFieldValue.flowList)
        {
            this.oppTriggers += this.viewOpportunityData.staticFieldValue.flowList.length;
        }
        if(this.viewOpportunityData && this.viewOpportunityData.staticFieldValue && this.viewOpportunityData.staticFieldValue.validationRule)
        {
            this.oppValidation = this.viewOpportunityData.staticFieldValue.validationRule.length;
        }
    
    }

    hideModalBox() {  
        //this.isShowModal = false;
        const event = new CustomEvent("close", {
            detail: false
        });
        this.dispatchEvent(event);
        if(this.viewLeadData)
        {
            this.handleUpdateDiagramBody(this.diagramBody,'Lead');
        }
        else if(this.viewAccountData)
        {
            this.handleUpdateDiagramBody(this.diagramBody,'Account');
        }
        else if(this.viewOpportunityData)
        {
            this.handleUpdateDiagramBody(this.diagramBody,'Opportunity');
        }
        else if(this.viewContactData)
            {
                this.handleUpdateDiagramBody(this.diagramBody,'Contact');
            }
        
    }

    handleInputChange(event)
    {
        this.diagramBody = event.target.value;
        console.log('input value=>',this.diagramBody);    
    }

    handleImageUrlMethod()
    {
        
        if(this.diagramBody)
        {
            this.isSpinner = true;
            getImageUrl({body:this.diagramBody})
            .then(result => {
                this.isSpinner = false;
                this.isCreateDiagramBtnDsbl = false;
                console.log('image Success',JSON.parse(result));
                let data = JSON.parse(result);
                console.log('image data=>',data);
                if(data.Message === 'Success')
                {   
                    this.eraserUrlHide = 'slds-show';
                    this.imageMsgHide = 'slds-hide';
                    this.eraserUrl = data.EraserUrl;
                    this.imageUrl = data.ImageURL;
                    this.isImageURLBtn = false;
                    console.log('after adding image url in diagram body=>',JSON.stringify(data.ImageURL));
                    let msg = 'Diagram is created successfully. Please see by click on the button.';
                    this.showSuccessToast(msg);
                }
                else if(data.Message === 'Error')
                {
                    this.imageMsgHide = 'slds-show';
                    this.eraserUrlHide = 'slds-hide';
                    console.log('image message=>',data.Message);
                    this.imageMsg = data.Status + '! Please try after 30 second.';
                    let erormsg = 'Something went wrong! Please try after 30 second.';
                    this.showErrorToast(erormsg);
                }
            })
            .catch(error => {
                console.log('image error',error);
                this.isSpinner = false;
                this.isCreateDiagramBtnDsbl = false;
                this.isImageURLBtn = true;
                this.showErrorToast(error.body.message);
            });
        }
        else
        {
            alert('Please write something about lead.');
        }
    }

    handleUpdateDiagramBody(body,sObject)
    {
        updateDiagramBody({diagramBody:body,objectType:sObject})
            .then(result => {
                if(result === 'Success')
                {
                    let msg = 'Business process updated sucessfully into the database.';
                    this.showSuccessToast(msg);
                }
                else if(result === 'Error')
                {
                    let errorMsg = 'Business process not updated sucessfully into the database. Please try again.';
                    this.showErrorToast(errorMsg);
                }
                
            })
            .catch(error => {
                // TODO Error handling
                this.showErrorToast(error.body.message);
            });
    }

    handleGetDiagramBody()
    {
        getDiagramBody()
            .then(result => {
                if(this.viewLeadData)
                {
                    this.diagramBody = result.Lead_Business_Process__c;
                }
                else if(this.viewAccountData)
                {
                    this.diagramBody = result.Account_Business_Process__c;
                }
                else if(this.viewOpportunityData)
                {
                    this.diagramBody = result.Opportunity_Business_Process__c;
                }
                else if(this.viewContactData)
                {
                    this.diagramBody = result.Contact_Business_Process__c;
                }
                
            })
            .catch(error => {
                // TODO Error handling
                this.showErrorToast(error.body.message);
            });
    }

    handleCreateDiagram()
    {
        this.isCreateDiagramBtnDsbl = true;
        this.handleImageUrlMethod();
    }

    openImageUrl()
    {
        window.open(this.imageUrl, '_blank');
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