@RestResource(urlMapping='/engonet/order/*')
global with sharing class EngonetRestAPI
{
    global static boolean isNullOrEmpty(string str)
    {
        return str == null || String.isBlank(str); 
    }    

    public static String getCampaignNameValue(Items itemType) 
    {
        string value = '';

        if(!string.isBlank(itemType.event_name))
            value = itemType.event_name;    
        if(!string.isBlank(itemType.campaign_name))
            value = itemType.campaign_name;     
        return value;
    }

    public static String getCampaignTypeValue(Items itemType) 
    {
        string value = 'Event';

        if(!string.isBlank(itemType.event_name))
            value = 'Event';    
        if(!string.isBlank(itemType.campaign_name))
            value = 'Campaign';      
        return value;
    }

    public static String getRecurringDonationFrequencyValue (integer frequencyId)
    {
        string frequencyValue = null;

        if (frequencyId == 2) {
            frequencyValue = 'Daily';
        }
        else if (frequencyId == 3) {
            frequencyValue = 'Weekly';
        }
        else if (frequencyId == 4) {
            frequencyValue = 'Fortnightly';            
        }
        else if (frequencyId == 5) {
            frequencyValue = 'Monthly';  
        }
        else if (frequencyId == 6) {
            frequencyValue = 'Quarterly';  
        }
        else if (frequencyId == 7) {
            frequencyValue = 'Half-yearly';  
        }
        else if (frequencyId == 8) {
            frequencyValue = 'Yearly';  
        }

        return frequencyValue;
    }

    public static Contact createContact(string identityId, string salutation, string firstName, string lastName, string company, string email, string street, string city, string state, 
                                        string postcode, string country, string phone, string fax, boolean emailOptIn, string dateOfBirth, string jobTitle, string gender,
                                        string shippingStreet, string shippingCity, string shippingState, string shippingPostcode, string shippingCountry)
    {
        Contact newRecord = new Contact();
        
        System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>> Contact - Received First Name: ' + firstName);
        System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>> Contact - Received Last Name: ' + lastName);
        System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>> Contact - Special character: ’');

        if (firstName.contains('’'))
            System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>> Contact - First Name contains special character ’: ' + firstName);
        if (lastName.contains('’'))
            System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>> Contact - Last Name contains special character ’: ' + lastName);

        newRecord.FirstName = firstName;
        newRecord.LastName = lastName;
        newRecord.Email = email;
        newRecord.Salutation = salutation;
        //newRecord.npe01__HomeEmail__c = email;        // Remove this as it is linked to NPSP package
        
        // Update address only if it is relevant
        // Billing Address
        if (String.isNotBlank(street))
        {
            newRecord.MailingStreet = street;
        }
        if (String.isNotBlank(city))
        {
            newRecord.MailingCity = city;
        }
        if (String.isNotBlank(state))
        {
            newRecord.MailingState = state;
        }        
        if (String.isNotBlank(postcode))
        {
            newRecord.MailingPostalCode = postcode;
        }
        if (String.isNotBlank(country))
        {
            newRecord.MailingCountry = country;
        }        

        // Shipping Address        
        if (String.isNotBlank(shippingStreet))
        {
            newRecord.OtherStreet = shippingStreet;
        }
        if (String.isNotBlank(shippingCity))
        {
            newRecord.OtherCity = shippingCity;            
        }
        if (String.isNotBlank(shippingState))
        {
            newRecord.OtherState = shippingState;
        }
        if (String.isNotBlank(shippingPostcode))
        {
            newRecord.OtherPostalCode = shippingPostcode;
        }
        if (String.isNotBlank(shippingCountry))
        {
            newRecord.OtherCountry = shippingCountry;
        }

        if (String.isNotBlank(phone))
        {
            newRecord.Phone = phone;
        }
        if (String.isNotBlank(fax))
        {
            newRecord.Fax = fax;        
        }

        if (String.isNotBlank(dateOfBirth))
        {
            string DOBStr = dateOfBirth.substring(0, dateOfBirth.indexOf(' ')); //(20/04/2015 12:22:09 AM)
            newRecord.BirthDate = Date.parse(DOBStr);
        }

        if (String.isNotBlank(jobTitle))
        {
            newRecord.Title = jobTitle;
        }

        // Check if custom field "Gender" is present
        boolean is_gender_present = doesFieldExist('Contact', 'Gender__c');                 
        if (is_gender_present && String.isNotBlank(gender))
        {
            newRecord.Gender__c = gender;
        }

        newRecord.External_ID__c = identityId;
        newRecord.External_System_Name__c = 'Unity';

        return newRecord;
    }
    
    public static boolean validateContact(Contact contact)
    {
        return !String.isBlank(contact.LastName);
    }

    public static Account createAccount(string name, string ABN)
    {       
        Account newRecord = new Account();
            
        newRecord.Name = name;
        
        // Check if custom field "ABN/ACN" is present
        boolean is_ABN_present = doesFieldExist('Account', 'ABN_ACN__c');       
        if (is_ABN_present && String.isNotBlank(ABN))
        {
            newRecord.ABN_ACN__c = ABN;
        }
        
        newRecord.External_System_Name__c = 'Unity';
        
        return newRecord;
    }

    public static Campaign createCampaign(RestResponse res, string name, string type, string externalID, string campaignUrl, string parentCampaignId, string campaignStartDate,
                                        string campaignEndDate, string campaignPageOwner, string totalValueOfFundraisingPage, boolean isTeam, string currentAmount, 
                                        List<String> customCampaignStatus)
    {
        Campaign newRecord = new Campaign();
        
        newRecord.Name = name;
        newRecord.ParentId = parentCampaignId;
        newRecord.Type = type;
        newRecord.Status = 'In Progress';
        newRecord.External_ID__c = externalID;
        newRecord.External_System_Name__c = 'Unity';
        newRecord.External_System_Link__c = campaignUrl;
        newRecord.IsActive = True;
        
        if (string.isNotBlank(campaignStartDate))
        {
            newRecord.StartDate = Date.parse(campaignStartDate);
        }
        if (string.isNotBlank(campaignEndDate))
        {
            newRecord.EndDate = Date.parse(campaignEndDate);
        }

        // Check if custom field "Page Owner" is present
        boolean is_Page_Owner_present = doesFieldExist('Campaign', 'Page_Owner__c');                 
        if (is_Page_Owner_present && String.isNotBlank(campaignPageOwner))
        {
            newRecord.Page_Owner__c = campaignPageOwner;
        }

        // Check if custom field "Total Value of Fundraising Page" is present
        boolean is_Total_Value_of_Fundraising_Page_present = doesFieldExist('Campaign', 'Total_Value_of_Fundraising_Page__c');                 
        if (is_Total_Value_of_Fundraising_Page_present && String.isNotBlank(totalValueOfFundraisingPage))
        {
            newRecord.Total_Value_of_Fundraising_Page__c = Decimal.valueOf(totalValueOfFundraisingPage);
        }

        // Check if custom field "Fundraising Team Page" is present
        boolean is_Fundraising_Team_Page_present = doesFieldExist('Campaign', 'Fundraising_Team_Page__c');                 
        if (is_Fundraising_Team_Page_present)
        {
            newRecord.Fundraising_Team_Page__c = isTeam;
        }

        // Check if custom field "Total Amount Raised in Evenico" is present
        boolean is_Total_Amount_Raised_in_Evenico_present = doesFieldExist('Campaign', 'Total_Amount_Raised_in_Evenico__c');                 
        if (is_Total_Amount_Raised_in_Evenico_present && String.isNotBlank(currentAmount))
        {
            newRecord.Total_Amount_Raised_in_Evenico__c = Decimal.valueOf(currentAmount);
        }

        // Check if custom field "In Memory Name" is present
        boolean is_in_memory_name_present = doesFieldExist('Campaign', 'In_Memory_Name__c');                 
        if (is_in_memory_name_present && type == 'In Memory' && String.isNotBlank(name))
        {
            newRecord.In_Memory_Name__c = name;
        }

        try
        {
            insert newRecord;
            System.debug(logginglevel.DEBUG, 'Inserted campaign');
        }
        catch (System.DmlException e)
        {
            System.debug(logginglevel.ERROR, 'Failed to insert campaign ' + formatDmlException(e));
            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "create campaign"}}');
            return null;
        }

        System.debug(logginglevel.DEBUG, 'Created new campaign object with details: ' + newRecord.Name + ' ' + newRecord.Type + ' ' + newRecord.External_ID__c + ' ' + externalID);

        // Custom Campaign Member Status
        if (newRecord != null && (customCampaignStatus != null && customCampaignStatus.size() > 0))
        {
            integer sortOrderValue = 2;
            for (integer i = 0; i < customCampaignStatus.size(); i++)
            {
                CampaignMemberStatus[] campaignMemberStatuses = [SELECT Id, CampaignId, Label, SortOrder FROM CampaignMemberStatus
                                    WHERE CampaignId = :newRecord.Id AND Label = :customCampaignStatus[i]];
                sortOrderValue = sortOrderValue + 1;
                System.debug(logginglevel.DEBUG, '>>>>>> Campaign Member Status: size : ' + campaignMemberStatuses.size());
                try {
                    if (campaignMemberStatuses.isEmpty() && campaignMemberStatuses.size() <= 0)
                    {
                        CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId = newRecord.Id, HasResponded = true, Label = customCampaignStatus[i], SortOrder = sortOrderValue, isDefault = false);
                        insert cms1;
                        System.debug(logginglevel.DEBUG, 'Campaign Member Status: Custom member status inserted. Status Label: ' + customCampaignStatus[i]);
                    }
                } catch (System.DmlException e) {
                    System.debug(logginglevel.ERROR, 'Failed to create campaign member status');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert campaign member status"}}');
                }
            }
            
        }

        return newRecord;
    }
    
    public static Opportunity createOpportunity(string accountID, string name, string amount, string orderType, string closeDate, integer externalID, string details, string campaignID, 
                        string membershipLevel, string membershipFrequency, string relatedUrl, string contactID, string fundraisingCampaignID, 
                        string sponsorDonationAmount, integer externalRecurringId, integer recurringFrequencyId, string recurringInitialOrderDate, integer recurringNumber, string externalRecurringUrl,
                        boolean isAdminOrder, string customFieldName, string customFieldValue, string membershipValidFrom, string membershipValidTo, string membershipOrigin, 
                        string discountAmount, string taxAmount, string subtotalAmount, Integer numberOfTickets ) 
    {
        string closeDateStr = closeDate.substring(0, closeDate.indexOf(' ')); //(20/04/2015 12:22:09 AM)

        Opportunity newRecord = new Opportunity();
        newRecord.AccountID = accountID;
        newRecord.Name = name;
        newRecord.StageName = 'Closed Won';
        newRecord.Amount = Decimal.valueOf(amount);
        newRecord.Type = orderType;
        newRecord.CloseDate = Date.parse(closeDateStr);
        newRecord.Description = details;
        newRecord.External_ID__c = string.valueOf(externalID);
        newRecord.External_System_Name__c = 'Unity';
        newRecord.npe01__Do_Not_Automatically_Create_Payment__c = true;
        newRecord.LeadSource = 'Web';
        if (!string.isBlank(campaignID))
        {
            newRecord.CampaignID = campaignID;
        }
        newRecord.External_System_Link__c = relatedUrl;

        if (orderType == 'Membership')
        {
            System.debug('-------------------------------------------------- Membership --------------------------------------------------');
            RecordType rt = [select Id from RecordType where Name = 'Membership' and SobjectType = 'Opportunity' LIMIT 1];
            newRecord.RecordTypeId = rt.Id;
            newRecord.npe01__Member_Level__c = membershipLevel;
            if (string.isNotBlank(membershipValidFrom))
                newRecord.npe01__Membership_Start_Date__c =  Date.parse(membershipValidFrom.substring(0, membershipValidFrom.indexOf(' '))); 
            if (string.isNotBlank(membershipValidTo))
                newRecord.npe01__Membership_End_Date__c =  Date.parse(membershipValidTo.substring(0, membershipValidTo.indexOf(' ')));
            newRecord.npe01__Membership_Origin__c = membershipOrigin;
        }

        if (!string.isBlank(contactID))
        {
            newRecord.npsp__Primary_Contact__c = contactID;
        }

        // Check if custom field "Fundraising Campaign" is present
        boolean is_Fundraising_Campaign_present = doesFieldExist('Opportunity', 'Fundraising_Campaign__c');                 
        if (is_Fundraising_Campaign_present && String.isNotBlank(fundraisingCampaignID))
        {
            newRecord.Fundraising_Campaign__c = fundraisingCampaignID;
        }

        // Check if custom field "Sponsor Donation Amount" is present 
        boolean is_Sponsor_Donation_Amount_present = doesFieldExist('Opportunity', 'Sponsor_Donation_Amount__c');                 
        if (is_Sponsor_Donation_Amount_present)
        {
            /*
                This field is used for calculation purpose only and not to be displayed on the page layout
                This is used to update the "Total Value of Fundraising Page" field on the Fundraising Page Campaign when an order is refunded on Evenico
            */
            newRecord.Sponsor_Donation_Amount__c = Decimal.valueOf(sponsorDonationAmount);
        }

        if (externalRecurringId != null && externalRecurringId > 0)
        {
            string recInitialOrderDateStr = recurringInitialOrderDate.substring(0, recurringInitialOrderDate.indexOf(' ')); //(20/04/2015 12:22:09 AM)

            newRecord.External_Recurring_ID__c = string.valueOf(externalRecurringId);
            newRecord.Type = 'Recurring Donation';
            newRecord.Recurring_Donation_Frequency__c = getRecurringDonationFrequencyValue(recurringFrequencyId) ; 
            newRecord.Recurring_Initial_Order_Date__c = Date.parse(recInitialOrderDateStr);
            newRecord.Recurring_Number__c = recurringNumber;
            System.debug('----------------------------- Recurring Order Link ----------------------------- : ' + externalRecurringUrl);
            newRecord.External_Recurring_Donation_Link__c = externalRecurringUrl;
        }

        // Check if custom field "Fundraising Team Page" is present
        boolean is_Admin_Order_present = doesFieldExist('Opportunity', 'Is_Admin_Order__c');                 
        if (is_Admin_Order_present)
        {
            newRecord.Is_Admin_Order__c = isAdminOrder;
        }

        // Custom field and value that is part of donation
        newrecord.Extra_Question_Label_1__c = customFieldName;
        newRecord.Extra_Question_Value_1__c = customFieldValue;

        newRecord.Total_Tax__c = Decimal.valueOf(taxAmount);
        newRecord.Total_Discount__c = Decimal.valueOf(discountAmount);
        newRecord.Subtotal_Amount__c = Decimal.valueOf(subtotalAmount);
        
        if (numberOfTickets != null)
        {
            newRecord.Number_of_Tickets__c = numberOfTickets;
        }
        return newRecord;
    }

    public static npe01__OppPayment__c createPayment(string opportunityID, string refNo, string amount, string paymentDate, string paymentMethod, string gst)
    {
        string paymentDateStr = paymentDate.substring(0, paymentDate.indexOf(' ')); //(20/04/2015 12:22:09 AM)

        npe01__OppPayment__c newRecord = new npe01__OppPayment__c();
        newRecord.npe01__Opportunity__c = opportunityID;
        newRecord.npe01__Check_Reference_Number__c = refNo;
        newRecord.npe01__Payment_Amount__c = Decimal.valueOf(amount);
        newRecord.npe01__Payment_Date__c = Date.parse(paymentDateStr);
        newRecord.npe01__Payment_Method__c = paymentMethod;
        newRecord.npe01__Paid__c = true;
        newRecord.GST__c = Decimal.valueOf(gst);
        
        return newRecord;
    }

    public static String getOpportunityContactRoleName(string itemType) 
    {
        // OrderItemType
        // 1   Donation
        // 2   Event Registration
        // 3   Sponsor Donation
        // 4   Campaign Donation
        // 5   Gift Card
        // 6   Store
        // 7   Membership
        // 8   Free Form
        // 9   In Memory Donation
        // 10  Event Donation
        // 11  Booking Fee
        // 12  Shipping

        string value = 'Donor';
        
        if(itemType == 'Donation' || itemType == 'Sponsor Donation' || itemType == 'Campaign Donation' || itemType == 'Free Form' || itemType == 'In Memory Donation' || itemType == 'Event Donation')
            value = 'Donor';

        if(itemType == 'Event Registration')
            value = 'Event Participant';    
        
        if(itemType == 'Gift Card' || itemType == 'Store')
            value = 'Buyer'; 

        if(itemType == 'Membership')
            value = 'Member';
        
        return value;
    }

    public static CampaignMember createCampaignMember(Campaign campaign, Contact contact, string status)
    {
        CampaignMember cm = null;
        
        // Campaign Members only ever have a single instance of membership to a Campaign.
        CampaignMember[] cms = [SELECT Id, Contact.FirstName, Contact.LastName, Contact.Email FROM CampaignMember
        WHERE CampaignId = :campaign.Id AND ContactId = :contact.Id];

        // If we don't find an existing membership for this Campaign, we create one. The default Status is always Responded - as in, they have responded to this Campaign.
        if(cms.isEmpty() && cms.size() <= 0)
        {
            if (string.isNotBlank(status))
            {
                if(contact.Id!=null)
                {
                    cm = new CampaignMember(CampaignId = campaign.Id, ContactId = contact.Id, Status=status);
                    System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Campaign member - if part');
                }
            }                
            else
            {
                if(contact.Id!=null)
                {
                    cm = new CampaignMember(CampaignId = campaign.Id, ContactId = contact.Id, Status='Responded');
                    System.debug(logginglevel.DEBUG, '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Campaign member - else part');
                }
            }
            if (cm != null)
            {
                try 
                {
                    insert cm;
                    System.debug(logginglevel.DEBUG, 'Inserted campaign member');
                } catch (System.DmlException e) 
                {
                    System.debug(logginglevel.ERROR, 'Failed to insert campaign member ' + formatDmlException(e));
                    return null;
                }
            }
                
        }

        return cm;
    }

    // Function to check if a field exists in the passed Salesforce object. Returns true if it currently exists
    public static boolean doesFieldExist(String objName, string fieldName)
    {
        try {
            SObject so = Schema.getGlobalDescribe().get(objName).newSObject();
            System.debug('-----------------------------Does Field Exists? ----------- Object: ' + objName + ' - Fieldname: ' + fieldName + ' >>>>>> ' + so.getSobjectType().getDescribe().fields.getMap().containsKey(fieldName));
            return so.getSobjectType().getDescribe().fields.getMap().containsKey(fieldName);
        }
        catch(Exception ex) {}
        
        return false;
    }

    // Function to check if address should be updated with received details
    public static String checkToUpdateAddress (String SFStreet, String SFCity, String SFState, String SFPostCode, String SFCountry, 
                                                String RecStreet, String RecCity, String RecState, String RecPostCode, String RecCountry)
    {
        String result = '';
        if (String.isBlank(SFStreet) && String.isBlank(SFCity) && String.isBlank(SFState) && String.isBlank(SFPostCode) && String.isBlank(SFCountry))
        {
            // No information present in Salesforce. Update with received details.
            result = 'Update';
            System.debug('----------------------------- Update 01 -----------------------------');
        }
        else if (String.isNotBlank(SFCountry) && (String.isBlank(SFStreet) && String.isBlank(SFCity) && String.isBlank(SFState) && String.isBlank(SFPostCode)) )
        {
            // There is only country information present in Salesforce. Update with received details.
            if (String.isNotBlank(RecCountry) && (String.isNotBlank(RecStreet) || String.isNotBlank(RecCity) || String.isNotBlank(RecState) || String.isNotBlank(RecPostCode)))
            {
                // There is more than just country info recevied
                result = 'Update';
                System.debug('----------------------------- Update 02 -----------------------------');         
            }
            else 
            {
                result = 'Ignore';
                System.debug('----------------------------- Ignore 02 -----------------------------');
            }            
        }
        else if (String.isBlank(SFStreet) || String.isBlank(SFCity) || String.isBlank(SFState) || String.isBlank(SFPostCode) || String.isBlank(SFCountry))
        {
            // At least one field is blank indicating they have partial information stored. Update with received details. 
            // Check if the received information has only the Country populated
            if (String.isNotBlank(RecCountry) && String.isBlank(RecStreet) && String.isBlank(RecCity) && String.isBlank(RecState) && String.isBlank(RecPostCode))
            {
                result = 'Ignore';
                System.debug('----------------------------- Ignore 03a -----------------------------');
            }
            else if (String.isBlank(RecCountry) && String.isBlank(RecStreet) && String.isBlank(RecCity) && String.isBlank(RecState) && String.isBlank(RecPostCode))
            {
                // Evenico: Address block may not be part of the User Account Form - due to which all fields are blank
                result = 'Ignore';
                System.debug('----------------------------- Ignore 03b -----------------------------');
            }
            else if (String.isNotBlank(RecCountry) && (String.isNotBlank(RecStreet) || String.isNotBlank(RecCity) || String.isNotBlank(RecState) || String.isNotBlank(RecPostCode)))
            {
                // There is more than just country info recevied
                //if (String.isNotBlank(SFStreet) && (String.isNotBlank(SFCity) || String.isNotBlank(SFState) || String.isNotBlank(SFPostCode) || String.isNotBlank(SFCountry)))
                //{                    
                    result = 'Update';
                    System.debug('----------------------------- Update 03 -----------------------------');            
                //}
            }
            else 
            {
                result = 'Ignore';
                System.debug('----------------------------- Ignore 03c -----------------------------');
            }
        }
        else if (String.isNotBlank(SFStreet) && String.isNotBlank(SFCity) && String.isNotBlank(SFState) && String.isNotBlank(SFPostCode) && String.isNotBlank(SFCountry))
        {
            // Currently the record has full information stored in Salesforce. Check if recevied is full or partial. 
            if (String.isNotBlank(RecStreet) && String.isNotBlank(RecCity) && String.isNotBlank(RecState) && String.isNotBlank(RecPostCode) && String.isNotBlank(RecCountry))
            {
                // Full information received
                result = 'Update';
                System.debug('----------------------------- Update 04 -----------------------------');
            }
            else
            {
                // Partial information received
                result = 'Ignore';
                System.debug('----------------------------- Ignore 04 -----------------------------');
            }
        }
        return result;
    }

    // Contact : Function to Get Salesforce Field Type
    public static String getContactFieldType(String fieldName)
    {
        Schema.DisplayType fielddataType = soContact.getSobjectType().getDescribe().fields.getMap().get(fieldName).getDescribe().getType();

        return String.valueOf(fielddataType).toLowerCase();
    }

    // Contact : Function to Set Custom Form Field Value
    public static Contact getAndSetCustomField(integer formFieldId, integer fieldTypeId, string apiName, string formFieldName, string formValue, Contact user_Contact)
    {
        boolean is_custom_field_present = false;
        String SF_field_type = '';
        boolean is_picklist_option_present = false;

        // Check if there is an API Name
        if (String.isNotBlank(apiName))
        {
            // Check if there is a value
            if (String.isNotBlank(formValue))
            {
                // Check if field exists in Salesforce
                is_custom_field_present = soContact.getSobjectType().getDescribe().fields.getMap().containsKey(apiName);
                if (is_custom_field_present)
                {
                    // Get the field type of the Salesforce field
                    SF_field_type = getContactFieldType(apiName);
                    System.debug('----------------------------- getAndSetCustomField >>> Custom Field Type >>>> ----------- SF Fieldname : ' + apiName + ' >>>>>> SF Field Type : ' + SF_field_type + ' >>>>>> Evenico Field Type : ' + fieldTypeId + ' >>>>>> Field Value: ' + formValue);
                    
                    // To prevent errors, compare the received and SF field type before updating the value
                    
                    // Evenico form_field_type 
                    //1  Single-line Text
                    //2  Multi-line Text
                    //3  Number
                    //4  Email
                    //5  Date
                    //6  Drop-down List
                    //7  Checkbox
                    //8  Email Account                    

                    if ((fieldTypeId == 1 || fieldTypeId == 2) && (SF_field_type == 'string' || SF_field_type == 'textarea')) // Single-line & Multi-line Text
                    {
                        user_Contact.put(apiName, formValue);
                    }
                    else if (fieldTypeId == 3 && (SF_field_type == 'integer' || SF_field_type == 'double' || SF_field_type == 'percent' || SF_field_type == 'long'
                            || SF_field_type == 'currency' || SF_field_type == 'phone')) // Number
                    {
                        // If the received field value length > SF field length => we do not update the field
                        // If the recevied field value is a decimal value but SF field does not support decimal value => we do not update the field
                        Schema.DescribeFieldResult number_field = soContact.getSobjectType().getDescribe().fields.getMap().get(apiName).getDescribe();
                        
                        formValue = formValue.remove(',');                          // Form Value can contain these characters : "." "," "-"
                        Integer SFFieldLength = number_field.getPrecision();      // Number(15,2) => 17
                        Integer SFdecimalLength = number_field.getScale();          // Number(15,2) => 2
                        Integer SFleftLength = SFFieldLength - SFdecimalLength;   // 17 - 2 => 15
                        Integer fieldValueLength = formValue.length();

                        boolean is_decimal_value = false;
                        boolean is_valid_field_value = false;
                        
                        string whole_number_part = '';
                        string decimal_part = '';

                        if (formValue.indexOf('.') != -1)                           // Is a decimal value
                        {
                            whole_number_part = formValue.substring(0, formValue.indexOf('.'));
                            decimal_part = formValue.substringAfter('.');
                        }
                        else                                                        // Not a decimal value
                        {
                            whole_number_part = formValue;                            
                        }
                        
                        if (string.isNotBlank(decimal_part))
                        {
                            is_decimal_value = true;
                        }

                        if (SFdecimalLength > 0)                                    // SF field accepts decimal value
                        {
                            // If it is a decimal value, fieldValueLength includes "." in the length
                            if ((is_decimal_value == true && (fieldValueLength - 1) <= SFFieldLength) || (is_decimal_value == false && (fieldValueLength) <= SFFieldLength))
                            {
                                if (SFdecimalLength >= decimal_part.length())
                                {
                                    is_valid_field_value = true;
                                }
                                else 
                                {
                                    formValue = whole_number_part + '.' + decimal_part.substring(0, SFdecimalLength);
                                    is_valid_field_value = true;
                                } 
                            }
                        }
                        else                                                        // SF field does not accept decimal value
                        {
                            if (fieldValueLength <= SFFieldLength) 
                            {
                                if (!is_decimal_value)                              // Recevied value is not a decimal value
                                {
                                    is_valid_field_value = true;
                                }
                            }
                        }

                        System.debug('----------------------------- getAndSetCustomField >>> Custom Field Type >>>> ----------- Final Field Value : '+  formValue);
                        System.debug('----------------------------- getAndSetCustomField >>> Custom Field Type >>>> ----------- Is Valid Field Value : '+  is_valid_field_value);
                        
                        if (is_valid_field_value)
                        {
                            if (SF_field_type == 'integer' || SF_field_type == 'percent' || SF_field_type == 'currency')
                            {
                                user_Contact.put(apiName, Integer.valueOf(formValue.trim()));
                            }                            
                            else if (SF_field_type == 'double')
                            {
                                user_Contact.put(apiName, double.valueOf(formValue.trim()));
                            }                            
                            else if (SF_field_type == 'long')
                            {
                                user_Contact.put(apiName, long.valueOf(formValue.trim()));
                            }
                            else if (SF_field_type == 'phone')
                            {
                                user_Contact.put(apiName, formValue);
                            }
                        }                        
                    }
                    else if ((fieldTypeId == 4 || fieldTypeId == 8) && (SF_field_type == 'email'))  // Email & Email Account
                    {
                        user_Contact.put(apiName, formValue);
                    }
                    else if (fieldTypeId == 5 && (SF_field_type == 'date' || SF_field_type == 'dateTime'))  // Date - this is actually a datetime value from platform
                    {
                        if (SF_field_type == 'date')
                        {
                            string DateStr = formValue.substring(0, formValue.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                            user_Contact.put(apiName, Date.parse(DateStr));
                        }
                        else if (SF_field_type == 'dateTime')
                        {
                            user_Contact.put(apiName, Datetime.valueOf(formValue) );
                        }
                    }
                    else if (fieldTypeId == 6 && (SF_field_type == 'picklist'))  // Drop-down List
                    {
                        List<Schema.PicklistEntry> ple = soContact.getSobjectType().getDescribe().fields.getMap().get(apiName).getDescribe().getPicklistValues();                        

                        for(Schema.PicklistEntry option : ple)
                        {
                            // Check if the value is part of the picklist options. If it is not, ignore it
                            if(option.getValue() == formValue)
                            {
                                user_Contact.put(apiName, option.getValue());
                            }                                                        
                        }
                    }
                    else if (fieldTypeId == 7 && (SF_field_type == 'boolean'))  // Checkbox
                    {
                        if (formValue == '0' || formValue == 'false')
                            user_Contact.put(apiName, false);
                        else if (formValue == '1' || formValue == 'true')
                            user_Contact.put(apiName, true);
                    }
                    else {
                        // Ignore as type does not match
                        System.debug('----------------------------- getAndSetCustomField >>> Custom Field Type >>>> Type does not match');
                    }
                }
            }
        }

        return user_Contact;
    }

    // Get and Set various Child Campaigns & Campaign Members
    public static Campaign FindOrCreateCampaigns(RestResponse res, string campaignName, string receivedID, string receivedSalesforceID, 
                string campaignStartDate, string campaignEndDate, string receivedCampaignType, string campaignUrl, string websiteInfo, string parentCampaignId, string pageOwnerId,
                boolean isUntetheredcampaign, string sponsorDonationAmount, string TotalValueOfFundraisingPage, string totalAmountRaisedInEvenico, boolean isTeam, 
                List<String> customStatus, string prevUntetheredParentCampName)
    {        
        // Find or create the required Campaign.
        Campaign retrievedCampaign;
        string campaignStartDateStr;
        string campaignEndDateStr;
        Campaign[] retrievedCampaigns;
        boolean isUpdateRequired = false;
        
        if (isUntetheredcampaign)   // Untethered Parent Fundraising Campaign, Parent In Memory Campaign
        {
            if (string.isNotBlank(prevUntetheredParentCampName))
            {                
                retrievedCampaigns = [SELECT ID, Name, Type, External_System_Link__c, External_System_Name__c, Total_Value_of_Fundraising_Page__c, Total_Amount_Raised_in_Evenico__c, Page_Owner__c 
                FROM Campaign WHERE ((NAME = :campaignName OR NAME = :prevUntetheredParentCampName) AND Type = :receivedCampaignType AND External_System_Name__c = 'UNITY' AND External_System_Link__c LIKE :websiteInfo)]; // No External ID here.
            }
            else 
            {
                retrievedCampaigns = [SELECT ID, Name, Type, External_System_Link__c, External_System_Name__c, Total_Value_of_Fundraising_Page__c, Total_Amount_Raised_in_Evenico__c, Page_Owner__c 
                FROM Campaign WHERE (NAME = :campaignName AND Type = :receivedCampaignType AND External_System_Name__c = 'UNITY')]; // No External ID here.
            }            
        }
        else 
        {
            retrievedCampaigns = [SELECT ID, Name, Type, External_ID__c, External_System_Name__c, Total_Value_of_Fundraising_Page__c, Total_Amount_Raised_in_Evenico__c, Page_Owner__c 
                FROM Campaign WHERE ((External_ID__c = :receivedSalesforceID) OR (External_ID__c = :receivedID AND Type = :receivedCampaignType AND External_System_Link__c like :websiteInfo))]; // No modification of the External ID here.    
        }
        
        if (string.isNotBlank(campaignStartDate))
        {
            campaignStartDateStr = campaignStartDate.substring(0, campaignStartDate.indexOf(' '));
        }
        if (string.isNotBlank(campaignEndDate))
        {
            campaignEndDateStr = campaignEndDate.substring(0, campaignEndDate.indexOf(' '));
        }

        if(retrievedCampaigns.isEmpty())
        {
            retrievedCampaign = createCampaign(res, campaignName, receivedCampaignType, receivedSalesforceID, campaignUrl, parentCampaignId, campaignStartDateStr, campaignEndDateStr, pageOwnerId, TotalValueOfFundraisingPage, isTeam, totalAmountRaisedInEvenico != null ? totalAmountRaisedInEvenico : null, customStatus);
        }
        else
        {
            retrievedCampaign = retrievedCampaigns[0];

            System.debug('------------------------------- Current Page Owner in SF: ' + retrievedCampaign.Page_Owner__c);
            System.debug('------------------------------- Received Page Owner: ' + pageOwnerId);
            if (pageOwnerId != null && retrievedCampaign.Page_Owner__c != pageOwnerId)
            {
                isUpdateRequired = true;
                retrievedCampaign.Page_Owner__c = pageOwnerId; // Update the owner
            }

            if (retrievedCampaign.Name != campaignName)
            {
                isUpdateRequired = true;
                retrievedCampaign.Name = campaignName; // Update the name to ensure it matches Evenico.
            }
            if ((!isUntetheredcampaign) && (retrievedCampaign.External_ID__c != receivedSalesforceID))
            {
                isUpdateRequired = true;
                retrievedCampaign.External_ID__c = receivedSalesforceID; // Update the ExternalID to ensure it matches Evenico.
            }
            if (string.isNotBlank(campaignStartDate))
            {
                isUpdateRequired = true;
                retrievedCampaign.StartDate = Date.parse(campaignStartDateStr);
            }
            if (string.isNotBlank(campaignEndDate))
            {
                isUpdateRequired = true;
                retrievedCampaign.EndDate = Date.parse(campaignEndDateStr);
            }
            if (sponsorDonationAmount != null && Decimal.valueOf(sponsorDonationAmount) > 0)
            {
                isUpdateRequired = true;
                if (retrievedCampaign.Total_Value_of_Fundraising_Page__c == null || retrievedCampaign.Total_Value_of_Fundraising_Page__c == 0)
                {
                    retrievedCampaign.Total_Value_of_Fundraising_Page__c = Decimal.valueOf(sponsorDonationAmount);
                }
                else 
                {    
                    retrievedCampaign.Total_Value_of_Fundraising_Page__c = retrievedCampaign.Total_Value_of_Fundraising_Page__c + Decimal.valueOf(sponsorDonationAmount);
                }
            }
            if(totalAmountRaisedInEvenico != null && (retrievedCampaign.Total_Amount_Raised_in_Evenico__c != Decimal.valueOf(totalAmountRaisedInEvenico)))
            {
                isUpdateRequired = true;
                retrievedCampaign.Total_Amount_Raised_in_Evenico__c = Decimal.valueOf(totalAmountRaisedInEvenico);
            }

            if (isUpdateRequired)
            {
                System.debug('---- Find Or Create Campaigns ---- Update Campaign');
                campaignsToUpdateList.add(retrievedCampaign);
            }
        
            // Check if you have to add the custom campaign member statuses
            if (retrievedCampaign != null && (customStatus != null && customStatus.size() > 0))
            {
                integer sortOrderValue = 2;
                for (integer i = 0; i < customStatus.size(); i++)
                {
                    CampaignMemberStatus[] campaignMemberStatuses = [SELECT Id, CampaignId, Label, SortOrder FROM CampaignMemberStatus
                                    WHERE CampaignId = :retrievedCampaign.Id AND Label = :customStatus[i]];
                    sortOrderValue = sortOrderValue + 1;
                    System.debug(logginglevel.DEBUG, '>>>>>>' + customStatus[i] + ' - Status is present? Campaign Member Status: size : ' + campaignMemberStatuses.size());
                    try {
                        System.debug(logginglevel.DEBUG, '>>>>>>>>>> Campaign member status - try');
                        if (campaignMemberStatuses.isEmpty() && campaignMemberStatuses.size() <= 0)
                        {
                            
                            System.debug(logginglevel.ERROR, '>>>>>>>>>> Campaign member status - IF');
                            CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId = retrievedCampaign.Id, HasResponded = true, Label = customStatus[i], SortOrder = sortOrderValue, isDefault = false);
                            insert cms1;
                            System.debug(logginglevel.DEBUG, 'Campaign Member Status: Custom member status inserted. Status Label: ' + customStatus[i]);
                        }
                    } catch (System.DmlException e) {
                        System.debug(logginglevel.ERROR, 'Failed to create campaign member status');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert campaign member status"}}');
                    }
                }
            }

        }

        return retrievedCampaign;
    }

    public static void createLead(RestResponse res, string firstName, string lastName, string email, string websiteURL)
    {
        Lead newsletterLead = new Lead();

        newsletterLead.FirstName = firstName;
        newsletterLead.LastName = lastName;
        newsletterLead.Email = email;
        newsletterLead.Company = 'Individual';
        newsletterLead.LeadSource = 'Newsletter Web Sign-up';
        newsletterLead.External_System_Link__c = websiteURL;

        try 
        {
            insert newsletterLead;
            System.debug(logginglevel.DEBUG, 'Inserted newsletter lead');
        } 
        catch (System.DmlException e) 
        {
            System.debug(logginglevel.ERROR, 'Failed to insert newsletter lead ' + formatDmlException(e));            
        }
    }


    // JSON Deserialised Object
    public class Order 
    {
        public integer id;
        public string identity_id;
        public string created_date;
        public string completed_date;
        public integer status;
        public string amount;
        public string gst;
        public string discount_amount;
        public string subtotal_amount;
        public string billing_first_name;
        public string billing_last_name;
        public string billing_email;
        public boolean is_company;
        public string billing_company;
        public string billing_street;
        public string billing_city;
        public string billing_state;
        public string billing_postcode;
        public string billing_country;
        public string billing_phone;
        public string billing_fax;
        public string related_url;
        public boolean email_opt_in;
        public string refund_date;
        public integer recurring_order_id;
        public integer recurring_frequency_id;
        public string recurring_initial_date;
        public boolean recurring_is_initial_order;
        public integer recurring_number;
        public string recurring_order_url;
        public integer total_no_of_recurring_donations;
        public integer total_no_of_active_recurring_donations;
        public boolean is_admin_order;
        public string call_made_from;
        public string order_url;
        public string order_prefix;
        public string shipping_street;
        public string shipping_city;
        public string shipping_state;
        public string shipping_postcode;
        public string shipping_country;
        public string website_info;
        public string website_name;
        public string donor_id_api_name;
        public string api_salesforce_donor_id;
        public string custom_field_name;
        public string custom_field_value;
        public integer[] distinct_order_item_types;
        public string str_distinct_order_item_types;
        public integer order_item_count;
        public integer no_of_event_reg_tickets;

        public Items[] items;
        public Payment payment;
        public Soft_Credit soft_credit;
        public User_Account user_account;
        public User_Account_Custom_Fields[] user_account_custom_fields;
        public Recurring_Order recurring_order;
        public Member member_user;
        public Newsletter newsletter;
    }

    public class Items 
    {
        public string amount;
        public string total_discount_amount;
        public string total_tax_amount;
        public string amount_subtotal;
        public integer type;
        public string type_id;
        public integer quantity;
        public string details;
        public integer event_campaign_id;
        public string salesforce_event_campaign_id;
        public string event_name;
        public string event_start_date;
        public string event_end_date;
        public string campaign_name;
        public string campaign_start_date;
        public string campaign_end_date;
        public string campaign_url;
        public string membership_program_name;
        public string salesforce_membership_id;
        public string membership_level;
        public string membership_frequency;
        public string membership_valid_from;
        public string membership_valid_to;
        public string membership_origin;
        public string membership_program_url;
        public string item_related_url;
        public string type_name;
        public boolean is_processed = false;
        public string membership_approval_date;
    }

    public class Payment 
    {
        public string ref_id;
        public string amount;
        public string type;
    }

    public class Soft_Credit
    {
        public string softCredit_identity_id;
        public string softCredit_first_name;
        public string softCredit_last_name;
        public string softCredit_email;
        public string softCredit_street;
        public string softCredit_city;
        public string softCredit_state;
        public string softCredit_postcode;
        public string softCredit_country;
        public string softCredit_phone;
        public string softCredit_shipping_street;
        public string softCredit_shipping_city;
        public string softCredit_shipping_state;
        public string softCredit_shipping_postcode;
        public string softCredit_shipping_country;
        public string sponsor_page_name;
        public integer sponsor_page_id;
        public string salesforce_sponsor_page_id;
        public string sponsor_page_created_date;
        public string sponsor_page_end_date;
        public string sponsor_donation_amount;
        public string sponsor_page_url;
        public boolean is_team;
        public string current_amount;
        public string target_amount;
        public string in_memory_page_name;
        public integer in_memory_page_id;
        public string salesforce_in_memory_page_id;
        public string in_memory_page_created_date;
        public integer event_campaign_id { get; set; }
        public string salesforce_event_campaign_id { get; set; }
        public string event_name { get; set; }
        public string campaign_name { get; set; }
        public string event_campaign_start_date { get; set; }
        public string event_campaign_end_date { get; set; }
        public string event_campaign_url { get; set; }
    }

    public class User_Account
    {
        public string user_identity_id;
        public string user_salutation;
        public string user_first_name;
        public string user_last_name;
        public string user_email;
        public string user_gender;
        public string user_date_of_birth;
        public string user_organisation;
        public string user_ABN;
        public string user_job_title;
        public string user_phone;
        public string user_mailing_street;
        public string user_mailing_city;
        public string user_mailing_state;
        public string user_mailing_postal_code;
        public string user_mailing_country;
        public string user_shipping_street;
        public string user_shipping_city;
        public string user_shipping_state;
        public string user_shipping_postal_code;
        public string user_shipping_country;
        public boolean user_marketing_approval;
        public boolean user_is_company;
        public integer event_campaign_id;
        public string salesforce_event_campaign_id;
        public string event_campaign_name;
        public string event_or_campaign;
        public string campaign_start_date;
        public string campaign_end_date;
        public string event_or_campaign_url;
    }

    public class User_Account_Custom_Fields
    {
      public integer form_field_id { get; set; }
      public integer field_type_id { get; set; }
      public string api_name { get; set; }
      public string form_field_name { get; set; }
      public string form_value { get; set; }
    }

    public class Recurring_Order
    {
        public integer recurring_order_id { get; set; }
        public string identity_id { get; set; }
        public string created_date { get; set; }
        public integer order_status { get; set; }
        public string due_date { get; set; }
        public integer recurring_frequency_id { get; set; }
        public string amount { get; set; }
        public string billing_first_name { get; set; }
        public string billing_last_name { get; set; }
        public string billing_email { get; set; }
        public integer total_no_of_recurring_donations { get; set; }
        public integer total_no_of_active_recurring_donations { get; set; }
    }

    public class Member
    {
        public string member_identity_id { get; set; }
        public string member_first_name { get; set; }
        public string member_last_name { get; set; }
        public string member_email { get; set; }
        public string member_phone { get; set; }
        public string member_mailing_street { get; set; }
        public string member_mailing_city { get; set; }
        public string member_mailing_state { get; set; }
        public string member_mailing_postal_code { get; set; }
        public string member_mailing_country { get; set; }
        public string member_shipping_street { get; set; }
        public string member_shipping_city { get; set; }
        public string member_shipping_state { get; set; }
        public string member_shipping_postal_code { get; set; }
        public string member_shipping_country { get; set; }
        public string membership_program_name { get; set; }
        public string salesforce_membership_id { get; set; }
        public string membership_program_url { get; set; }
        public string membership_approval_date { get; set; }
        public string membership_valid_from { get; set; }
        public string membership_valid_to { get; set; }
        public string membership_order_id { get; set; }
    }

    public class Newsletter
    {
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }
        public string company { get; set; }
        public string lead_source { get; set; }
    }

    private static string memberCampaignStr = 'MEM';
    private static string fundraiserCampaignStr = 'FR';
    private static string donorCampaignStr = 'DNR';
    public static List<Campaign> campaignsToUpdateList = new List<Campaign>();    // Store Campaigns to update.
    public static List<Contact> contactsToUpdateList = new List<Contact>();    // Store opportunties to insert.
    public static List<Opportunity> opportunitiesToCreateList = new List<Opportunity>();    // Store opportunties to insert.
    public static List<Payment> paymentsToCreateList = new List<Payment>();    // Store payments to insert.
    public static List<CampaignMember> campaignMembersToCreateList = new List<CampaignMember>();    // Store campaign members to insert.
    public static List<string> createdOpportunityIDs = new List<string>();  
    public static Map<String, Opportunity> opptTypeNOppMap = new Map<String, Opportunity>();   // Store Opp Id and created opportunities.
    public static string membershipApprovalDate = '';

    public static SObject soContact = Schema.getGlobalDescribe().get('Contact').newSObject();

    @HttpPost
    global static void post() 
    {
        string namePrefix = 'UNITY - ';
        string sponsorDonationAmount = '0.00';
        string jsonResponse = '';
        string orderDescription = '';
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');

        Order newOrder = (Order)System.JSON.deserialize(RestContext.request.requestBody.toString(), Order.class);
        string websiteInfo =  newOrder.website_info + '%';
        boolean is_donor_id_field_present = false;        
        boolean is_donor_id_contact_present = false;
        boolean is_orderContact_present = false;
        string donorIDSelectQuery = '';
        integer orderItemCount = 0;
        integer distinctOrderItemTypeCount = 0;
        List<integer> orderItemTypesList = new List<integer>();

        Campaign parentCampaign; // The main Campaign that is the parent of the following 3 child Campaigns.
        Campaign memberCampaign; // The default Campaign that everyone will be a member of.
        Campaign fundraiserCampaign; // The Campaign used to track people who have fundraising pages and accept donations.
        Campaign donorCampaign; // This Campaign tracks all donations either to a fundraiser, Event or Campaign.
        Campaign untetheredFundraisingCampaign; // The main Campaign that is the parent of untethered fundraising pages (i.e. not linked to any event or campaign).
        Campaign fundraisingPageCampaign; // The Campaign that represents the evenico fundraising page (if applicable).
        Campaign fundraisingParentCampaign; // Parent campaign of the fundraising page
        string fundraisingCampaignType = 'Fundraising Page';    
        string fundraisingPageParentCampaign = '';
        string fundraisingPageCampaignID = '';
        string fundraisingPageCampaignStartDate = '';
        string fundraisingPageCampaignEndDate = '';
        string untetheredFundraisingCampaignName = 'Pixo Untethered Fundraising - ' + newOrder.website_name;
        string previousUntetheredFundCampName = 'Evenico Untethered Fundraising - ' + newOrder.website_name;
        List<String> customCampStatus = new List<String>();
        customCampStatus.add('Lapsed');
        customCampStatus.add('Pending Approval');

        if (newOrder.call_made_from == 'Order')
        {      
            Contact orderContact = null;
            List<Contact> donorIDContacts;
            Contact[] contacts;

            // Check if it is an admin order
            if (String.isNotBlank(newOrder.donor_id_api_name))
            {
                is_donor_id_field_present = doesFieldExist('Contact', newOrder.donor_id_api_name);
            }

            if (is_donor_id_field_present && String.isNotBlank(newOrder.api_salesforce_donor_id))
            {
                donorIDSelectQuery = 'SELECT ID, npsp__HHId__c, npe01__Type_of_Account__c, FirstName, LastName, Email, AccountID, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry, ' + newOrder.donor_id_api_name + ' FROM Contact WHERE '  +  newOrder.donor_id_api_name  + ' = \'' + newOrder.api_salesforce_donor_id + '\'';
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Donor ID Select Query: >>>>>>>>> ' + donorIDSelectQuery);

                donorIDContacts = Database.query(donorIDSelectQuery);

                if (!donorIDContacts.isEmpty()) // Existing Contact. 
                {
                    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Donor ID Select Query Result: >>>>>>>>> List size: ' + donorIDContacts.size());
                    if (donorIDContacts.size() > 0)
                    {
                        orderContact = donorIDContacts[0];
                        is_donor_id_contact_present = true;
                        is_orderContact_present = true;
                        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Donor ID Select Query Result: >>>>>>>>> Is NOT NULL >>>> Contact ID: ' + orderContact.ID + ' >>>> Email: ' + orderContact.Email);
                    }                 
                }
                else 
                {
                    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Donor ID Select Query Result: >>>>>>>>> IS EMPTY!');    
                }
            }            

            if (is_donor_id_field_present == false || is_donor_id_contact_present == false)
            {
                contacts = [SELECT ID, npsp__HHId__c, npe01__Type_of_Account__c, FirstName, LastName, Email, AccountID, 
                MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry FROM Contact
                WHERE Email = :newOrder.billing_email AND FirstName = :newOrder.billing_first_name AND LastName = :newOrder.billing_last_name];

                if(!contacts.isEmpty()) // Existing Contact. Update details.
                {
                    orderContact = contacts[0];
                    is_orderContact_present = true;
                    System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Existing Contact: >>>>>>>>> Based on First name, last name & email');  
                }
            }

            If(is_orderContact_present) // Existing Contact. Update details.
            {
                // Billing Address
                string updateContactBillingAddress = checkToUpdateAddress(orderContact.MailingStreet, orderContact.MailingCity, orderContact.MailingState, 
                                                orderContact.MailingPostalCode, orderContact.MailingCountry, newOrder.billing_street, newOrder.billing_city, 
                                                newOrder.billing_state, newOrder.billing_postcode, newOrder.billing_country);

                if (updateContactBillingAddress == 'Update')
                {
                    orderContact.MailingStreet = newOrder.billing_street;
                    orderContact.MailingCity = newOrder.billing_city;
                    orderContact.MailingState = newOrder.billing_state;
                    orderContact.MailingPostalCode = newOrder.billing_postcode;
                    orderContact.MailingCountry = newOrder.billing_country;
                }

                // Shipping Address
                string updateContactShippingAddress = checkToUpdateAddress(orderContact.OtherStreet, orderContact.OtherCity, orderContact.OtherState, 
                                                orderContact.OtherPostalCode, orderContact.OtherCountry, newOrder.shipping_street, newOrder.shipping_city, 
                                                newOrder.shipping_state, newOrder.shipping_postcode, newOrder.shipping_country);

                if (updateContactShippingAddress == 'Update')
                {
                    orderContact.OtherStreet = newOrder.shipping_street;
                    orderContact.OtherCity = newOrder.shipping_city;
                    orderContact.OtherState = newOrder.shipping_state;
                    orderContact.OtherPostalCode = newOrder.shipping_postcode;
                    orderContact.OtherCountry = newOrder.shipping_country;
                }

                if (String.isNotBlank(newOrder.billing_phone))
                {
                    orderContact.Phone = newOrder.billing_phone;
                }
                if (String.isNotBlank(newOrder.billing_fax))
                {
                    orderContact.Fax = newOrder.billing_fax;                          
                }

                // Check to see if the payment is on behalf of a company.
                if (newOrder.is_company && String.isNotBlank(newOrder.billing_company))
                {
                    // Check to see if the Account exists.
                    Account[] accounts = [SELECT ID FROM Account WHERE Name = :newOrder.billing_company];
                    Account account = null;

                    // Find or create a related Account.
                    If(!accounts.isEmpty()) {
                        account = accounts[0];
                    }
                    else
                    {
                        account = createAccount(newOrder.billing_company, null);
                        
                        try
                        {
                            System.debug(logginglevel.DEBUG, 'Inserted account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.insert(account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('account has been inserted in Salesforce!');
                            }
                            else
                            {
                                System.debug('account has not been inserted in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'Failed to insert account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert account"}}');
                            return;
                        }
                    }

                    // Finalize the Contact record by assigning the Account ID to Primary Affiliation.
                    // Check if npsp field "Primary Affiliation" is present
                    boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');
                    if (is_npsp_Primary_Affiliation_c_present)
                    {
                        orderContact.npsp__Primary_Affiliation__c = account.ID;                                
                    }
                }

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(orderContact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('orderContact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('orderContact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'Failed to update existing contact');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update existing contact"}}');
                    return;
                }
            }
            else 
            {
                // New or no Contact, process Account data.
                orderContact = createContact(
                    newOrder.identity_id,
                    null,
                    newOrder.billing_first_name, 
                    newOrder.billing_last_name, 
                    newOrder.billing_company, 
                    newOrder.billing_email, 
                    newOrder.billing_street, 
                    newOrder.billing_city, 
                    newOrder.billing_state, 
                    newOrder.billing_postcode, 
                    newOrder.billing_country, 
                    newOrder.billing_phone, 
                    newOrder.billing_fax,
                    newOrder.email_opt_in,
                    null, 
                    null, 
                    null,
                    newOrder.shipping_street,
                    newOrder.shipping_city,
                    newOrder.shipping_state,
                    newOrder.shipping_postcode,
                    newOrder.shipping_country
                );
                                    
                Boolean isCompany = newOrder.is_company;
                if (isCompany && String.isNotBlank(newOrder.billing_company))
                {
                    // Check to see if the Account exists.
                    Account[] accounts = [SELECT ID FROM Account WHERE Name = :newOrder.billing_company];
                    Account account = null;

                    // Find or create a related Account.
                    If(!accounts.isEmpty()) {
                        account = accounts[0];
                    }
                    else
                    {
                        account = createAccount(newOrder.billing_company, null);
                        
                        try
                        {
                            System.debug(logginglevel.DEBUG, 'Inserted account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.insert(account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('account has been inserted in Salesforce!');
                            }
                            else
                            {
                                System.debug('account has not been inserted in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'Failed to insert account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert account"}}');
                            return;
                        }
                    }

                    // Finalize the Contact record by assigning the Account ID to Primary Affiliation.
                    // Check if npsp field "Primary Affiliation" is present
                    boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');       
                    if (is_npsp_Primary_Affiliation_c_present)
                    {
                        orderContact.npsp__Primary_Affiliation__c = account.ID;                                
                    }
                }
                    
                // Validate & Insert the Contact record.
                if(validateContact(orderContact))
                {
                    try
                    {
                        System.debug(logginglevel.DEBUG, 'Insert contact');
                        /*
                        A few clients have Duplicate Rules activated for Contacts - 
                        (1) If a duplicate contact record is identified, the command "insert orderContact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                        (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                        */

                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult sr = Database.insert(orderContact, dml);
                        if (sr.isSuccess()) 
                        {
                            System.debug('orderContact contact has been inserted in Salesforce!');
                        }
                        else
                        {
                            System.debug('----------------------------------------------------------------- Order contact not inserted---------------------');
                            System.debug(sr.getErrors());
                            System.debug(sr.errors);
                            System.debug('orderContact contact has not been inserted in Salesforce!');
                        }            

                        // Retrieve the AccountID of the new contact to set on the orderContact for use when creating an Opportunity below.
                        Contact newContact = [SELECT ID, AccountID FROM Contact WHERE ID = :orderContact.ID LIMIT 1];
                        orderContact.AccountID = newContact.AccountID;
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to insert valid contact');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert valid contact"}}');
                        return;
                    }
                }
                else
                {
                    if(!isCompany)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to insert valid contact');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "Contact record must be created, but Contact data is invalid. Possible cause -> Required fields are missing: [LastName]", "stage": "insert invalid contact"}}');
                        return;                 
                    }
                }
            }
            
            // Case : If soft credit is not empty AND it wasn't a self sponsor donation : Create / Retrieve ContactID of the fundraiser
            string softCredit_contact_ID = null;
            Contact softCreditContact = null;

            if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) )
            {
                // Check if contact exists
                Contact[] exisiting_contacts = [SELECT ID, npsp__HHId__c, npe01__Type_of_Account__c, FirstName, LastName, Email, AccountID FROM Contact 
                WHERE Email = :newOrder.soft_credit.softCredit_email AND FirstName = :newOrder.soft_credit.softCredit_first_name AND LastName = :newOrder.soft_credit.softCredit_last_name];

                // If existing contact, retrieve the Contact ID of the contact to set on the opportunity contact role while creating it below
                if(!exisiting_contacts.isEmpty()) 
                {
                    softCreditContact = exisiting_contacts[0];
                    softCredit_contact_ID = softCreditContact.ID;
                }
                else
                {
                    // If not, create a new contact with the soft credit details
                    softCreditContact = createContact(
                        newOrder.Soft_Credit.softCredit_identity_id,
                        null,
                        newOrder.Soft_Credit.softCredit_first_name, 
                        newOrder.Soft_Credit.softCredit_last_name, 
                        null, 
                        newOrder.Soft_Credit.softCredit_email, 
                        newOrder.Soft_Credit.softCredit_street, 
                        newOrder.Soft_Credit.softCredit_city, 
                        newOrder.Soft_Credit.softCredit_state, 
                        newOrder.Soft_Credit.softCredit_postcode, 
                        newOrder.Soft_Credit.softCredit_country, 
                        newOrder.Soft_Credit.softCredit_phone, 
                        null,
                        true,
                        null, 
                        null, 
                        null,
                        newOrder.Soft_Credit.softCredit_shipping_street,
                        newOrder.Soft_Credit.softCredit_shipping_city,
                        newOrder.Soft_Credit.softCredit_shipping_state,
                        newOrder.Soft_Credit.softCredit_shipping_postcode,
                        newOrder.Soft_Credit.softCredit_shipping_country);                  

                    // Validate required fields and create Contact record
                    if(validateContact(softCreditContact))
                    {
                        try
                        {
                            /*
                            A few clients have Duplicate Rules activated for Contacts - 
                            (1) If a duplicate contact record is identified, the command "insert orderContact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                            (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                            */

                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult saveResult = Database.insert(softCreditContact, dml);
                            if (saveResult.isSuccess()) 
                            {
                                System.debug('softCreditContact contact has been inserted in Salesforce!');
                            }
                            else
                            {
                                System.debug('----------------------------------------------------------------- softCreditContact not inserted---------------------');
                                System.debug(saveResult.getErrors());
                                System.debug(saveResult.errors);
                                System.debug('softCreditContact contact has not been inserted in Salesforce!');
                            }

                            // Retrieve the ContactID of the new contact to set on opportunity contact role while creating it below
                            Contact newSC_Contact = [SELECT ID, AccountID FROM Contact WHERE ID = :softCreditContact.ID LIMIT 1];
                            softCredit_contact_ID = newSC_Contact.ID;
                        }
                        catch (System.DmlException e)
                        {
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert valid contact"}}');
                            return;
                        }
                    }
                }
            }

            // In Salesforce, Events and Campaigns from Evenico, all become Campaigns as there is no separate Event object at this stage.
            string campaignID = ''; // ID of the stored Campaign after DML has been completed.
            string campaignName = getCampaignNameValue(newOrder.items[0]);
            string campaignType = getCampaignTypeValue(newOrder.items[0]);
            string campaignStartDate = '';
            string campaignEndDate = '';
            string receivedID = string.valueOf(newOrder.items[0].event_campaign_id);
            string receivedSalesforceID = newOrder.items[0].salesforce_event_campaign_id;            
            string inMemoryParentCampaignName = 'In Memory';
            string inMemoryCampaignType = 'In Memory';
            string inMemoryPageCampaignStartDate = '';
            string inMemoryPageCampaignID = '';
            string membershipProgramCampaignID = '';
            string membershipCampaignType = 'Membership';
            
            Campaign inMemoryParentCampaign; // The main Campaign that is the parent of all in memory pages.
            Campaign inMemoryPageCampaign; // The Campaign that represents the in memory page in Evenico (if applicable).
            Campaign membershipProgramCampaign; // The Campaign that represents the membership program campaign in Pixo (if applicable).

            // Set the Start & End Date if available
            if (string.isNotBlank(campaignType))
            {
                if (campaignType == 'Event')    
                {
                    if (string.isNotBlank(newOrder.items[0].event_start_date))
                    {
                        campaignStartDate = newOrder.items[0].event_start_date; //(20/04/2015 12:22:09 AM)
                    }
                    if (string.isNotBlank(newOrder.items[0].event_end_date))
                    {
                        campaignEndDate = newOrder.items[0].event_end_date; 
                    }                    
                }
                else if (campaignType == 'Campaign')    // Not all campaigns will have a start & end date
                {
                    if (string.isNotBlank(newOrder.items[0].campaign_start_date))
                    {
                        campaignStartDate = newOrder.items[0].campaign_start_date; //(20/04/2015 12:22:09 AM)
                    }
                    if (string.isNotBlank(newOrder.items[0].campaign_end_date))
                    {
                        campaignEndDate = newOrder.items[0].campaign_end_date;
                    }
                }
            }

            // Retrieve or configure default Campaign structure. This is based on the received ID and Type, Type is important as Events and Campaigns in Evenico can share IDs, they are not unique across the two types of objects.
            if(!string.isBlank(receivedID))
            { 
                // Find or create the parent Campaign.
                parentCampaign = FindOrCreateCampaigns(res, campaignName, receivedID, receivedSalesforceID, campaignStartDate, campaignEndDate, 
                                                    campaignType, newOrder.items[0].campaign_url, websiteInfo, null, null, false, null, null, null, false, null, null);

                // Find or create the member Campaign.
                string memQueryId = receivedID + '-' + memberCampaignStr;
                string memSFQueryId = receivedSalesforceID + '-' + memberCampaignStr;                

                memberCampaign = FindOrCreateCampaigns(res, campaignName + ' (' + memberCampaignStr + ')', memQueryId, memSFQueryId, campaignStartDate, campaignEndDate, 
                                            campaignType, newOrder.items[0].campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                            false, null, null, null, false, null, null);

                // Find or create the fundraiser Campaign.
                string frQueryId = receivedID + '-' + fundraiserCampaignStr;
                string frSFQueryId = receivedSalesforceID + '-' + fundraiserCampaignStr;
                
                fundraiserCampaign = FindOrCreateCampaigns(res, campaignName + ' (' + fundraiserCampaignStr + ')', frQueryId, frSFQueryId, campaignStartDate, campaignEndDate, 
                                        campaignType, newOrder.items[0].campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null,
                                        false, null, null, null, false, null, null);
                fundraisingPageParentCampaign = fundraiserCampaign.ID;  // Retrieve the CampaignID to set on fundraising page campaign while creating it below (if it is a sponsor donation)

                // Find or create the donor Campaign.
                string dnrQueryId = receivedID + '-' + donorCampaignStr;
                string dnrSFQueryId = receivedSalesforceID + '-' + donorCampaignStr;
                
                donorCampaign = FindOrCreateCampaigns(res, campaignName + ' (' + donorCampaignStr + ')', dnrQueryId, dnrSFQueryId, campaignStartDate, campaignEndDate, 
                                        campaignType, newOrder.items[0].campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null,
                                        false, null, null, null, false, null, null);
            }

            string opportunityPrimaryCampaign = null;
            string orderItemTypeStr = newOrder.items[0].type_name;
            string sponsorDonTypeName = 'Sponsor Donation';
            string eventDonTypeName = 'Event Donation';
            string storeTypeName = 'Store';
            string generalDonTypeName = 'Donation';

            // Check if npsp field "Primary Contact" is present
            boolean is_npsp_Primary_Contact_c_present = doesFieldExist('Opportunity', 'npsp__Primary_Contact__c');

            // ------------------------------------------------------------- Split the order into multiple opportunities (if applicable) : Start

            // If the payment is on behalf of the company (is_company = true), the opportunity should be linked to the Organisational account & contact record
            // If it is by an individual (is_company = false), the opportuntiy should be linked to the Household account & contact record
            string opportunity_accountId = orderContact.AccountID;
            boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');
            if (is_npsp_Primary_Affiliation_c_present)
            {
                if (newOrder.is_company)
                {
                    if (String.isNotBlank(orderContact.npsp__Primary_Affiliation__c))
                    {
                        opportunity_accountId = orderContact.npsp__Primary_Affiliation__c;
                    }
                }                
            }
            
            string orderPrefix = '';
            if (string.isNotBlank(newOrder.order_prefix))
                orderPrefix = newOrder.order_prefix + ' - ';

            // Fetch all the order item details
            for (integer i=0; i < newOrder.items.size(); i++)
            {
                newOrder.items[i].is_processed = false;
                if (i == 0)
                {
                    orderDescription = newOrder.items[i].quantity + ' x ' + newOrder.items[i].details;
                }
                else 
                {
                    orderDescription = orderDescription + ', ' + newOrder.items[i].quantity + ' x ' + newOrder.items[i].details;
                }                
            }

            if (newOrder.items[0].type == 1)    // Donation
            {                
                // Just general donation
                Opportunity newDonationOpp = new Opportunity();

                newDonationOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newDonationOpp);

                //npe01__OppPayment__c newDonationPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newDonationPayment);

                // Update the recurring donation fields for the OrderContact
                if (newOrder.recurring_order_id != null)
                {
                    orderContact.Total_No_of_Recurring_Donations__c = string.valueOf(newOrder.total_no_of_recurring_donations);
                    orderContact.Total_No_of_Active_Recurring_Donations__c = string.valueOf(neworder.total_no_of_active_recurring_donations);
                    orderContact.Recurring_Donor_Status__c = 'Active';
                    orderContact.Lapsed_Date__c = null;
                    contactsToUpdateList.add(orderContact);
                }
            }
            else if (newOrder.items[0].type == 2)   // Event Registration ([order].event_id)
            {
                /*
                    (1) Event Registration
                    (2) Event Registration + Event Donation
                    (3) Event Registration + Store
                    (4) Event Registration + Sponsor Donation
                    (5) Event Registration + Event Donation + Store
                    (6) Event Registration + Event Donation + Sponsor Donation
                    (7) Event Registration + Store + Sponsor Donation
                    NOTE: Booking fee, Store and Shipping are attached to Event Registration
                */

                Opportunity newEventRegOpp = new Opportunity();
                Opportunity newEventRegSponDonOpp = new Opportunity();
                Opportunity newEventRegEventDonOpp = new Opportunity();
                Opportunity newEventRegStoreOpp = new Opportunity();
                string eventRegOrderDescription = '';

                Decimal sponsorDonOrderAmount = 0;
                Decimal sponsorDonOrderSubtotal = 0;
                Decimal sponsorDonOrderTaxAmount = 0;
                Decimal sponsorDonOrderDiscountAmount = 0;
                Boolean sponsorDonCreateOpp = false;
                string sponsorDonOrderDescription = '';
                string sponsorDonUrl = '';

                Decimal eventDonOrderAmount = 0;
                Decimal eventDonOrderSubtotal = 0;
                Decimal eventDonOrderTaxAmount = 0;
                Decimal eventDonOrderDiscountAmount = 0;
                Boolean eventDonCreateOpp = false;
                string eventDonOrderDescription = '';
                string eventDonUrl = '';

                Decimal storeOrderAmount = 0;
                Decimal storeOrderSubtotal = 0;
                Decimal storeOrderTaxAmount = 0;
                Decimal storeOrderDiscountAmount = 0;
                Boolean storeCreateOpp = false;
                string storeOrderDescription = '';

                if ((newOrder.str_distinct_order_item_types.contains('3')) || (newOrder.str_distinct_order_item_types.contains('10')) || (newOrder.str_distinct_order_item_types.contains('6')))  // Sponsor Donation | Event Donation | Store
                {
                    // Split the order into multiple opportunities

                    // Sponsor Donation
                    if (newOrder.str_distinct_order_item_types.contains('3'))
                    {
                        // Find or create the corresponding fundraising page campaign                
                        fundraisingPageCampaign = FindOrCreateCampaigns(res, newOrder.soft_credit.sponsor_page_name, string.valueOf(newOrder.soft_credit.sponsor_page_id), 
                                            newOrder.soft_credit.salesforce_sponsor_page_id, newOrder.soft_credit.sponsor_page_created_date, newOrder.soft_credit.sponsor_page_end_date, 
                                            fundraisingCampaignType, newOrder.soft_credit.sponsor_page_url, websiteInfo, fundraisingPageParentCampaign, softCredit_contact_ID, 
                                            false, newOrder.soft_credit.sponsor_donation_amount, null, newOrder.soft_credit.current_amount, newOrder.soft_credit.is_team, null, null);
                        fundraisingPageCampaignID = fundraisingPageCampaign.ID;
                
                        if (string.isNotBlank(fundraisingPageCampaignID)) {
                            opportunityPrimaryCampaign = fundraisingPageCampaignID;
                        }

                        for (integer j=0; j< newOrder.items.size(); j++)
                        {
                            if (newOrder.items[j].type == 3)
                            {
                                newOrder.items[j].is_processed = true;
                                SponsorDonCreateOpp = true;
                                sponsorDonUrl = newOrder.items[j].item_related_url;

                                sponsorDonOrderAmount = sponsorDonOrderAmount + Decimal.valueOf(newOrder.items[j].amount);
                                sponsorDonOrderSubtotal = sponsorDonOrderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                                sponsorDonOrderTaxAmount = sponsorDonOrderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                                sponsorDonOrderDiscountAmount = sponsorDonOrderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                                if (string.isBlank(sponsorDonOrderDescription))
                                {
                                    sponsorDonOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                                else 
                                {
                                    sponsorDonOrderDescription = sponsorDonOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                } 
                            }
                        }

                        if (SponsorDonCreateOpp)
                        {
                            newEventRegSponDonOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Sponsor Donation', 
                                String.valueOf(sponsorDonOrderAmount),
                                sponsorDonTypeName,
                                newOrder.completed_date, 
                                newOrder.id, 
                                sponsorDonOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                sponsorDonUrl,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(sponsorDonOrderDiscountAmount),
                                String.valueOf(sponsorDonOrderTaxAmount),
                                String.valueOf(sponsorDonOrderSubtotal),
                                null
                            );
                            opportunitiesToCreateList.add(newEventRegSponDonOpp);

                            //npe01__OppPayment__c newEventRegSponDonPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.items[j].amount, newOrder.completed_date, newOrder.Payment.type, newOrder.items[j].total_tax_amount);
                            //paymentsToCreateList.add(newEventRegSponDonPayment);
                        }
                        
                    }

                    // Event Donation
                    if (newOrder.str_distinct_order_item_types.contains('10'))
                    {
                        if (parentCampaign != null){
                            opportunityPrimaryCampaign = parentCampaign.Id;
                        }

                        for (integer j=0; j< newOrder.items.size(); j++)
                        {
                            if (newOrder.items[j].type == 10)
                            {
                                newOrder.items[j].is_processed = true;
                                eventDonCreateOpp = true;
                                eventDonUrl = newOrder.items[j].item_related_url;

                                eventDonOrderAmount = eventDonOrderAmount + Decimal.valueOf(newOrder.items[j].amount);
                                eventDonOrderSubtotal = eventDonOrderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                                eventDonOrderTaxAmount = eventDonOrderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                                eventDonOrderDiscountAmount = eventDonOrderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                                if (string.isBlank(eventDonOrderDescription))
                                {
                                    eventDonOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                                else 
                                {
                                    eventDonOrderDescription = eventDonOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                            }
                        }

                        if (eventDonCreateOpp)
                        {
                            newEventRegEventDonOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Event Donation', 
                                String.valueOf(eventDonOrderAmount), 
                                eventDonTypeName,
                                newOrder.completed_date, 
                                newOrder.id, 
                                eventDonOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                eventDonUrl,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                null, //fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(eventDonOrderDiscountAmount), 
                                String.valueOf(eventDonOrderTaxAmount), 
                                String.valueOf(eventDonOrderSubtotal), 
                                null
                            );
                            opportunitiesToCreateList.add(newEventRegEventDonOpp);

                            //npe01__OppPayment__c newEventRegSponDonPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.items[j].amount, newOrder.completed_date, newOrder.Payment.type, newOrder.items[j].total_tax_amount);
                            //paymentsToCreateList.add(newEventRegSponDonPayment);
                        }
                        
                    }

                    // Store
                    if (newOrder.str_distinct_order_item_types.contains('6'))
                    {
                        if (parentCampaign != null){
                            opportunityPrimaryCampaign = parentCampaign.Id;
                        }

                        for (integer j=0; j< newOrder.items.size(); j++)
                        {
                            if (newOrder.items[j].type == 6)
                            {
                                newOrder.items[j].is_processed = true;

                                storeCreateOpp = true;

                                storeOrderAmount = storeOrderAmount + Decimal.valueOf(newOrder.items[j].amount);
                                storeOrderSubtotal = storeOrderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                                storeOrderTaxAmount = storeOrderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                                storeOrderDiscountAmount = storeOrderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                                if (string.isBlank(storeOrderDescription))
                                {
                                    storeOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                                else 
                                {
                                    storeOrderDescription = storeOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                            }
                        }

                        if (storeCreateOpp)
                        {
                            newEventRegStoreOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Store', 
                                String.valueOf(storeOrderAmount), 
                                storeTypeName,
                                newOrder.completed_date, 
                                newOrder.id, 
                                storeOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                newOrder.order_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                null, //fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(storeOrderDiscountAmount),
                                String.valueOf(storeOrderTaxAmount),
                                String.valueOf(storeOrderSubtotal),
                                null
                            );
                            opportunitiesToCreateList.add(newEventRegStoreOpp);

                            //npe01__OppPayment__c newEventRegSponDonPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.items[j].amount, newOrder.completed_date, newOrder.Payment.type, newOrder.items[j].total_tax_amount);
                            //paymentsToCreateList.add(newEventRegSponDonPayment);
                        }
                        
                    }

                    Decimal orderAmount = 0;
                    Decimal orderSubtotal = 0;
                    Decimal orderTaxAmount = 0;
                    Decimal orderDiscountAmount = 0;
                    Boolean createOpp = false;

                    for (integer j = 0; j<newOrder.items.size(); j++)
                    {
                        System.debug('-------------------------------------- Event Registration - Split ------ ' + newOrder.items[j].details);
                        System.debug('-------------------------------------- Event Registration - Split >> Is Processed? ------ ' + newOrder.items[j].is_processed);
                        // All other order items
                        if (newOrder.items[j].is_processed == false)
                        {
                            System.debug('-------------------------------------- Event Registration - Split  >>>>> Processing Order Item ------ ' + newOrder.items[j].details);
                            newOrder.items[j].is_processed = true;
                            createOpp = true;
                            orderAmount = orderAmount + Decimal.valueOf(newOrder.items[j].amount);
                            orderSubtotal = orderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                            orderTaxAmount = orderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                            orderDiscountAmount = orderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                            if (string.isBlank(eventRegOrderDescription))
                            {
                                eventRegOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                            }
                            else 
                            {
                                eventRegOrderDescription = eventRegOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                            }  
                        }

                        if (parentCampaign != null){
                            opportunityPrimaryCampaign = parentCampaign.Id;
                        }
                    }

                    System.debug('-------------------------------------- Event Registration - Split ------ Create Opp? ' + createOpp);
                    System.debug('-------------------------------------- Event Registration - Split ------ Order Amount' + String.valueOf(orderAmount));
                    System.debug('-------------------------------------- Event Registration - Split ------ Order Discount Amount' + String.valueOf(orderDiscountAmount));
                    System.debug('-------------------------------------- Event Registration - Split ------ Order Tax Amount' + String.valueOf(orderTaxAmount));
                    System.debug('-------------------------------------- Event Registration - Split ------ Order Subtotal Amount' + String.valueOf(orderSubtotal));

                    if (createOpp)
                    {
                        newEventRegOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Event Registration', 
                                String.valueOf(orderAmount), 
                                newOrder.items[0].type_name,
                                newOrder.completed_date, 
                                newOrder.id, 
                                eventRegOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                newOrder.items[0].item_related_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                null, //fundraisingPageCampaignID,
                                '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(orderDiscountAmount),
                                String.valueOf(orderTaxAmount),
                                String.valueOf(orderSubtotal),
                                newOrder.no_of_event_reg_tickets
                            );
                        opportunitiesToCreateList.add(newEventRegOpp);

                        //npe01__OppPayment__c newEventRegPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, orderAmount, newOrder.completed_date, newOrder.Payment.type, orderTaxAmount);
                        //paymentsToCreateList.add(newEventRegPayment);
                    }
                }
                else 
                {
                    // No need to split the order
                    opportunityPrimaryCampaign = parentCampaign.Id;

                    newEventRegOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            newOrder.no_of_event_reg_tickets
                        );
                    
                    opportunitiesToCreateList.add(newEventRegOpp);
                    
                    //npe01__OppPayment__c newEventRegPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                    //paymentsToCreateList.add(newEventRegPayment);
                }
            }
            else if (newOrder.items[0].type == 3)   // Sponsor Donation
            {
                Opportunity newSponsorDonationOpp = new Opportunity();
                if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) && (String.isNotBlank(newOrder.soft_credit.salesforce_sponsor_page_id)) )
                {
                    // Find or create Evenico Untethered Fundraising Campaign
                    untetheredFundraisingCampaign = FindOrCreateCampaigns(res, untetheredFundraisingCampaignName, null, null, null, null, 
                                        fundraisingCampaignType, newOrder.website_info, websiteInfo, null, null, 
                                        true, null, null, null, false, null, previousUntetheredFundCampName);

                    // Check if fundraising page is linked to an event or campaign
                    if (String.isBlank(fundraisingPageParentCampaign))
                    {
                        fundraisingPageParentCampaign = untetheredFundraisingCampaign.ID;   
                    }

                    // Find or create the corresponding fundraising page campaign                
                    fundraisingPageCampaign = FindOrCreateCampaigns(res, newOrder.soft_credit.sponsor_page_name, String.valueOf(newOrder.soft_credit.sponsor_page_id), newOrder.soft_credit.salesforce_sponsor_page_id, 
                            newOrder.soft_credit.sponsor_page_created_date, newOrder.soft_credit.sponsor_page_end_date, fundraisingCampaignType, newOrder.soft_credit.sponsor_page_url, 
                            websiteInfo, fundraisingPageParentCampaign, softCredit_contact_ID, 
                            false, newOrder.soft_credit.sponsor_donation_amount, null, neworder.soft_credit.current_amount, newOrder.soft_credit.is_team, null, null);
                    fundraisingPageCampaignID = fundraisingPageCampaign.ID;
                
                    if (string.isNotBlank(fundraisingPageCampaignID)) {
                        opportunityPrimaryCampaign = fundraisingPageCampaignID;
                    }

                    newSponsorDonationOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                    opportunitiesToCreateList.add(newSponsorDonationOpp);

                    //npe01__OppPayment__c newSponsorDonationPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                    //paymentsToCreateList.add(newSponsorDonationPayment);

                    // Campaign Members
                }
            }
            else if (newOrder.items[0].type == 4)   // Campaign Donation
            {
                // Just campaign donation
                Opportunity newCampaignDonationOpp = new Opportunity();                
                opportunityPrimaryCampaign = parentCampaign.Id;

                newCampaignDonationOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newCampaignDonationOpp);

                //npe01__OppPayment__c newCampaignDonationPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newCampaignDonationPayment);

                // Update the recurring donation fields for the OrderContact
                if (newOrder.recurring_order_id != null)
                {
                    orderContact.Total_No_of_Recurring_Donations__c = string.valueOf(newOrder.total_no_of_recurring_donations);
                    orderContact.Total_No_of_Active_Recurring_Donations__c = string.valueOf(neworder.total_no_of_active_recurring_donations);
                    orderContact.Recurring_Donor_Status__c = 'Active';
                    orderContact.Lapsed_Date__c = null;
                    contactsToUpdateList.add(orderContact);
                }

                // Campaign Member
            }
            else if (newOrder.items[0].type == 6)   // Store
            {
                Opportunity newStoreOpp = new Opportunity();                
                opportunityPrimaryCampaign = null;

                newStoreOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.order_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newStoreOpp);

                //npe01__OppPayment__c newStorePayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newStorePayment);
            }
            else if (newOrder.items[0].type == 7)   // Membership ([order].membership_option_id)
            {
                /*
                    (1) Membership
                    (2) Membership + General Donation
                    (3) Membership + Store
                    (4) Membership + General Donation + Store
                */

                Opportunity newMembershipOpp = new Opportunity();
                Opportunity newMembershipGeneralDonationOpp = new Opportunity();
                Opportunity newMembershipStoreOpp = new Opportunity(); 
                string membershipOrderDescription = '';

                Decimal storeOrderAmount = 0;
                Decimal storeOrderSubtotal = 0;
                Decimal storeOrderTaxAmount = 0;
                Decimal storeOrderDiscountAmount = 0;
                Boolean storeCreateOpp = false;
                string storeOrderDescription = '';
                
                Decimal generalDonOrderAmount = 0;
                Decimal generalDonOrderSubtotal = 0;
                Decimal generalDonOrderTaxAmount = 0;
                Decimal generalDonOrderDiscountAmount = 0;
                Boolean generalDonCreateOpp = false;
                string generalDonOrderDescription = '';

                if (string.isNotBlank(newOrder.items[0].membership_program_name))
                {
                    membershipProgramCampaign = FindOrCreateCampaigns(res, newOrder.items[0].membership_program_name, null, newOrder.items[0].salesforce_membership_id, 
                            null, null, membershipCampaignType, newOrder.items[0].membership_program_url, websiteInfo, null, null, false, null, null, null, false, customCampStatus, null);
                    membershipProgramCampaignID = membershipProgramCampaign.ID;
                }

                // Check if the membership requires admin approval
                if (string.isNotBlank(newOrder.items[0].membership_approval_date))
                    membershipApprovalDate = newOrder.items[0].membership_approval_date.substring(0, newOrder.items[0].membership_approval_date.indexOf(' ')); 

                if (string.isNotBlank(membershipProgramCampaignID))
                {
                    opportunityPrimaryCampaign = membershipProgramCampaignID;
                }

                if (newOrder.str_distinct_order_item_types.contains('1') || newOrder.str_distinct_order_item_types.contains('6'))   // General Donation | Store
                {
                    // Split the order into multiple opportunities

                    // General Donation
                    if (newOrder.str_distinct_order_item_types.contains('1'))
                    {
                        for (integer j=0; j< newOrder.items.size(); j++)
                        {
                            // General Donation
                            if (newOrder.items[j].type == 1)
                            {
                                newOrder.items[j].is_processed = true;

                                generalDonCreateOpp = true;

                                generalDonOrderAmount = generalDonOrderAmount + Decimal.valueOf(newOrder.items[j].amount);
                                generalDonOrderSubtotal = generalDonOrderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                                generalDonOrderTaxAmount = generalDonOrderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                                generalDonOrderDiscountAmount = generalDonOrderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                                if (string.isBlank(generalDonOrderDescription))
                                {
                                    generalDonOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                                else 
                                {
                                    generalDonOrderDescription = generalDonOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                            }
                        }

                        if (generalDonCreateOpp)
                        {
                            newMembershipGeneralDonationOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Donation', 
                                String.valueOf(generalDonOrderAmount),
                                generalDonTypeName,
                                newOrder.completed_date, 
                                newOrder.id, 
                                generalDonOrderDescription,
                                null,//opportunityPrimaryCampaign,
                                null,
                                null,
                                newOrder.order_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                null, //fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(generalDonOrderDiscountAmount),
                                String.valueOf(generalDonOrderTaxAmount),
                                String.valueOf(generalDonOrderSubtotal),
                                null
                            );
                            opportunitiesToCreateList.add(newMembershipGeneralDonationOpp);

                            //npe01__OppPayment__c newMembershipGeneralDonationPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.items[j].amount, newOrder.completed_date, newOrder.Payment.type, newOrder.items[j].total_tax_amount);
                            //paymentsToCreateList.add(newMembershipGeneralDonationPayment);
                        }
                        
                    }

                    // Store
                    if (newOrder.str_distinct_order_item_types.contains('6'))
                    {
                        for (integer j=0; j< newOrder.items.size(); j++)
                        {
                            if (newOrder.items[j].type == 6)
                            {
                                newOrder.items[j].is_processed = true;

                                storeCreateOpp = true;

                                storeOrderAmount = storeOrderAmount + Decimal.valueOf(newOrder.items[j].amount);
                                storeOrderSubtotal = storeOrderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                                storeOrderTaxAmount = storeOrderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                                storeOrderDiscountAmount = storeOrderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                                if (string.isBlank(storeOrderDescription))
                                {
                                    storeOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                                else 
                                {
                                    storeOrderDescription = storeOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                                }
                            }
                        }

                        if (storeCreateOpp)
                        {
                            newMembershipStoreOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Store', 
                                String.valueOf(storeOrderAmount),
                                storeTypeName,
                                newOrder.completed_date, 
                                newOrder.id, 
                                storeOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                newOrder.order_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                null, //fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                null,
                                null,
                                null,
                                String.valueOf(storeOrderDiscountAmount),
                                String.valueOf(storeOrderTaxAmount),
                                String.valueOf(storeOrderSubtotal),
                                null
                            );
                            opportunitiesToCreateList.add(newMembershipStoreOpp);

                            //npe01__OppPayment__c newEventRegSponDonPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.items[j].amount, newOrder.completed_date, newOrder.Payment.type, newOrder.items[j].total_tax_amount);
                            //paymentsToCreateList.add(newEventRegSponDonPayment);
                        }                        
                    }

                    Decimal orderAmount = 0;
                    Decimal orderSubtotal = 0;
                    Decimal orderTaxAmount = 0;
                    Decimal orderDiscountAmount = 0;
                    Boolean createOpp = false;

                    for (integer j = 0; j<newOrder.items.size(); j++)
                    {
                        // All other order items
                        if (newOrder.items[j].is_processed == false)
                        {
                            newOrder.items[j].is_processed = true;
                            createOpp = true;
                            orderAmount = orderAmount + Decimal.valueOf(newOrder.items[j].amount);
                            orderSubtotal = orderSubtotal + Decimal.valueOf(newOrder.items[j].amount_subtotal);
                            orderTaxAmount = orderTaxAmount + Decimal.valueOf(newOrder.items[j].total_tax_amount);
                            orderDiscountAmount = orderDiscountAmount + Decimal.valueOf(newOrder.items[j].total_discount_amount);
                            if (string.isBlank(membershipOrderDescription))
                            {
                                membershipOrderDescription = newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                            }
                            else 
                            {
                                membershipOrderDescription = membershipOrderDescription + ', ' + newOrder.items[j].quantity + ' x ' + newOrder.items[j].details;
                            }  
                        }
                    }

                    if (createOpp)
                    {
                        newMembershipOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id + ' - Membership', 
                                String.valueOf(orderAmount), 
                                newOrder.items[0].type_name,
                                newOrder.completed_date, 
                                newOrder.id, 
                                membershipOrderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                newOrder.items[0].item_related_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                fundraisingPageCampaignID,
                                '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                newOrder.items[0].membership_valid_from,
                                newOrder.items[0].membership_valid_to,
                                newOrder.items[0].membership_origin,
                                String.valueOf(orderDiscountAmount),
                                String.valueOf(orderTaxAmount),
                                String.valueOf(orderSubtotal),
                                null
                            );
                        opportunitiesToCreateList.add(newMembershipOpp);

                        //npe01__OppPayment__c newMembershipPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, orderAmount, newOrder.completed_date, newOrder.Payment.type, orderTaxAmount);
                        //paymentsToCreateList.add(newMembershipPayment);
                    }
                }
                else 
                {
                    // No need to split order
                    newMembershipOpp = createOpportunity(
                                opportunity_accountId,
                                namePrefix + orderPrefix + newOrder.id, 
                                newOrder.amount, 
                                orderItemTypeStr,
                                newOrder.completed_date, 
                                newOrder.id, 
                                orderDescription,
                                opportunityPrimaryCampaign,
                                newOrder.items[0].membership_level,
                                newOrder.items[0].membership_frequency,
                                newOrder.related_url,
                                is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                                fundraisingPageCampaignID,
                                (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                                newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                                newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                                newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                                newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                                newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                                newOrder.is_admin_order,
                                newOrder.custom_field_name,
                                newOrder.custom_field_value,
                                newOrder.items[0].membership_valid_from,
                                newOrder.items[0].membership_valid_to,
                                newOrder.items[0].membership_origin,
                                newOrder.discount_amount,
                                newOrder.gst,
                                newOrder.subtotal_amount,
                                null
                            );
                    opportunitiesToCreateList.add(newMembershipOpp);

                    //npe01__OppPayment__c newMembershipPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                    //paymentsToCreateList.add(newMembershipPayment);
                }
            }
            else if (newOrder.items[0].type == 9)   // In Memory Donation
            {
                Opportunity newInMemoryOpp = new Opportunity();   

                // Find or create In Memory Parent Campaign
                inMemoryParentCampaign = FindOrCreateCampaigns(res, inMemoryParentCampaignName, null, null, newOrder.soft_credit.in_memory_page_created_date, null, 
                                    inMemoryCampaignType, newOrder.website_info, websiteInfo, null, null, true, null, null, null, false, null, null);

                inMemoryPageCampaign = FindOrCreateCampaigns(res, newOrder.soft_credit.in_memory_page_name, String.valueOf(newOrder.soft_credit.in_memory_page_id), newOrder.soft_credit.salesforce_in_memory_page_id, 
                                    newOrder.soft_credit.in_memory_page_created_date, null, inMemoryCampaignType, newOrder.items[0].campaign_url, websiteInfo, 
                                    inMemoryParentCampaign.ID, softCredit_contact_ID, false, null, null, newOrder.soft_credit.current_amount, false, null, null);
                inMemoryPageCampaignID = inMemoryPageCampaign.ID; // Retrieve the CampaignID to set on primary campaign source while creating opportunity below                      

                if (string.isNotBlank(inMemoryPageCampaignID)) {
                    opportunityPrimaryCampaign = inMemoryPageCampaignID;
                }

                newInMemoryOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newInMemoryOpp);

                //npe01__OppPayment__c newInMemoryPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newInMemoryPayment);
                
                // Campaign Member
            }
            else if (newOrder.items[0].type == 10)   // Event Donation
            {
                Opportunity newEventDonationOpp = new Opportunity();

                if (parentCampaign != null){
                    opportunityPrimaryCampaign = parentCampaign.Id;
                }

                newEventDonationOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newEventDonationOpp);

                //npe01__OppPayment__c newEventDonationPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newEventDonationPayment);

                // Campaign Member
            }
            else 
            {
                // Others eg. Free form
                // Create Opportunity
                Opportunity newOtherOpp = new Opportunity();
                newOtherOpp = createOpportunity(
                            opportunity_accountId,
                            namePrefix + orderPrefix + newOrder.id, 
                            newOrder.amount, 
                            orderItemTypeStr,
                            newOrder.completed_date, 
                            newOrder.id, 
                            orderDescription,
                            opportunityPrimaryCampaign,
                            newOrder.items[0].membership_level,
                            newOrder.items[0].membership_frequency,
                            newOrder.related_url,
                            is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                            fundraisingPageCampaignID,
                            (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount : '0.00',
                            newOrder.recurring_order_id != null ? newOrder.recurring_order_id : null, 
                            newOrder.recurring_frequency_id != null ? newOrder.recurring_frequency_id : null, 
                            newOrder.recurring_initial_date != null ? newOrder.recurring_initial_date : null, 
                            newOrder.recurring_number != null ? newOrder.recurring_number : null, 
                            newOrder.recurring_order_url != null ? newOrder.recurring_order_url : null,
                            newOrder.is_admin_order,
                            newOrder.custom_field_name,
                            newOrder.custom_field_value,
                            newOrder.items[0].membership_valid_from,
                            newOrder.items[0].membership_valid_to,
                            newOrder.items[0].membership_origin,
                            newOrder.discount_amount,
                            newOrder.gst,
                            newOrder.subtotal_amount,
                            null
                        );
                opportunitiesToCreateList.add(newOtherOpp);

                //npe01__OppPayment__c newOtherPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //paymentsToCreateList.add(newOtherPayment);

            }

            // update campaigns - campaignsToUpdateList
            if (campaignsToUpdateList != null && campaignsToUpdateList.size()>0)
            {
                // Update campaign data.
                for(Campaign c : campaignsToUpdateList)
                {
                    try
                    {
                        update c;
                        System.debug(logginglevel.DEBUG, 'Updated parent or child campaign successfully - ' + c.name);
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to update parent or child campaign - ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign - "' + c.name + '}}');
                        return;
                    }
                }
            } 

            // Process Campaign Member logic as follows:
            for (integer i=0; i < newOrder.items.size(); i++)
            {
                Items item = newOrder.items[i];
                // (1) MEM: Registrations become members.
                if(item.type == 2) // Event Registration
                {
                    if(memberCampaign != null)
                    {
                        createCampaignMember(memberCampaign, orderContact, null);
                        System.debug(logginglevel.DEBUG, 'Added campaign member to member campaign');
                    }
                }

                // (2) DNR: Every Contact where the Opportunity has a Type of Sponsor Donation (3), Campaign Donation (4) or Event Donation (10).
                if(
                    item.type == 3 ||   // Sponsor Donation
                    item.type == 4 ||   // Campaign Donation
                    item.type == 10     // Event Donation
                )
                {
                    if(donorCampaign != null)
                    {
                        createCampaignMember(donorCampaign, orderContact, null);
                        System.debug(logginglevel.DEBUG, 'Added campaign member to donor campaign');
                    }
                }
            }

            // (3) FR: Every Campaign related soft credit Contact, is a fundraiser Campaign Member.
            if(softCreditContact != null && fundraiserCampaign != null)
            {
                createCampaignMember(fundraiserCampaign, softCreditContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to fundraiser campaign');
            }

            // (4) Fundraising Page Campaign: Every sponsor donor, is a member of the corresponding Fundraising Page Campaign
            if (softCreditContact != null && fundraisingPageCampaign != null && orderContact != null)
            {
                createCampaignMember(fundraisingPageCampaign, orderContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to fundraising page campaign');
            }

            // (5) In Memory (Parent) Campaign: Every in memory page owner, is a member of the "In Memory" parent campaign
            if (softCreditContact != null && inMemoryParentCampaign != null && orderContact != null)
            {
                createCampaignMember(inMemoryParentCampaign, softCreditContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to in memory (parent) campaign');
            }

            // (6) Membership Program Campaign: Check if contact is an existing member and if the status is "Lapsed"
            if (membershipProgramCampaignID != null && membershipProgramCampaign != null)
            {
                CampaignMember[] existing_campaign_member_contacts = [SELECT ID, CampaignId, ContactId, CreatedById, CreatedDate, FirstRespondedDate, HasResponded, IsDeleted, LastModifiedById, LastModifiedDate, Status, SystemModstamp 
                                    FROM CampaignMember WHERE CampaignId = :membershipProgramCampaign.ID AND ContactId = :orderContact.ID];
                if (existing_campaign_member_contacts != null && existing_campaign_member_contacts.size() > 0)
                {
                    CampaignMember existing_campaign_member_contact =  existing_campaign_member_contacts[0];
                    System.debug('>>>>>>>>>> Existing camp member - Membership approval date: ' + membershipApprovalDate);
                    System.debug('>>>>>>>>>> Existing camp member - Current membership status: ' + existing_campaign_member_contact.Status);
                    //if (existing_campaign_member_contact.Status.toLowerCase() == 'lapsed')
                    //{
                        // Check if the membership requires admin approval
                        if (string.isBlank(membershipApprovalDate))
                        {
                            // Update the status 
                            existing_campaign_member_contact.Status = 'Pending Approval';
                            System.debug(logginglevel.DEBUG, 'Membership requires admin approval');
                        }
                        else 
                        {
                            // Update the status to "Responded"
                            existing_campaign_member_contact.Status = 'Responded';
                            System.debug(logginglevel.DEBUG, 'Membership status - responded');
                        }                        
                        
                        try 
                        {
                            update existing_campaign_member_contact;
                            System.debug(logginglevel.DEBUG, 'Updated existing campaign member status successfully');
                        } 
                        catch (DmlException e) {
                            System.debug(logginglevel.ERROR, 'Failed to update campaign member status ' + formatDmlException(e));
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign member status"}}');
                            return;   
                        }
                    //}
                }
                else 
                {
                    System.debug('>>>>>>>>>> New camp member - Membership approval date: ' + membershipApprovalDate);
                    if (string.isBlank(membershipApprovalDate)) // If the membership has been approved, there will be an approval date
                    {
                        createCampaignMember(membershipProgramCampaign, orderContact, 'Pending Approval');
                        System.debug(logginglevel.DEBUG, 'Added campaign member to membership program campaign - requires admin approval');
                    }
                    else 
                    {                        
                        createCampaignMember(membershipProgramCampaign, orderContact, null);
                        System.debug(logginglevel.DEBUG, 'Added campaign member to membership program campaign');
                    }
                }
            }

            // insert opportunities - opportunitiesToCreateList
            if (opportunitiesToCreateList != null && opportunitiesToCreateList.size()>0)
            {
                // Insert opportunity data.
                for(Opportunity opp : opportunitiesToCreateList)
                {
                    try
                    {
                        insert opp;
                        createdOpportunityIDs.add(opp.Id);
                        opptTypeNOppMap.put(opp.Id, opp);
                        System.debug(logginglevel.DEBUG, 'Created opportunity successfully - ' + opp.name + ' >>>>>>>>>>> Opporutnity type: ' + opp.Type);
                        System.debug(logginglevel.DEBUG, '---------- Opportunity Type and Opportunity Mapping size ----------- ' + opptTypeNOppMap.size());

                        npe01__OppPayment__c newPayment = createPayment(opp.ID, newOrder.Payment.ref_id, String.valueOf(opp.amount), newOrder.completed_date, newOrder.Payment.type, String.valueOf(opp.Total_Tax__c));
                        insert newPayment;
                        System.debug(logginglevel.DEBUG, 'Created payment successfully - ' + newPayment.id);
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to create opporutnity and payment - ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert opportunity and payemnt - "' + opp.name + '}}');
                        return;
                    }
                }
            }

            // insert payments  - paymentsToCreateList
            /*if (paymentsToCreateList != null && paymentsToCreateList.size()>0)
            {
                // Insert payment data.
                for(npe01__OppPayment__c pay : paymentsToCreateList)
                {
                    try
                    {
                        insert pay;
                        System.debug(logginglevel.DEBUG, 'Created payment successfully - ' + pay.name);
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to create payment - ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert payment - "' + pay.name + '}}');
                        return;
                    }
                }
            }*/

            // update contacts - contactsToUpdateList
            if (contactsToUpdateList != null && contactsToUpdateList.size()>0)
            {
                for(Contact c : contactsToUpdateList)
                {
                    try
                    {
                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult sr = Database.update(c, dml);
                        if (sr.isSuccess()) 
                        {
                            System.debug('Recurring donation fields - orderContact contact has been updated in Salesforce!');
                        }
                        else
                        {
                            System.debug('Recurring donation fields - orderContact contact has not been updated in Salesforce!');
                        }
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to update existing contact - Recurring donation fields - ' + c.Id);
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update existing contact - Recurring donation fields - ' + c.Id + '"}}');
                        return;
                    }
                }
            }
                


            // ------------------------------------------------------------- Split the order into multiple opportunities (if applicable) : End





            

            

            // If it is a sponsor donation, find or create untethered fundraising campaign & fundraising page campaign
            /*if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) && (String.isNotBlank(newOrder.soft_credit.salesforce_sponsor_page_id)) )
            {
                // Find or create Evenico Untethered Fundraising Campaign
                Campaign[] untetheredFundraisingCampaigns = [SELECT ID, Name, Type, External_System_Link__c, External_System_Name__c FROM Campaign
                WHERE (NAME = :untetheredFundraisingCampaignName AND Type = :fundraisingCampaignType AND External_System_Name__c = 'UNITY')]; // No External ID here.

                if(untetheredFundraisingCampaigns.isEmpty())
                {
                    untetheredFundraisingCampaign = createCampaign(res, untetheredFundraisingCampaignName, fundraisingCampaignType, null, newOrder.website_info, null, null, null, null, null, false, null, null);
                }
                else
                {
                    untetheredFundraisingCampaign = untetheredFundraisingCampaigns[0]; 
                }

                // Check if fundraising page is linked to an event or campaign
                if (String.isBlank(fundraisingPageParentCampaign))
                {
                    fundraisingPageParentCampaign = untetheredFundraisingCampaign.ID;   
                }

                // Find or create the corresponding fundraising page campaign
                Campaign[] fundraisingPageCampaigns = [SELECT ID, Name, Type, External_ID__c, Total_Value_of_Fundraising_Page__c FROM Campaign
                WHERE ((External_ID__c = :newOrder.soft_credit.salesforce_sponsor_page_id))];

                if (string.isNotBlank(newOrder.soft_credit.sponsor_donation_amount))
                {
                    sponsorDonationAmount = newOrder.soft_credit.sponsor_donation_amount;
                }

                if(fundraisingPageCampaigns.isEmpty())
                {
                    if (string.isNotBlank(newOrder.soft_credit.sponsor_page_created_date))
                    {
                        fundraisingPageCampaignStartDate = newOrder.soft_credit.sponsor_page_created_date.substring(0, newOrder.soft_credit.sponsor_page_created_date.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    }

                    if (string.isNotBlank(newOrder.soft_credit.sponsor_page_end_date))
                    {
                        fundraisingPageCampaignEndDate = newOrder.soft_credit.sponsor_page_end_date.substring(0, newOrder.soft_credit.sponsor_page_end_date.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    }
                    
                    fundraisingPageCampaign = createCampaign(res, newOrder.soft_credit.sponsor_page_name, fundraisingCampaignType, newOrder.soft_credit.salesforce_sponsor_page_id, 
                                            newOrder.soft_credit.sponsor_page_url, fundraisingPageParentCampaign, fundraisingPageCampaignStartDate, 
                                            fundraisingPageCampaignEndDate, softCredit_contact_ID, newOrder.soft_credit.sponsor_donation_amount, neworder.soft_credit.is_team, 
                                            newOrder.soft_credit.current_amount, null);
                    fundraisingPageCampaignID = fundraisingPageCampaign.ID; // Retrieve the CampaignID to set on fundraising campaign while creating opportunity below (if it is a sponsor donation)                       
                    
                }
                else
                {
                    fundraisingPageCampaign = fundraisingPageCampaigns[0];
                    fundraisingPageCampaignID = fundraisingPageCampaign.ID; // Retrieve the CampaignID to set on fundraising campaign while creating opportunity below (if it is a sponsor donation)                       

                    if(fundraisingPageCampaign.Name != newOrder.soft_credit.sponsor_page_name || Decimal.valueOf(newOrder.soft_credit.sponsor_donation_amount) > 0)
                    {
                        fundraisingPageCampaign.Name = newOrder.soft_credit.sponsor_page_name;
                        System.debug('Fundraising Page Campaign - Total Value of Fundraisign Page : ' + fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c);
                        if (fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c == null || fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c == 0)
                        {
                            fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c = Decimal.valueOf(newOrder.soft_credit.sponsor_donation_amount);
                        }
                        else 
                        {    
                            fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c = fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c + Decimal.valueOf(newOrder.soft_credit.sponsor_donation_amount);
                        }

                        campaignsToUpdateList.add(fundraisingPageCampaign);
                    }
                }
            }

            // In Memory Donation
            if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) && (String.isNotBlank(newOrder.soft_credit.salesforce_in_memory_page_id)) )
            {
                // Find or create In Memory Parent Campaign
                Campaign[] inMemoryParentCampaigns = [SELECT ID, Name, Type, External_System_Link__c, External_System_Name__c FROM Campaign
                WHERE (NAME = :inMemoryParentCampaignName AND Type = :inMemoryCampaignType AND External_System_Name__c = 'UNITY')]; // No External ID here.

                if(inMemoryParentCampaigns.isEmpty())
                {
                    inMemoryParentCampaign = createCampaign(res, inMemoryParentCampaignName, inMemoryCampaignType, null, null, null, null, null, null, null, false, null, null);
                }
                else
                {
                    inMemoryParentCampaign = inMemoryParentCampaigns[0]; 
                }

                // Find or create the corresponding in memory page campaign
                Campaign[] inMemoryPageCampaigns = [SELECT ID, Name, Type, External_ID__c, Total_Amount_Raised_in_Evenico__c FROM Campaign WHERE ((External_ID__c = :newOrder.soft_credit.salesforce_in_memory_page_id))];

                if(inMemoryPageCampaigns.isEmpty())
                {
                    if (string.isNotBlank(newOrder.soft_credit.in_memory_page_created_date))
                    {
                        inMemoryPageCampaignStartDate = newOrder.soft_credit.in_memory_page_created_date.substring(0, newOrder.soft_credit.in_memory_page_created_date.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    }
                    
                    inMemoryPageCampaign = createCampaign(res, newOrder.soft_credit.in_memory_page_name, inMemoryCampaignType, newOrder.soft_credit.salesforce_in_memory_page_id, 
                                            newOrder.items[0].campaign_url, inMemoryParentCampaign.ID, inMemoryPageCampaignStartDate, null, softCredit_contact_ID, 
                                            null, false, newOrder.soft_credit.current_amount, null);
                    inMemoryPageCampaignID = inMemoryPageCampaign.ID; // Retrieve the CampaignID to set on primary campaign source while creating opportunity below (in memory donation)                       
                    
                }
                else
                {
                    inMemoryPageCampaign = inMemoryPageCampaigns[0];
                    inMemoryPageCampaignID = inMemoryPageCampaign.ID; // Retrieve the CampaignID to set on primary campaign source while creating opportunity below (in memory donation)                       

                    if(inMemoryPageCampaign.Name != newOrder.soft_credit.in_memory_page_name || inMemoryPageCampaign.Total_Amount_Raised_in_Evenico__c != Decimal.valueOf(newOrder.soft_credit.current_amount))
                    {
                        inMemoryPageCampaign.Name = newOrder.soft_credit.in_memory_page_name;
                        inMemoryPageCampaign.Total_Amount_Raised_in_Evenico__c = Decimal.valueOf(newOrder.soft_credit.current_amount);
                        System.debug('In Memory Page Campaign - Update');

                        campaignsToUpdateList.add(inMemoryPageCampaign);
                    }
                }
            }

            // Membership
            if (string.isNotBlank(newOrder.items[0].membership_program_name))
            {
                Campaign[] membershipProgramCampaigns = [SELECT ID, Name, Type, External_ID__c FROM Campaign WHERE ((External_ID__c = :newOrder.items[0].salesforce_membership_id))];
                if(membershipProgramCampaigns.isEmpty())

                {
                    membershipProgramCampaign = createCampaign(res, newOrder.items[0].membership_program_name, membershipCampaignType, newOrder.items[0].salesforce_membership_id, 
                                            newOrder.items[0].membership_program_url, null, null, null, null, null, false, null, 'Lapsed');
                    membershipProgramCampaignID = membershipProgramCampaign.ID; // Retrieve the CampaignID to set on primary campaign source while creating opportunity below (membership order)                       
                }
                else 
                {
                    membershipProgramCampaign = membershipProgramCampaigns[0];
                    membershipProgramCampaignID = membershipProgramCampaign.ID; // Retrieve the CampaignID to set on primary campaign source while creating opportunity below (membership order)                       

                    if(membershipProgramCampaign.Name != newOrder.items[0].membership_program_name)
                    {
                        membershipProgramCampaign.Name = newOrder.items[0].membership_program_name;
                        System.debug('Membership Program Campaign - Update');

                        campaignsToUpdateList.add(membershipProgramCampaign);
                    }
                }
            }*/

            /*if (campaignsToUpdateList != null && campaignsToUpdateList.size()>0)
            {
                // Update campaign data.
                for(Campaign c : campaignsToUpdateList)
                {
                    try
                    {
                        update c;
                        System.debug(logginglevel.DEBUG, 'Updated parent or child campaign successfully');
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to update parent or child campaign ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert sponsor campaign"}}');
                        return;
                    }
                }
            }*/                

            // Create the main Opportunity, this includes all order items (meaning it can have a total amount that is spread across various different order item types like Event Donation etc).
            
            System.debug(logginglevel.DEBUG, 'Order item type found: ' + orderItemTypeStr);

            // If the payment is on behalf of the company (is_company = true), the opportunity should be linked to the Organisational account & contact record
            // If it is by an individual (is_company = false), the opportuntiy should be linked to the Household account & contact record
            /*string opportunity_accountId = orderContact.AccountID;
            boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');
            if (is_npsp_Primary_Affiliation_c_present)
            {
                if (newOrder.is_company)
                {
                    if (String.isNotBlank(orderContact.npsp__Primary_Affiliation__c))
                    {
                        opportunity_accountId = orderContact.npsp__Primary_Affiliation__c;
                    }                        
                }                
            }

            // Check if npsp field "Primary Contact" is present
            boolean is_npsp_Primary_Contact_c_present = doesFieldExist('Opportunity', 'npsp__Primary_Contact__c');
            
            string orderPrefix = '';
            if (string.isNotBlank(newOrder.order_prefix))
                orderPrefix = newOrder.order_prefix + ' - ';*/

            /* 
                1. If the order is just a sponsor donation (i.e. newOrder.items[0].type_name), the Opportunity's Primary Campaign should be attached to the Fundraising Page Campaign
                2. For any other type of order (including Event Registration + Sponsor Donation), the Opportunity's Primary Campaign should be attached to the Parent Campaign if present
            */

            /*string opportunityPrimaryCampaign = null;
            if (newOrder.items[0].type == 3 && string.isNotBlank(fundraisingPageCampaignID)) {
                opportunityPrimaryCampaign = fundraisingPageCampaignID;
            }
            else if (parentCampaign != null){
                opportunityPrimaryCampaign = parentCampaign.Id;
            }

            if (newOrder.items[0].type == 9 && string.isNotBlank(inMemoryPageCampaignID)) {
                opportunityPrimaryCampaign = inMemoryPageCampaignID;
            }

            if (newOrder.items[0].type == 7 && string.isNotBlank(membershipProgramCampaignID))
            {
                opportunityPrimaryCampaign = membershipProgramCampaignID;
            }

            // Fetch all the order item details
            for (integer i=0; i < newOrder.items.size(); i++)
            {
                if (i == 0)
                {
                    orderDescription = newOrder.items[i].quantity + ' x ' + newOrder.items[i].details;
                }
                else 
                {
                    orderDescription = orderDescription + ', ' + newOrder.items[i].quantity + ' x ' + newOrder.items[i].details;
                }                
            }*/

            /*Opportunity newOpp = new Opportunity();
            // Check if recevied donation is a recurring donation
            System.debug('----------------------------- Recurring Order Link >> From ORDER json >> ----------------------------- : ' + newOrder.recurring_order_url);
            if (newOrder.recurring_order_id != null && newOrder.recurring_order_id > 0) {
                newOpp = createOpportunity(
                    opportunity_accountId,
                    namePrefix + orderPrefix + newOrder.id, 
                    newOrder.amount, 
                    orderItemTypeStr,
                    newOrder.completed_date, 
                    newOrder.id, 
                    orderDescription,
                    opportunityPrimaryCampaign,
                    newOrder.items[0].membership_level,
                    newOrder.items[0].membership_frequency,
                    //newOrder.items[0].membership_valid_to,
                    newOrder.related_url,
                    is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                    fundraisingPageCampaignID,
                    sponsorDonationAmount,
                    newOrder.recurring_order_id, 
                    newOrder.recurring_frequency_id, 
                    newOrder.recurring_initial_date, 
                    newOrder.recurring_number, 
                    newOrder.recurring_order_url,
                    newOrder.is_admin_order,
                    newOrder.custom_field_name,
                    newOrder.custom_field_value,
                    newOrder.items[0].membership_valid_from,
                    newOrder.items[0].membership_valid_to,
                    newOrder.items[0].membership_origin,
                    null, null, null, null
                );

                // Update the recurring donation fields for the OrderContact
                orderContact.Total_No_of_Recurring_Donations__c = string.valueOf(newOrder.total_no_of_recurring_donations);
                orderContact.Total_No_of_Active_Recurring_Donations__c = string.valueOf(neworder.total_no_of_active_recurring_donations);
                orderContact.Recurring_Donor_Status__c = 'Active';
                orderContact.Lapsed_Date__c = null;

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(orderContact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('Recurring donation fields - orderContact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('Recurring donation fields - orderContact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'Failed to update existing contact - Recurring donation fields');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update existing contact - Recurring donation fields"}}');
                    return;
                }
            }
            else {
                newOpp = createOpportunity(
                    opportunity_accountId,
                    namePrefix + orderPrefix + newOrder.id, 
                    newOrder.amount, 
                    orderItemTypeStr,
                    newOrder.completed_date, 
                    newOrder.id, 
                    orderDescription,
                    opportunityPrimaryCampaign,
                    newOrder.items[0].membership_level,
                    newOrder.items[0].membership_frequency,
                    //newOrder.items[0].membership_valid_to,
                    newOrder.related_url,
                    is_npsp_Primary_Contact_c_present == true ? orderContact.ID : null,
                    fundraisingPageCampaignID,
                    sponsorDonationAmount,
                    null, null, null, null, null,
                    newOrder.is_admin_order,
                    newOrder.custom_field_name,
                    newOrder.custom_field_value,
                    newOrder.items[0].membership_valid_from,
                    newOrder.items[0].membership_valid_to,
                    newOrder.items[0].membership_origin,
                    null, null, null, null
                );
            }            

            // Process Campaign Member logic as follows:
            for (integer i=0; i < newOrder.items.size(); i++)
            {
                Items item = newOrder.items[i];
                // (1) MEM: Registrations become members.
                if(item.type == 2) // Event Registration
                {
                    if(memberCampaign != null)
                    {
                        createCampaignMember(memberCampaign, orderContact, null);
                        System.debug(logginglevel.DEBUG, 'Added campaign member to member campaign');
                    }
                }

                // (2) DNR: Every Contact where the Opportunity has a Type of Sponsor Donation (3), Campaign Donation (4) or Event Donation (10).
                if(
                    item.type == 3 ||   // Sponsor Donation
                    item.type == 4 ||   // Campaign Donation
                    item.type == 10     // Event Donation
                )
                {
                    if(donorCampaign != null)
                    {
                        createCampaignMember(donorCampaign, orderContact, null);
                        System.debug(logginglevel.DEBUG, 'Added campaign member to donor campaign');
                    }
                }
            }

            // (3) FR: Every Campaign related soft credit Contact, is a fundraiser Campaign Member.
            if(softCreditContact != null && fundraiserCampaign != null)
            {
                createCampaignMember(fundraiserCampaign, softCreditContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to fundraiser campaign');
            }

            // (4) Fundraising Page Campaign: Every sponsor donor, is a member of the corresponding Fundraising Page Campaign
            if (softCreditContact != null && fundraisingPageCampaign != null && orderContact != null)
            {
                createCampaignMember(fundraisingPageCampaign, orderContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to fundraising page campaign');
            }

            // (5) In Memory (Parent) Campaign: Every in memory page owner, is a member of the "In Memory" parent campaign
            if (softCreditContact != null && inMemoryParentCampaign != null && orderContact != null)
            {
                createCampaignMember(inMemoryParentCampaign, softCreditContact, null);
                System.debug(logginglevel.DEBUG, 'Added campaign member to in memory (parent) campaign');
            }

            // (6) Membership Program Campaign: Check if contact is an existing member and if the status is "Lapsed"
            if (membershipProgramCampaignID != null && membershipProgramCampaign != null)
            {
                CampaignMember[] existing_campaign_member_contacts = [SELECT ID, CampaignId, ContactId, CreatedById, CreatedDate, FirstRespondedDate, HasResponded, IsDeleted, LastModifiedById, LastModifiedDate, Status, SystemModstamp 
                                    FROM CampaignMember WHERE CampaignId = :membershipProgramCampaign.ID AND ContactId = :orderContact.ID];
                if (existing_campaign_member_contacts != null && existing_campaign_member_contacts.size() > 0)
                {
                    CampaignMember existing_campaign_member_contact =  existing_campaign_member_contacts[0];
                    if (existing_campaign_member_contact.Status.toLowerCase() == 'lapsed')
                    {
                        // Update the status to "Responded"
                        existing_campaign_member_contact.Status = 'Responded';
                        try 
                        {
                            update existing_campaign_member_contact;
                            System.debug(logginglevel.DEBUG, 'Updated existing campaign member status successfully');
                        } 
                        catch (DmlException e) {
                            System.debug(logginglevel.ERROR, 'Failed to update campaign member status ' + formatDmlException(e));
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign member status"}}');
                            return;   
                        }
                    }
                }
                else 
                {
                    createCampaignMember(membershipProgramCampaign, orderContact, null);
                    System.debug(logginglevel.DEBUG, 'Added campaign member to membership program campaign');
                }
            }

            // Insert Opportunity now that the Campaign source has been set.
            try {
                insert newOpp;
                System.debug(logginglevel.DEBUG, 'Inserted opportunity successfully');
            } catch (DmlException e) {
                System.debug(logginglevel.ERROR, 'Failed to insert opportunity ' + formatDmlException(e));
                formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert opportunity"}}');
                return;   
            }*/
            
            try
            {
                //npe01__OppPayment__c newPayment = createPayment(newOpp.ID, newOrder.Payment.ref_id, newOrder.amount, newOrder.completed_date, newOrder.Payment.type, newOrder.gst);
                //insert newPayment;
                
                // Create OpportunityContactRole for contacts linked to the opportunity record
                List<OpportunityContactRole> newContactRoleList = new List<OpportunityContactRole>();
                List<OpportunityContactRole> existingContactRoleList = new List<OpportunityContactRole>();
                Map<String, OpportunityContactRole> opptNContactRoleMap = new Map<String, OpportunityContactRole>();

                System.debug('----- Opportunity Contact Roles ------- ');
                // (1) Biller Contact
                if (orderContact != null && (createdOpportunityIDs != null && createdOpportunityIDs.size() > 0))
                {
                    // Check if Opportunity Contact Role exists for Biller Contact
                    // If yes, Update the Role Name based on the Order Item type
                    for (integer x = 0; x < createdOpportunityIDs.size(); x++)
                    {
                        System.debug('----- createdOpportunityIDs ------- ' + createdOpportunityIDs.size());
                        System.debug('----- createdOpportunityID ----- value ------- ' + createdOpportunityIDs[x]);
                        System.debug('----- Opportunity Id and Opportunity - mapping size -----  ' + opptTypeNOppMap.size());
                        Opportunity currentOpp = new Opportunity();
                        currentOpp = opptTypeNOppMap.get(createdOpportunityIDs[x]);
                        System.debug('----- current opportunity ------- ' + currentOpp);

                        List<OpportunityContactRole> currentOpportunityContactRoleList = [Select ID, OpportunityId, ContactId, Role from OpportunityContactRole where OpportunityId = :createdOpportunityIDs[x]];
                    
                        if (currentOpportunityContactRoleList.size() > 0)
                        {
                            for(OpportunityContactRole ocr : currentOpportunityContactRoleList)
                            {           
                                opptNContactRoleMap.put(String.valueOf(ocr.ContactId), ocr); 
                            }
                        }

                        if(opptNContactRoleMap.containsKey(String.valueof(orderContact.ID)))
                        {
                            OpportunityContactRole billerOCR = opptNContactRoleMap.get(String.valueof(orderContact.ID));
                            billerOCR.Role = getOpportunityContactRoleName(currentOpp.type); // Update role name based on order item type
                            billerOCR.IsPrimary = true;
                            existingContactRoleList.add(billerOCR);
                        }
                        else
                        {
                            // If not, create a new Opportunity Contact Role
                            newContactRoleList.add(new OpportunityContactRole(OpportunityId=currentOpp.ID, ContactId=orderContact.ID, Role=getOpportunityContactRoleName(currentOpp.type), IsPrimary=true));                
                        }
                    } 
                }            

                // (2) Soft Credit Contact (Fundraiser) - If sponsor donation has been made to someone else's page
                if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) )
                {
                    if (newOrder.billing_email != newOrder.Soft_Credit.softCredit_email)    // donation made to someone else's page
                    {
                        if (softCredit_contact_ID != null && (createdOpportunityIDs != null && createdOpportunityIDs.size() > 0))
                        {
                            for (integer x = 0; x < createdOpportunityIDs.size(); x++)
                            {
                                Opportunity currentOpp = new Opportunity();
                                currentOpp = opptTypeNOppMap.get(String.valueof(createdOpportunityIDs[x]));
                                if (currentOpp.Type == 'Sponsor Donation')
                                {
                                    newContactRoleList.add(new OpportunityContactRole(OpportunityId=currentOpp.ID, ContactId=softCredit_contact_ID, Role='Influencer'));    
                                }
                            }       
                        }
                    }
                }

                // Insert / Update opportunity contact roles
                if(existingContactRoleList.size()>0)
                {
                    try 
                    {                        
                        update existingContactRoleList;
                        System.debug(logginglevel.DEBUG, 'Updated existing contact role list');
                    } 
                    catch (System.DmlException e) 
                    {
                        System.debug(logginglevel.ERROR, 'Failed to update existing contact role list ' + formatDmlException(e));
                    }
                    
                }
                    
                if(newContactRoleList.size() > 0)
                {
                    upsert newContactRoleList;
                }
                
                formatResponse(res, 200, '{"response": {"status": "Success", "message": ""}}');
                return;
            } 
            catch(System.DmlException e) 
            {            
                formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert opportunity/payment"}}');
                return;
            }
        }
        
        else if (newOrder.call_made_from == 'UserAccount' && newOrder.user_account != null)
        {   
            Campaign memChildCampaign;
            Campaign frChildCampaign;
            Campaign dnrChildCampaign;
            
            // Check if contact exists
            Contact[] existing_user_contacts = [SELECT ID, npsp__HHId__c, npe01__Type_of_Account__c, FirstName, LastName, Email, AccountID, 
            MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry FROM Contact
            WHERE Email = :newOrder.user_account.user_email AND FirstName = :newOrder.user_account.user_first_name AND LastName = :newOrder.user_account.user_last_name];

            Contact user_Contact = null;
            if (!existing_user_contacts.isEmpty())  // Existing Contact. Update details
            {
                // Update contact record                
                user_Contact = existing_user_contacts[0];
                
                if (String.isNotBlank(newOrder.user_account.user_salutation))
                {
                    user_Contact.Salutation = newOrder.user_account.user_salutation;
                }

                if (String.isNotBlank(newOrder.user_account.user_date_of_birth))
                {
                    string DOBStr = newOrder.user_account.user_date_of_birth.substring(0, newOrder.user_account.user_date_of_birth.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    user_Contact.BirthDate = Date.parse(DOBStr);
                }
                if (String.isNotBlank(newOrder.user_account.user_job_title))
                {
                    user_Contact.Title = newOrder.user_account.user_job_title;
                }                
                if (String.isNotBlank(newOrder.user_account.user_phone))
                {
                    user_Contact.Phone = newOrder.user_account.user_phone;
                }

                // Check if custom field "Gender" is present
                boolean is_gender_present = doesFieldExist('Contact', 'Gender__c');                 
                if (is_gender_present && String.isNotBlank(newOrder.user_account.user_gender))
                {
                    user_Contact.Gender__c = newOrder.user_account.user_gender;
                }
                
                // Billing Address
                string updateBillingAddress = checkToUpdateAddress(user_Contact.MailingStreet, user_Contact.MailingCity, user_Contact.MailingState, user_Contact.MailingPostalCode, 
                                                user_Contact.MailingCountry, newOrder.user_account.user_mailing_street, newOrder.user_account.user_mailing_city,
                                                newOrder.user_account.user_mailing_state, newOrder.user_account.user_mailing_postal_code, newOrder.user_account.user_mailing_country);

                if (updateBillingAddress == 'Update')
                {
                    user_Contact.MailingStreet = newOrder.user_account.user_mailing_street;
                    user_Contact.MailingCity = newOrder.user_account.user_mailing_city;
                    user_Contact.MailingState = newOrder.user_account.user_mailing_state;
                    user_Contact.MailingPostalCode = newOrder.user_account.user_mailing_postal_code;
                    user_Contact.MailingCountry = newOrder.user_account.user_mailing_country;
                }

                // Shipping Address
                string updateShippingAddress = checkToUpdateAddress(user_Contact.OtherStreet, user_Contact.OtherCity, user_Contact.OtherState, user_Contact.OtherPostalCode, 
                                                user_Contact.OtherCountry, newOrder.user_account.user_shipping_street, newOrder.user_account.user_shipping_city,
                                                newOrder.user_account.user_shipping_state, newOrder.user_account.user_shipping_postal_code, newOrder.user_account.user_shipping_country);

                if (updateShippingAddress == 'Update')
                {
                    user_Contact.OtherStreet = newOrder.user_account.user_shipping_street;
                    user_Contact.OtherCity = newOrder.user_account.user_shipping_city;
                    user_Contact.OtherState = newOrder.user_account.user_shipping_state;
                    user_Contact.OtherPostalCode = newOrder.user_account.user_shipping_postal_code;
                    user_Contact.OtherCountry = newOrder.user_account.user_shipping_country;
                }

                if (newOrder.user_account.user_is_company == true && String.isNotBlank(newOrder.user_account.user_organisation))  // Organisational account
                {
                    // Check to see if Account record exists
                    Account[] existing_user_accounts = [SELECT ID FROM Account WHERE Name = :newOrder.user_account.user_organisation];
                    Account user_account = null;

                    if (!existing_user_accounts.isEmpty())  // Existing Account
                    {
                        user_account = existing_user_accounts[0];

                        // Check if custom field "ABN/ACN" is present
                        boolean is_ABN_present = doesFieldExist('Account', 'ABN_ACN__c');       
                        if (is_ABN_present && String.isNotBlank(newOrder.user_account.user_ABN))
                        {
                            user_account.ABN_ACN__c = newOrder.user_account.user_ABN;                                
                        }

                        try
                        {
                            System.debug(logginglevel.DEBUG, 'User Account - Updated existing account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.update(user_account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('user_account account has been updated in Salesforce!');
                            }
                            else
                            {
                                System.debug('user_account contact has not been updated in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'User Account - Failed to update existing account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - update existing account"}}');
                            return;
                        }
                    }
                    else
                    {
                        // Create account with received details
                        user_account = createAccount(newOrder.user_account.user_organisation, newOrder.user_account.user_ABN);

                        try
                        {
                            System.debug(logginglevel.DEBUG, 'User Account - Insert account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.insert(user_account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('user_account account has been inserted in Salesforce!');
                            }
                            else
                            {
                                System.debug('user_account account has not been inserted in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'User Account - Failed to insert account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - insert account"}}');
                            return;
                        }
                    }

                    // Finalize the Contact record by assigning the Account ID to Primary Affiliation.
                    // Check if npsp field "Primary Affiliation" is present
                    boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');       
                    if (is_npsp_Primary_Affiliation_c_present)
                    {
                        user_Contact.npsp__Primary_Affiliation__c = user_account.ID;                                
                    }
                }

                // Check if there are any custom fields to update
                if (newOrder.user_account_custom_fields != null)
                {
                    for (integer i=0; i < newOrder.user_account_custom_fields.size(); i++)
                    {
                        user_Contact = getAndSetCustomField(newOrder.user_account_custom_fields[i].form_field_id, newOrder.user_account_custom_fields[i].field_type_id, 
                                    newOrder.user_account_custom_fields[i].api_name, newOrder.user_account_custom_fields[i].form_field_name, 
                                    newOrder.user_account_custom_fields[i].form_value, user_Contact );
                    }
                }

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(user_Contact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('User Account - user_Contact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('User Account- user_Contact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'User Account - Failed to update existing contact');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - update existing contact"}}');
                    return;
                }
            }
            else 
            {
                // Create contact record
                user_Contact = createContact(
                    newOrder.user_account.user_identity_id,
                    newOrder.user_account.user_salutation,
                    newOrder.user_account.user_first_name,
                    newOrder.user_account.user_last_name,
                    newOrder.user_account.user_organisation,
                    newOrder.user_account.user_email,
                    newOrder.user_account.user_mailing_street,
                    newOrder.user_account.user_mailing_city,
                    newOrder.user_account.user_mailing_state,
                    newOrder.user_account.user_mailing_postal_code,
                    newOrder.user_account.user_mailing_country,
                    newOrder.user_account.user_phone, 
                    null,
                    newOrder.user_account.user_marketing_approval,
                    newOrder.user_account.user_date_of_birth,
                    newOrder.user_account.user_job_title,
                    newOrder.user_account.user_gender,
                    newOrder.user_account.user_shipping_street,
                    newOrder.user_account.user_shipping_city,
                    newOrder.user_account.user_shipping_state,
                    newOrder.user_account.user_shipping_postal_code,
                    newOrder.user_account.user_shipping_country);

                if (newOrder.user_account.user_is_company == true && String.isNotBlank(newOrder.user_account.user_organisation))  // Organisational account
                {
                    // Check to see if Account record exists
                    Account[] existing_user_accounts = [SELECT ID FROM Account WHERE Name = :newOrder.user_account.user_organisation];
                    Account user_account = null;

                    if (!existing_user_accounts.isEmpty())  // Existing Account
                    {
                        user_account = existing_user_accounts[0];

                        // Check if custom field "ABN/ACN" is present
                        boolean is_ABN_present = doesFieldExist('Account', 'ABN_ACN__c');       
                        if (is_ABN_present && String.isNotBlank(newOrder.user_account.user_ABN))
                        {
                            user_account.ABN_ACN__c = newOrder.user_account.user_ABN;                                
                        }

                        try
                        {
                            System.debug(logginglevel.DEBUG, 'User Account - Updated existing account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.update(user_account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('user_account account has been updated in Salesforce!');
                            }
                            else
                            {
                                System.debug('user_account account has not been updated in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'User Account - Failed to update existing account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - update existing account"}}');
                            return;
                        }
                    }
                    else
                    {
                        // Create account with received details
                        user_account = createAccount(newOrder.user_account.user_organisation, newOrder.user_account.user_ABN);

                        try
                        {
                            System.debug(logginglevel.DEBUG, 'User Account - Insert account');
                            Database.DMLOptions dml = new Database.DMLOptions(); 
                            dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the account
                            dml.DuplicateRuleHeader.runAsCurrentUser = true;
                            Database.SaveResult sr = Database.insert(user_account, dml);
                            if (sr.isSuccess()) 
                            {
                                System.debug('user_account account has been inserted in Salesforce!');
                            }
                            else
                            {
                                System.debug('user_account account has not been inserted in Salesforce!');
                            }
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'User Account - Failed to insert account');
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - insert account"}}');
                            return;
                        }
                    }

                    // Finalize the Contact record by assigning the Account ID to Primary Affiliation.
                    // Check if npsp field "Primary Affiliation" is present
                    boolean is_npsp_Primary_Affiliation_c_present = doesFieldExist('Contact', 'npsp__Primary_Affiliation__c');       
                    if (is_npsp_Primary_Affiliation_c_present)
                    {
                        user_Contact.npsp__Primary_Affiliation__c = user_account.ID;                                
                    }
                }

                // Check if there are any custom fields to update
                if (newOrder.user_account_custom_fields != null)
                {
                    for (integer i=0; i < newOrder.user_account_custom_fields.size(); i++)
                    {
                        user_Contact = getAndSetCustomField(newOrder.user_account_custom_fields[i].form_field_id, newOrder.user_account_custom_fields[i].field_type_id, 
                                    newOrder.user_account_custom_fields[i].api_name, newOrder.user_account_custom_fields[i].form_field_name, 
                                    newOrder.user_account_custom_fields[i].form_value, user_Contact );
                    }
                }

                // Insert the Contact record.
                if(validateContact(user_Contact))
                {
                    try
                    {
                        System.debug(logginglevel.DEBUG, 'User Account - Inserted contact');
                        /*
                        A few clients have Duplicate Rules activated for Contacts - 
                        (1) If a duplicate contact record is identified, the command "insert user_Contact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                        (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                        */

                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult sr = Database.insert(user_Contact, dml);
                        if (sr.isSuccess()) 
                        {
                            System.debug('user_Contact contact has been inserted in Salesforce!');
                        }
                        else
                        {
                            System.debug('user_Contact Contact not inserted in Salesforce!');
                        }
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'User Account - Failed to insert valid contact');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "user account - insert valid contact"}}');
                        return;
                    }
                }
                else 
                {
                    System.debug('User Account - Validation failed for contact record');
                }
            }

            // Check if there is any Event Registration information. If yes, add this user as a Campaign Member to "MEM" Campaign
            if (newOrder.user_account.event_campaign_id != null)
            {
                parentCampaign = FindOrCreateCampaigns(res, newOrder.user_account.event_campaign_name, string.valueOf(newOrder.user_account.event_campaign_id), 
                                newOrder.user_account.salesforce_event_campaign_id, newOrder.user_account.campaign_start_date, newOrder.user_account.campaign_end_date, 
                                newOrder.user_account.event_or_campaign, newOrder.user_account.event_or_campaign_url, websiteInfo, null, null, 
                                false, null, null, null, false, null, null);
                
                memChildCampaign = FindOrCreateCampaigns(res, newOrder.user_account.event_campaign_name + ' (' + memberCampaignStr + ')', newOrder.user_account.event_campaign_id + '-' + memberCampaignStr, 
                                newOrder.user_account.salesforce_event_campaign_id + '-' + memberCampaignStr, newOrder.user_account.campaign_start_date, newOrder.user_account.campaign_end_date, 
                                newOrder.user_account.event_or_campaign, newOrder.user_account.event_or_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null,
                                false, null, null, null, false, null, null);

                frChildCampaign = FindOrCreateCampaigns(res, newOrder.user_account.event_campaign_name + ' (' + fundraiserCampaignStr  + ')', newOrder.user_account.event_campaign_id + '-' + fundraiserCampaignStr, 
                                newOrder.user_account.salesforce_event_campaign_id + '-' + fundraiserCampaignStr, newOrder.user_account.campaign_start_date, newOrder.user_account.campaign_end_date, 
                                newOrder.user_account.event_or_campaign, newOrder.user_account.event_or_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                false, null, null, null, false, null, null);

                dnrChildCampaign = FindOrCreateCampaigns(res, newOrder.user_account.event_campaign_name + ' (' + donorCampaignStr  + ')', newOrder.user_account.event_campaign_id + '-' + donorCampaignStr, 
                                newOrder.user_account.salesforce_event_campaign_id + '-' + donorCampaignStr, newOrder.user_account.campaign_start_date, newOrder.user_account.campaign_end_date, 
                                newOrder.user_account.event_or_campaign, newOrder.user_account.event_or_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                false, null, null, null, false, null, null);
                
                if(memChildCampaign != null)
                {
                    createCampaignMember(memChildCampaign, user_Contact, null);
                    System.debug(logginglevel.DEBUG, 'Added campaign member to member campaign - User Account');
                }
            }

            // Check if there is any fundraising page information
            Campaign claimedFundraisingPageCampaign;
            string pageOwnerIdStr = null;
            if (newOrder.soft_credit != null)
            {
                if (user_Contact != null)
                pageOwnerIdStr = user_Contact.Id;

                claimedFundraisingPageCampaign = FindOrCreateCampaigns(res, newOrder.soft_credit.sponsor_page_name, string.valueOf(newOrder.soft_credit.sponsor_page_id), 
                                newOrder.soft_credit.salesforce_sponsor_page_id, newOrder.soft_credit.sponsor_page_created_date, newOrder.soft_credit.sponsor_page_end_date, 
                                fundraisingCampaignType, newOrder.soft_credit.sponsor_page_url, websiteInfo, frChildCampaign != null ? frChildCampaign.Id : null, pageOwnerIdStr,
                                false, (newOrder.soft_credit != null && newOrder.soft_credit.sponsor_donation_amount != null) ? newOrder.soft_credit.sponsor_donation_amount: null, null, newOrder.soft_credit.current_amount, 
                                newOrder.soft_credit.is_team, null, null);

                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ------ CreateFundraisingPage : Campaign Member ------ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');  
                if(user_Contact != null && frChildCampaign != null)
                {
                    createCampaignMember(frChildCampaign, user_Contact, null);
                    System.debug(logginglevel.DEBUG, 'Added campaign member to FR campaign');
                }
            }
        }

        else if ((newOrder.call_made_from == 'CancelRecurringOrder' || newOrder.call_made_from == 'FailedRecurringOrder') && newOrder.recurring_order != null)
        {
            // Check if contact exists
            Contact[] existing_recurring_donor_contacts = [SELECT ID, FirstName, LastName, Email, AccountID, 
            Lapsed_Date__c, Recurring_Donor_Status__c, Total_No_of_Recurring_Donations__c, Total_No_of_Active_Recurring_Donations__c FROM Contact
            WHERE Email = :newOrder.recurring_order.billing_email AND FirstName = :newOrder.recurring_order.billing_first_name AND LastName = :newOrder.recurring_order.billing_last_name];
            
            Contact recurring_donor_Contact = null;
            string CurrentDateStr = system.today().format();

            if (!existing_recurring_donor_contacts.isEmpty())  // Existing Contact. Update details
            {
                // Update contact record                
                recurring_donor_Contact = existing_recurring_donor_contacts[0];

                System.debug('----------------------------- Cancel Recurring Order >> Current date >> ----------------------------- : ' + system.today().format());

                recurring_donor_Contact.Total_No_of_Recurring_Donations__c = string.valueOf(newOrder.recurring_order.total_no_of_recurring_donations);
                recurring_donor_Contact.Total_No_of_Active_Recurring_Donations__c = string.valueOf(neworder.recurring_order.total_no_of_active_recurring_donations);
                if (neworder.recurring_order.total_no_of_active_recurring_donations <= 0)   // Set it to 'Lapsed' if cancelled/failed && total active count = 0
                {
                    recurring_donor_Contact.Recurring_Donor_Status__c = 'Lapsed';
                    recurring_donor_Contact.Lapsed_Date__c = Date.parse(CurrentDateStr);
                }
                else 
                {
                    recurring_donor_Contact.Recurring_Donor_Status__c = 'Active';
                    recurring_donor_Contact.Lapsed_Date__c = null;
                }                

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(recurring_donor_Contact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('Cancel or Failed Recurring Order - recurring_donor_Contact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('Cancel or Failed Recurring Order - recurring_donor_Contact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'Cancel or Failed  Recurring Order - Failed to update existing contact');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "Cancel or Failed Recurring Order - update existing contact"}}');
                    return;
                }
            }
            else {
                // Insert the Contact record.

                recurring_donor_Contact = createContact(
                    newOrder.recurring_order.identity_id,
                    null,
                    newOrder.recurring_order.billing_first_name,
                    newOrder.recurring_order.billing_last_name,
                    null,
                    newOrder.recurring_order.billing_email,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null, 
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null);

                recurring_donor_Contact.Total_No_of_Recurring_Donations__c = string.valueOf(newOrder.recurring_order.total_no_of_recurring_donations);
                recurring_donor_Contact.Total_No_of_Active_Recurring_Donations__c = string.valueOf(neworder.recurring_order.total_no_of_active_recurring_donations);
                if (neworder.recurring_order.total_no_of_active_recurring_donations <= 0)   // Set it to 'Lapsed' if cancelled/failed && total active count = 0
                {
                    recurring_donor_Contact.Recurring_Donor_Status__c = 'Lapsed';
                    recurring_donor_Contact.Lapsed_Date__c = Date.parse(CurrentDateStr);
                }
                else 
                {
                    recurring_donor_Contact.Recurring_Donor_Status__c = 'Active';
                    recurring_donor_Contact.Lapsed_Date__c = null;
                } 
                
                if(validateContact(recurring_donor_Contact))
                {
                    try
                    {
                        System.debug(logginglevel.DEBUG, 'User Account - Insert contact');
                        /*
                        A few clients have Duplicate Rules activated for Contacts - 
                        (1) If a duplicate contact record is identified, the command "insert user_Contact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                        (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                        */

                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult sr = Database.insert(recurring_donor_Contact, dml);
                        if (sr.isSuccess()) 
                        {
                            System.debug('recurring_donor_Contact contact has been inserted in Salesforce!');
                        }
                        else
                        {
                            System.debug('recurring_donor_Contact Contact not inserted in Salesforce!');
                        }
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Cancel or Failed Recurring Order > Recurring Donor Contact - Failed to insert valid contact');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "Cancel or Failed Recurring Order > Recurring Donor Contact - insert valid contact"}}');
                        return;
                    }
                }
                else 
                {
                    System.debug('Recurring Donor Contact - Validation failed for contact record');
                }
            }
        }
        
        else if ((newOrder.call_made_from == 'ClaimedMembership' || newOrder.call_made_from == 'ExpiredMembership' || newOrder.call_made_from == 'ApproveMembership') && newOrder.member_user != null)
        {
            System.debug(logginglevel.DEBUG, '--------- Membership xxxxxxxxx >> Claim membership >> Added campaign member to membership program campaign ---------');
            string membershipProgramCampaignID = '';
            string membershipCampaignType = 'Membership';
            Campaign membershipProgramCampaign; // The Campaign that represents the membership program campaign in Pixo (if applicable).

            // Check if membership campaign exits
            Campaign[] membershipProgramCampaigns = [SELECT ID, Name, Type, External_ID__c FROM Campaign WHERE ((External_ID__c = :newOrder.member_user.salesforce_membership_id))];
            
            if(membershipProgramCampaigns.isEmpty())
            {
                membershipProgramCampaign = createCampaign(res, newOrder.member_user.membership_program_name, membershipCampaignType, newOrder.member_user.salesforce_membership_id, 
                                            newOrder.member_user.membership_program_url, null, null, null, null, null, false, null, customCampStatus);
                membershipProgramCampaignID = membershipProgramCampaign.ID; // Retrieve the CampaignID 
            }
            else 
            {
                membershipProgramCampaign = membershipProgramCampaigns[0];
                membershipProgramCampaignID = membershipProgramCampaign.ID; // Retrieve the CampaignID 

                if(membershipProgramCampaign.Name != newOrder.member_user.membership_program_name)
                {
                    membershipProgramCampaign.Name = newOrder.member_user.membership_program_name;
                    System.debug('Membership Program Campaign - Update');

                    try
                    {
                        update membershipProgramCampaign;
                        System.debug(logginglevel.DEBUG, 'Updated membership program campaign successfully');
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Failed to update membership program campaign ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update membership program campaign"}}');
                        return;
                    }
                }                
            }
            
            // Check if contact exists
            Contact[] existing_member_contacts = [SELECT ID, FirstName, LastName, Email, AccountID, MailingStreet, MailingCity, MailingState, MailingPostalCode, 
            MailingCountry, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry FROM Contact
            WHERE Email = :newOrder.member_user.member_email AND FirstName = :newOrder.member_user.member_first_name AND LastName = :newOrder.member_user.member_last_name];
            
            Contact member_Contact = null;

            if (!existing_member_contacts.isEmpty())  // Existing Contact. Update details
            {
                member_Contact = existing_member_contacts[0];

                // Billing Address
                string updateMemberBillingAddress = checkToUpdateAddress(member_Contact.MailingStreet, member_Contact.MailingCity, member_Contact.MailingState, 
                                                member_Contact.MailingPostalCode, member_Contact.MailingCountry, newOrder.member_user.member_mailing_street, newOrder.member_user.member_mailing_city, 
                                                newOrder.member_user.member_mailing_state, newOrder.member_user.member_mailing_postal_code, newOrder.member_user.member_mailing_country);

                if (updateMemberBillingAddress == 'Update')
                {
                    member_Contact.MailingStreet = newOrder.member_user.member_mailing_street;
                    member_Contact.MailingCity = newOrder.member_user.member_mailing_city;
                    member_Contact.MailingState = newOrder.member_user.member_mailing_state;
                    member_Contact.MailingPostalCode = newOrder.member_user.member_mailing_postal_code;
                    member_Contact.MailingCountry = newOrder.member_user.member_mailing_country;
                }

                // Shipping Address
                string updateMemberShippingAddress = checkToUpdateAddress(member_Contact.OtherStreet, member_Contact.OtherCity, member_Contact.OtherState, 
                                                member_Contact.OtherPostalCode, member_Contact.OtherCountry, newOrder.member_user.member_shipping_street, newOrder.member_user.member_shipping_city, 
                                                newOrder.member_user.member_shipping_state, newOrder.member_user.member_shipping_postal_code, newOrder.member_user.member_shipping_country);

                if (updateMemberShippingAddress == 'Update')
                {
                    member_Contact.OtherStreet = newOrder.member_user.member_shipping_street;
                    member_Contact.OtherCity = newOrder.member_user.member_shipping_city;
                    member_Contact.OtherState = newOrder.member_user.member_shipping_state;
                    member_Contact.OtherPostalCode = newOrder.member_user.member_shipping_postal_code;
                    member_Contact.OtherCountry = newOrder.member_user.member_shipping_country;
                }

                if (String.isNotBlank(newOrder.member_user.member_phone))
                {
                    member_Contact.Phone = newOrder.billing_phone;
                }

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(member_Contact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('Membership - member_Contact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('Membership- member_Contact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'Membership - Failed to update existing contact');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "Membership - update existing contact"}}');
                    return;
                }
            }
            else 
            {
                member_Contact = createContact(
                    newOrder.member_user.member_identity_id,
                    null,
                    newOrder.member_user.member_first_name,
                    newOrder.member_user.member_last_name,
                    null,
                    newOrder.member_user.member_email,
                    newOrder.member_user.member_mailing_street,
                    newOrder.member_user.member_mailing_city,
                    newOrder.member_user.member_mailing_state,
                    newOrder.member_user.member_mailing_postal_code,
                    newOrder.member_user.member_mailing_country,
                    newOrder.member_user.member_phone, 
                    null,
                    null,
                    null,
                    null,
                    null,
                    newOrder.member_user.member_shipping_street,
                    newOrder.member_user.member_shipping_city,
                    newOrder.member_user.member_shipping_state,
                    newOrder.member_user.member_shipping_postal_code,
                    newOrder.member_user.member_shipping_country);

                // Insert the Contact record.
                if(validateContact(member_Contact))
                {
                    try
                    {
                        System.debug(logginglevel.DEBUG, 'Membership - Insert contact');
                        /*
                        A few clients have Duplicate Rules activated for Contacts - 
                        (1) If a duplicate contact record is identified, the command "insert member_Contact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                        (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                        */

                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult sr = Database.insert(member_Contact, dml);
                        if (sr.isSuccess()) 
                        {
                            System.debug('member_Contact contact has been inserted in Salesforce!');
                        }
                        else
                        {
                            System.debug('member_Contact Contact not inserted in Salesforce!');
                        }
                    }
                    catch (System.DmlException e)
                    {
                        System.debug(logginglevel.ERROR, 'Membership - Failed to insert valid contact');
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "Membership - insert valid contact"}}');
                        return;
                    }
                }
                else 
                {
                    System.debug('Membership - Validation failed for contact record');
                }
            }

            
            System.debug(logginglevel.DEBUG, '--------- Membership >> Claim membership >> Process Start --------- Campaign: ' + membershipProgramCampaign.ID);
            System.debug(logginglevel.DEBUG, '--------- Membership >> Claim membership >> Process Start --------- Member Contact: ' + member_Contact.ID);

            // Check if contact is an existing member of the campaign
            CampaignMember[] campaign_member_contacts = [SELECT ID, CampaignId, ContactId, FirstRespondedDate, HasResponded, Status FROM CampaignMember 
                                    WHERE CampaignId = :membershipProgramCampaign.ID AND ContactId = :member_Contact.ID];
            CampaignMember campaign_member_contact;

            if (string.isNotBlank(newOrder.member_user.membership_approval_date))
                    membershipApprovalDate = newOrder.member_user.membership_approval_date.substring(0, newOrder.member_user.membership_approval_date.indexOf(' ')); 
            
            // Claimed Membership
            if (newOrder.call_made_from == 'ClaimedMembership' && member_Contact != null && membershipProgramCampaign != null && string.isNotBlank(membershipProgramCampaignID))
            {    
                if (campaign_member_contacts != null && campaign_member_contacts.size() > 0)
                {
                    campaign_member_contact =  campaign_member_contacts[0];
                    
                    if (string.isBlank(membershipApprovalDate))
                    {
                        // Update the status to "Pending Approval"
                        campaign_member_contact.Status = 'Pending Approval';
                        System.debug(logginglevel.DEBUG, 'Claimed membership - Membership requires admin approval');
                    }
                    else 
                    {
                        // Update the status to "Responded"
                        campaign_member_contact.Status = 'Responded';
                        System.debug(logginglevel.DEBUG, 'Claimed membership - Membership status - responded');
                    }  
                    
                    try 
                    {
                        update campaign_member_contact;
                        System.debug(logginglevel.DEBUG, 'Updated existing campaign member status to Responded successfully');
                    } 
                    catch (DmlException e) {
                        System.debug(logginglevel.ERROR, 'Failed to update campaign member status to Responded ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign member status to Responded"}}');
                        return;   
                    }
                }
                else 
                {
                    if (string.isBlank(membershipApprovalDate))
                    {
                        createCampaignMember(membershipProgramCampaign, member_Contact, 'Pending Approval');
                        System.debug(logginglevel.DEBUG, '--------- Membership >> Claim membership >> Added campaign member to membership program campaign ---------');
                    }
                    else 
                    {                        
                        createCampaignMember(membershipProgramCampaign, member_Contact, null);
                        System.debug(logginglevel.DEBUG, '--------- Membership >> Claim membership >> Added campaign member to membership program campaign ---------');
                    }
                }
            }
            // Expired, Cancelled or Failed Membership
            else if (newOrder.call_made_from == 'ExpiredMembership' && member_Contact != null && membershipProgramCampaign != null && string.isNotBlank(membershipProgramCampaignID))
            {
                if (campaign_member_contacts != null && campaign_member_contacts.size() > 0)
                {
                    campaign_member_contact =  campaign_member_contacts[0];
                    
                    // Update the status to "Lapsed"
                    campaign_member_contact.Status = 'Lapsed';
                    try 
                    {
                        update campaign_member_contact;
                        System.debug(logginglevel.DEBUG, 'Updated existing campaign member status to Lapsed successfully');
                    } 
                    catch (DmlException e) {
                        System.debug(logginglevel.ERROR, 'Failed to update campaign member status to Lapsed ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign member status to Lapsed"}}');
                        return;   
                    }
                }
                else 
                {
                    createCampaignMember(membershipProgramCampaign, member_Contact, 'Lapsed');
                    System.debug(logginglevel.DEBUG, '--------- Membership >> Expired membership >> Member status: Lapsed ---------');
                }
                
            }
            // Membership has been approved by the Admin
            else if (newOrder.call_made_from == 'ApproveMembership' && member_Contact != null && membershipProgramCampaign != null && string.isNotBlank(membershipProgramCampaignID)) 
            {
                if (campaign_member_contacts != null && campaign_member_contacts.size() > 0)
                {
                    campaign_member_contact =  campaign_member_contacts[0];
                    
                    // Update the status to "Responded"
                    campaign_member_contact.Status = 'Responded';
                    try 
                    {
                        update campaign_member_contact;
                        System.debug(logginglevel.DEBUG, 'Approve Membership - Updated existing campaign member status to Responded successfully');
                    } 
                    catch (DmlException e) {
                        System.debug(logginglevel.ERROR, 'Approve Membership - Failed to update campaign member status to Responded ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign member status to Responded"}}');
                        return;   
                    }
                }
                else 
                {
                    createCampaignMember(membershipProgramCampaign, member_Contact, null);
                    System.debug(logginglevel.DEBUG, '--------- Membership >> Approve Membership - >> Added campaign member to membership program campaign ---------');
                }

                // Update the membership's valid from and valid to date in the corresponding opportunity's record
                RecordType rt = [select Id from RecordType where Name = 'Membership' and SobjectType = 'Opportunity' LIMIT 1];
                
                Opportunity[] existing_membership_opportunities = [SELECT ID, npe01__Membership_Start_Date__c, npe01__Membership_End_Date__c, External_ID__c, External_System_Link__c
                                        FROM Opportunity WHERE RecordTypeId = :rt.Id AND External_ID__c = :newOrder.member_user.membership_order_id AND 
                                        External_System_Name__c = 'Unity' AND External_System_Link__c like :websiteInfo];

                Opportunity existing_membership_opportunity;
                if (existing_membership_opportunities != null && existing_membership_opportunities.size() > 0)
                {
                    existing_membership_opportunity = existing_membership_opportunities[0];

                    if (string.isNotBlank(newOrder.member_user.membership_valid_from))
                        existing_membership_opportunity.npe01__Membership_Start_Date__c =  Date.parse(newOrder.member_user.membership_valid_from.substring(0, newOrder.member_user.membership_valid_from.indexOf(' '))); 
                    if (string.isNotBlank(newOrder.member_user.membership_valid_to))
                        existing_membership_opportunity.npe01__Membership_End_Date__c =  Date.parse(newOrder.member_user.membership_valid_to.substring(0, newOrder.member_user.membership_valid_to.indexOf(' ')));

                    try {
                        update existing_membership_opportunity;
                        System.debug(logginglevel.DEBUG, 'Updated existing membership opportunity successfully');
                    }
                    catch (DmlException e) {
                        System.debug(logginglevel.ERROR, 'Failed to update existing membership opportunity ' + formatDmlException(e));
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update existing membership opportunity"}}');
                        return;   
                    }
                }
            }
        }

        else if (newOrder.call_made_from == 'CreateFundraisingPage' && newOrder.soft_credit != null)
        {
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ------ CreateFundraisingPage ------ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');  
            Contact[] contacts;
            Contact fundraiserContact;

            // Create or update contact
            contacts = [SELECT ID, npsp__HHId__c, npe01__Type_of_Account__c, FirstName, LastName, Email, AccountID, 
                MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry FROM Contact
                WHERE Email = :newOrder.soft_credit.softCredit_email AND FirstName = :newOrder.soft_credit.softCredit_first_name AND LastName = :newOrder.soft_credit.softCredit_last_name];

            if(!contacts.isEmpty()) // Existing Contact. Update details.
            {
                fundraiserContact = contacts[0];
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Existing Contact: >>>>>>>>> Based on First name, last name & email');  

                // Billing Address
                string updateContactBillingAddress = checkToUpdateAddress(fundraiserContact.MailingStreet, fundraiserContact.MailingCity, fundraiserContact.MailingState, 
                        fundraiserContact.MailingPostalCode, fundraiserContact.MailingCountry, newOrder.soft_credit.softCredit_street, newOrder.soft_credit.softCredit_city, 
                        newOrder.soft_credit.softCredit_state, newOrder.soft_credit.softCredit_postcode, newOrder.soft_credit.softCredit_country);

                if (updateContactBillingAddress == 'Update')
                {
                    fundraiserContact.MailingStreet = newOrder.soft_credit.softCredit_street;
                    fundraiserContact.MailingCity = newOrder.soft_credit.softCredit_city;
                    fundraiserContact.MailingState = newOrder.soft_credit.softCredit_state;
                    fundraiserContact.MailingPostalCode = newOrder.soft_credit.softCredit_postcode;
                    fundraiserContact.MailingCountry = newOrder.soft_credit.softCredit_country;
                }

                // Shipping Address
                string updateContactShippingAddress = checkToUpdateAddress(fundraiserContact.OtherStreet, fundraiserContact.OtherCity, fundraiserContact.OtherState, 
                            fundraiserContact.OtherPostalCode, fundraiserContact.OtherCountry, newOrder.soft_credit.softCredit_shipping_street, newOrder.soft_credit.softCredit_shipping_city, 
                            newOrder.soft_credit.softCredit_shipping_state, newOrder.soft_credit.softCredit_shipping_postcode, newOrder.soft_credit.softCredit_shipping_country);

                if (updateContactShippingAddress == 'Update')
                {
                    fundraiserContact.OtherStreet = newOrder.soft_credit.softCredit_shipping_street;
                    fundraiserContact.OtherCity = newOrder.soft_credit.softCredit_shipping_city;
                    fundraiserContact.OtherState = newOrder.soft_credit.softCredit_shipping_state;
                    fundraiserContact.OtherPostalCode = newOrder.soft_credit.softCredit_shipping_postcode;
                    fundraiserContact.OtherCountry = newOrder.soft_credit.softCredit_shipping_country;
                }

                if (String.isNotBlank(newOrder.soft_credit.softCredit_phone))
                {
                    fundraiserContact.Phone = newOrder.soft_credit.softCredit_phone;
                }

                try
                {
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and update the contact
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.update(fundraiserContact, dml);
                    if (sr.isSuccess()) 
                    {
                        System.debug('fundraiserContact contact has been updated in Salesforce!');
                    }
                    else
                    {
                        System.debug('fundraiserContact contact has not been updated in Salesforce!');
                    }
                }
                catch (System.DmlException e)
                {
                    System.debug(logginglevel.ERROR, 'Failed to update existing fundraiser contact');
                    formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update existing fundraiser contact"}}');
                    return;
                }
            }
            else 
            {
                // New or no Contact, process Contact data.
                fundraiserContact = createContact(
                    newOrder.soft_credit.softCredit_identity_id,
                    null,
                    newOrder.soft_credit.softCredit_first_name, 
                    newOrder.soft_credit.softCredit_last_name, 
                    null, 
                    newOrder.soft_credit.softCredit_email, 
                    newOrder.soft_credit.softCredit_street, 
                    newOrder.soft_credit.softCredit_city, 
                    newOrder.soft_credit.softCredit_state, 
                    newOrder.soft_credit.softCredit_postcode, 
                    newOrder.soft_credit.softCredit_country, 
                    newOrder.soft_credit.softCredit_phone, 
                    null,
                    null,
                    null, 
                    null, 
                    null,
                    newOrder.soft_credit.softCredit_shipping_street,
                    newOrder.soft_credit.softCredit_shipping_city,
                    newOrder.soft_credit.softCredit_shipping_state,
                    newOrder.soft_credit.softCredit_shipping_postcode,
                    newOrder.soft_credit.softCredit_shipping_country
                );

                if(validateContact(fundraiserContact))
                {
                    try
                    {
                        /*
                        A few clients have Duplicate Rules activated for Contacts - 
                        (1) If a duplicate contact record is identified, the command "insert orderContact;" throws an error ("status": "Failure", "message": "Use one of these records?) and skips from creating a contact, opportunity etc
                        (2) Solution : Use 'DuplicateRuleHeader' Class to save a record
                        */

                        Database.DMLOptions dml = new Database.DMLOptions(); 
                        dml.DuplicateRuleHeader.allowSave = true;   // Bypass the duplicate rule and insert the contact
                        dml.DuplicateRuleHeader.runAsCurrentUser = true;
                        Database.SaveResult saveResult = Database.insert(fundraiserContact, dml);
                        if (saveResult.isSuccess()) 
                        {
                            System.debug('fundraiserContact contact has been inserted in Salesforce!');
                        }
                        else
                        {
                            System.debug('----------------------------------------------------------------- fundraiserContact not inserted---------------------');
                            System.debug(saveResult.getErrors());
                            System.debug(saveResult.errors);
                            System.debug('fundraiserContact contact has not been inserted in Salesforce!');
                        }

                        // Retrieve the ContactID of the new contact to set on campaign record while creating it below
                        //Contact newSC_FundraiserContact = [SELECT ID, AccountID FROM Contact WHERE ID = :fundraiserContact.ID LIMIT 1];
                        //softCredit_fundraiser_contact_ID = newSC_FundraiserContact.ID;
                    }
                    catch (System.DmlException e)
                    {
                        formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "insert valid contact"}}');
                        return;
                    }
                }
            }

            // Create or update fundraising page (and parent campaign)
            // If it is a sponsor donation, find or create untethered fundraising campaign & fundraising page campaign
            if ((newOrder.soft_credit != null) && (String.isNotBlank(newOrder.Soft_Credit.softCredit_identity_id) ) && (String.isNotBlank(newOrder.soft_credit.salesforce_sponsor_page_id)) )
            {
                string parentCampaignName = '';
                string parentCampaignType = '';
                string receivedParentID = string.valueOf(newOrder.soft_credit.event_campaign_id);
                string receivedParentSalesforceID = newOrder.soft_credit.salesforce_event_campaign_id;  
                string parentCampaignStartDate = '';
                string parentCampaignEndDate = '';

                // Check if fundraising page campaign exists
                Campaign[] fundraisingPageCampaigns = [SELECT ID, Name, Type, External_ID__c, Total_Value_of_Fundraising_Page__c FROM Campaign
                WHERE ((External_ID__c = :newOrder.soft_credit.salesforce_sponsor_page_id))];

                if(fundraisingPageCampaigns.isEmpty())
                {
                    // Parent Campaign  - attached to event/campaign or untethered
                    if ((String.isNotBlank(newOrder.soft_credit.event_name)) || (String.isNotBlank(newOrder.soft_credit.campaign_name)))
                    {
                        if (String.isNotBlank(newOrder.soft_credit.event_name))
                        {
                            parentCampaignName = newOrder.soft_credit.event_name;
                            parentCampaignType = 'Event';
                        }

                        if (String.isNotBlank(newOrder.soft_credit.campaign_name))
                        {
                            parentCampaignName = newOrder.soft_credit.campaign_name;
                            parentCampaignType = 'Campaign';
                        }

                        if (string.isNotBlank(newOrder.soft_credit.event_campaign_start_date))
                        {
                            parentCampaignStartDate = newOrder.soft_credit.event_campaign_start_date; //(20/04/2015 12:22:09 AM)
                        }

                        if (string.isNotBlank(newOrder.soft_credit.event_campaign_end_date))
                        {
                            parentCampaignEndDate = newOrder.soft_credit.event_campaign_end_date; //(20/04/2015 12:22:09 AM)
                        }

                        parentCampaign = FindOrCreateCampaigns(res, parentCampaignName, receivedParentID, receivedParentSalesforceID, parentCampaignStartDate, parentCampaignEndDate, 
                                            parentCampaignType, newOrder.soft_credit.event_campaign_url, websiteInfo, null, null, false, null, null, null, false, null, null);
                        
                        // Find or create the member Campaign (MEM)
                        string memQueryId = receivedParentID + '-' + memberCampaignStr;
                        string memSFQueryId = receivedParentSalesforceID + '-' + memberCampaignStr;                

                        memberCampaign = FindOrCreateCampaigns(res, parentCampaignName + ' (' + memberCampaignStr + ')', memQueryId, 
                                            memSFQueryId, parentCampaignStartDate, parentCampaignEndDate, 
                                            parentCampaignType, newOrder.soft_credit.event_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                            false, null, null, null, false, null, null);

                        // Find or create the fundraiser Campaign (FR)
                        string frQueryId = receivedParentID + '-' + fundraiserCampaignStr;
                        string frSFQueryId = receivedParentSalesforceID + '-' + fundraiserCampaignStr;
                        
                        fundraiserCampaign = FindOrCreateCampaigns(res, parentCampaignName + ' (' + fundraiserCampaignStr + ')', frQueryId, 
                                                frSFQueryId, parentCampaignStartDate, parentCampaignEndDate, 
                                                parentCampaignType, newOrder.soft_credit.event_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                                false, null, null, null, false, null, null);
                        fundraisingPageParentCampaign = fundraiserCampaign.ID;  // Retrieve the CampaignID to set on fundraising page campaign while creating it below (if it is a sponsor donation)
                        fundraisingParentCampaign = fundraiserCampaign;

                        // Find or create the donor Campaign (DNR)
                        string dnrQueryId = receivedParentID + '-' + donorCampaignStr;
                        string dnrSFQueryId = receivedParentSalesforceID + '-' + donorCampaignStr;
                        
                        donorCampaign = FindOrCreateCampaigns(res, parentCampaignName + ' (' + donorCampaignStr + ')', dnrQueryId, 
                                                dnrSFQueryId, parentCampaignStartDate, parentCampaignEndDate, 
                                                parentCampaignType, newOrder.soft_credit.event_campaign_url, websiteInfo, parentCampaign != null ? parentCampaign.Id : null, null, 
                                                false, null, null, null, false, null, null);

                    }
                    else // untethered
                    {
                        // Find or create Evenico Untethered Fundraising Campaign
                        Campaign[] untetheredFundraisingCampaigns = [SELECT ID, Name, Type, External_System_Link__c, External_System_Name__c FROM Campaign
                        WHERE ((NAME = :untetheredFundraisingCampaignName OR NAME = :previousUntetheredFundCampName) AND Type = :fundraisingCampaignType AND External_System_Name__c = 'UNITY' AND External_System_Link__c LIKE :websiteInfo)]; // No External ID here.

                        if(untetheredFundraisingCampaigns.isEmpty())
                        {
                            untetheredFundraisingCampaign = createCampaign(res, untetheredFundraisingCampaignName, fundraisingCampaignType, null, newOrder.website_info, null, null, null, null, null, false, null, null);
                        }
                        else
                        {
                            untetheredFundraisingCampaign = untetheredFundraisingCampaigns[0]; 
                        }

                        if (String.isBlank(fundraisingPageParentCampaign))
                        {
                            fundraisingParentCampaign = untetheredFundraisingCampaign;
                            fundraisingPageParentCampaign = untetheredFundraisingCampaign.ID;   
                        }
                    }
                    
                    // Fundraising Page
                    if (string.isNotBlank(newOrder.soft_credit.sponsor_page_created_date))
                    {
                        fundraisingPageCampaignStartDate = newOrder.soft_credit.sponsor_page_created_date.substring(0, newOrder.soft_credit.sponsor_page_created_date.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    }
                    
                    if (string.isNotBlank(newOrder.soft_credit.sponsor_page_end_date))
                    {
                        fundraisingPageCampaignEndDate = newOrder.soft_credit.sponsor_page_end_date.substring(0, newOrder.soft_credit.sponsor_page_end_date.indexOf(' ')); //(20/04/2015 12:22:09 AM)
                    }

                    fundraisingPageCampaign = createCampaign(res, newOrder.soft_credit.sponsor_page_name, fundraisingCampaignType, newOrder.soft_credit.salesforce_sponsor_page_id, 
                                            newOrder.soft_credit.sponsor_page_url, fundraisingPageParentCampaign, fundraisingPageCampaignStartDate, 
                                            fundraisingPageCampaignEndDate, fundraiserContact.ID, null, neworder.soft_credit.is_team, 
                                            newOrder.soft_credit.current_amount, null);
                    fundraisingPageCampaignID = fundraisingPageCampaign.ID; // Retrieve the CampaignID to set on fundraising campaign while creating opportunity below (if it is a sponsor donation)
                } 

                // FR: Add fundraiser as a Campaign Member of FR campaign
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ------ CreateFundraisingPage : Campaign Member ------ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');  
                if(fundraiserContact != null && fundraisingParentCampaign != null)
                {
                    createCampaignMember(fundraisingParentCampaign, fundraiserContact, null);
                    System.debug(logginglevel.DEBUG, 'Added campaign member to fundraiser campaign');
                }

                if (campaignsToUpdateList != null && campaignsToUpdateList.size()>0)
                {
                    // Update campaign data.
                    for(Campaign c : campaignsToUpdateList)
                    {
                        try
                        {
                            update c;
                            System.debug(logginglevel.DEBUG, 'Updated parent or child campaign successfully');
                        }
                        catch (System.DmlException e)
                        {
                            System.debug(logginglevel.ERROR, 'Create fundraising page - Failed to update parent or child campaign ' + formatDmlException(e));
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "Create fundraising page - update parent or child campaign"}}');
                            return;
                        }
                    }
                }
            }
        }
    
        else if (newOrder.call_made_from == 'Newsletter' && newOrder.newsletter != null)
        {
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ------ Newsletter ------ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'); 
            Lead[] leads;            

            leads = [SELECT ID, FirstName, LastName, Email, Company, LeadSource, External_System_Link__c from Lead WHERE FirstName = :newOrder.newsletter.first_name 
                AND LastName = :newOrder.newsletter.last_name AND Email = :newOrder.newsletter.email AND External_System_Link__c = :newOrder.website_info];

            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Newsletter Lead: >>>>>>>>> First name ' + newOrder.newsletter.first_name);  
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Newsletter Lead: >>>>>>>>> last name ' + newOrder.newsletter.last_name);       
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Newsletter Lead: >>>>>>>>> email ' + newOrder.newsletter.email);

            if(leads.isEmpty()) // New lead
            {
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> New Newsletter Lead: >>>>>>>>> Based on First name, last name, email & external system link');     
                
                createLead(res, newOrder.newsletter.first_name, newOrder.newsletter.last_name, newOrder.newsletter.email, newOrder.website_info);
            }
            else {
                // There is nothing to update
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Existing Newsletter Lead: >>>>>>>>> Lead record ID: ' + leads[0].Id);   
            }
            
        }
    
    }     

    @HttpPut
    global static void put() 
    {
        string jsonResponse = '';
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');

        Order existingOrder = (Order)System.JSON.deserialize(RestContext.request.requestBody.toString(), Order.class);

        try 
        {
            Opportunity[] existingOpps = [SELECT ID, Name, Fundraising_Campaign__c, Sponsor_Donation_Amount__c FROM Opportunity WHERE External_ID__c = :string.valueof(existingOrder.id) AND External_System_Name__c = 'Unity'];
            Opportunity existingOpp;
            if (!existingOpps.isEmpty())
            {
                existingOpp = existingOpps[0];
                existingOpp.StageName = 'Closed Lost';
                update existingOpp;

                // Get the total number of registrants if it is an event registration order type
                integer totalRegistrants = 0;
                for (integer i=0; i < existingOrder.items.size(); i++)
                {
                    // Check if the order (item) is for an event and if it is of event registration type 
                    if (getCampaignTypeValue(existingOrder.items[i]) == 'Event' && existingOrder.items[i].type == 2)
                        totalRegistrants = totalRegistrants + 1;                
                }
                
                // If refund order is of Event Registration Type, then update Campaign's Total Registrant value
                Campaign[] orderCampaigns = [SELECT ID, Name, Type, Total_Registrants__c FROM Campaign WHERE Name = :getCampaignNameValue(existingOrder.items[0]) AND Type = :getCampaignTypeValue(existingOrder.items[0])];
                Campaign orderCampaign;

                if(!orderCampaigns.isEmpty())
                {       
                    orderCampaign = orderCampaigns[0];

                    if (getCampaignTypeValue(existingOrder.items[0]) == 'Event' && orderCampaign.Total_Registrants__c > 0)
                    {   
                        orderCampaign.Total_Registrants__c = orderCampaign.Total_Registrants__c - totalRegistrants;

                        // Update the Campaign.
                        try
                        {
                            update orderCampaign;
                        }
                        catch (System.DmlException e)
                        {
                            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update campaign"}}');
                            return;
                        }
                    }
                }

                // If it is a sponsor donation, check if Opportuntiy field "Fundraising Campaign" is populated, and update Campaign field "Total Value of Fundraising Page"
                if (String.isNotBlank(existingOpp.Fundraising_Campaign__c))
                {
                    Campaign[] fundraisingPageCampaigns = [SELECT ID, Name, Type, Total_Value_of_Fundraising_Page__c, External_ID__c FROM Campaign WHERE ID = :existingOpp.Fundraising_Campaign__c];
                    Campaign fundraisingPageCampaign;
                    if(!fundraisingPageCampaigns.isEmpty())
                    {       
                        fundraisingPageCampaign = fundraisingPageCampaigns[0];

                        if (fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c != null && fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c > 0)
                        {   
                            fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c = fundraisingPageCampaign.Total_Value_of_Fundraising_Page__c - existingOpp.Sponsor_Donation_Amount__c;
                            // Update the Campaign.
                            try
                            {
                                update fundraisingPageCampaign;
                            }
                            catch (System.DmlException e)
                            {
                                formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + formatDmlException(e) + '", "stage": "update fundraising page campaign"}}');
                                return;
                            }
                        }
                    }                    
                }
                formatResponse(res, 200, '{"response": {"status": "Success", "message": ""}}');
                return;     
            }
            else
            {
                formatResponse(res, 500, '{"response": {"status": "Failure", "message": "Unable to find opportunity record", "stage": "Opportunity record not updated"}}');
            }            
            
        } 
        catch(DmlException e) 
        {
            formatResponse(res, 500, '{"response": {"status": "Failure", "message": "' + e.getMessage() + '"}}');
            return;
        }      
    }
    
    public static void formatResponse(RestResponse res, Integer code, String jsonResponse)
    {
        res.statusCode = code;
        res.responseBody = blob.valueOf(jsonResponse);
    }
    
    public static String formatDmlException(System.DmlException e)
    {
        String messages = ''; 
                
        for (Integer i = 0; i < e.getNumDml(); i++) 
        {
            messages += e.getDmlMessage(i) + '\n';
        }
        
        return messages;
    }
}