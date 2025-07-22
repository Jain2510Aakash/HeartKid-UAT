import { LightningElement, track } from 'lwc';
import getDuplicateContacts from '@salesforce/apex/DuplicateContactController.getDuplicateContacts';
import { NavigationMixin } from 'lightning/navigation';

export default class DuplicateContacts extends NavigationMixin(LightningElement) {
    @track groupedContacts = [];
    @track isLoading = true;
    @track noDuplicates = false;

    connectedCallback() {
        debugger;
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
        debugger;
        return this.groupedContacts.length > 0;
    }
    handleNavigateToContact(event) {
        debugger;
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
        debugger;
        return `/lightning/r/Contact/${contactId}/view`;
    }
}