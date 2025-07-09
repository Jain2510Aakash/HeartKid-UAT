import { LightningElement, track } from 'lwc';
import getDuplicateContacts from '@salesforce/apex/DuplicateContactController.getDuplicateContacts';

export default class DuplicateContacts extends NavigationMixin(LightningElement) {
    @track groupedContacts = [];
    @track isLoading = true;
    @track noDuplicates = false;

    connectedCallback() {
        getDuplicateContacts()
            .then(result => {
                debugger;
                this.groupedContacts = result;
                this.noDuplicates = result.length === 0;
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error:', error);
                this.isLoading = false;
                this.noDuplicates = true;
            });
    }

    get hasData() {
        return this.groupedContacts.length > 0;
    }
    handleNavigateToContact(event) {
        const contactId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: contactId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }

    getContactUrl(contactId) {
        return `/lightning/r/Contact/${contactId}/view`;
    }
}