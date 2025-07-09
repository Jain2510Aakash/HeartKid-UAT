import { LightningElement,track } from 'lwc';
export default class TabComponent extends LightningElement {

    @track leadTotalScore;
    @track accountTotalScore;
    @track contactTotalScore;
    @track opportunityTotalScore;
    @track TotalScores = [];
    @track AllObjectData = [];

    handleLeadScore(event)
    {
        this.leadTotalScore = event.detail;
        const index = this.TotalScores.findIndex(item => item.Key === 'Lead');
        if (index > -1) { // only splice array when item is found
            this.TotalScores.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.TotalScores.push(this.leadTotalScore);
        console.log('lead score=>',JSON.stringify(this.leadTotalScore));
    }

    handleAccountScore(event)
    {
        this.accountTotalScore = event.detail;
        const index = this.TotalScores.findIndex(item => item.Key === 'Account');
        if (index > -1) { // only splice array when item is found
            this.TotalScores.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.TotalScores.push(this.accountTotalScore);
        console.log('Account score=>',JSON.stringify(this.accountTotalScore));
    }

    handleContactScore(event)
    {
        this.contactTotalScore = event.detail;
        const index = this.TotalScores.findIndex(item => item.Key === 'Contact');
        if (index > -1) { // only splice array when item is found
            this.TotalScores.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.TotalScores.push(this.contactTotalScore);
        console.log('Contact Score=>',JSON.stringify(this.contactTotalScore));
    }

    handleOpportunityScore(event)
    {
        this.opportunityTotalScore = event.detail;
        const index = this.TotalScores.findIndex(item => item.Key === 'Opportunity');
        if (index > -1) { // only splice array when item is found
            this.TotalScores.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.TotalScores.push(this.opportunityTotalScore);
        console.log('opportunity score=>',JSON.stringify(this.opportunityTotalScore));
    }

    handleLeadData(event)
    {
        let leadData = event.detail;
        const index = this.AllObjectData.findIndex(item => item.leadData);
        if (index > -1) { // only splice array when item is found
            this.AllObjectData.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.AllObjectData.push(leadData);
        console.log('AllObject Data',JSON.stringify(this.AllObjectData));
    }

    handleAccountData(event)
    {
        let accountData = event.detail;
        const index = this.AllObjectData.findIndex(item => item.accountData);
        if (index > -1) { // only splice array when item is found
            this.AllObjectData.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.AllObjectData.push(accountData);
        console.log('AllObject Data',JSON.stringify(this.AllObjectData));
    }

    handleOpportunityData(event)
    {
        let opportunityData = event.detail;
        console.log('opportunity data:',opportunityData);
        const index = this.AllObjectData.findIndex(item => item.opportunityData);
        if (index > -1) { // only splice array when item is found
            this.AllObjectData.splice(index, 1); // 2nd parameter means remove one item only
        }
        this.AllObjectData.push(opportunityData);
        console.log('AllObject Data',JSON.stringify(this.AllObjectData));
    }


}