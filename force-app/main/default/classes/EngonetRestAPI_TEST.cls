@isTest
private class EngonetRestAPI_TEST
{
    /*static testMethod void testPost()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":9170,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"14/08/2015 2:26:03 AM","completed_date":"14/08/2015 2:26:09 AM","status":7,"amount":"20.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"salesforce@pixo.com.au","is_company":false,"billing_company":"Pixo Pty Ltd","billing_street":"Level 3, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/order/view/9170","email_opt_in":false,"refund_date":null,"payment":{"ref_id":"","amount":"20.00","type":"Not Applicable"},"items":[{"amount":"20.00","type":1,"type_id":"1","details":"Donation: $20.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    static testMethod void testNoContactLastName()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":9170,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"14/08/2015 2:26:03 AM","completed_date":"14/08/2015 2:26:09 AM","status":7,"amount":"20.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"","billing_email":"salesforce@pixo.com.au","is_company":false,"billing_company":"Pixo Pty Ltd","billing_street":"Level 3, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/order/view/9170","email_opt_in":false,"refund_date":null,"payment":{"ref_id":"","amount":"20.00","type":"Not Applicable"},"items":[{"amount":"20.00","type":1,"type_id":"1","details":"Donation: $20.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testCompanyNoContactLastName()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":9170,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"14/08/2015 2:26:03 AM","completed_date":"14/08/2015 2:26:09 AM","status":7,"amount":"20.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"","billing_email":"salesforce@pixo.com.au","is_company":true,"billing_company":"Pixo Pty Ltd","billing_street":"Level 3, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/order/view/9170","email_opt_in":false,"refund_date":null,"payment":{"ref_id":"","amount":"20.00","type":"Not Applicable"},"items":[{"amount":"20.00","type":1,"type_id":"1","details":"Donation: $20.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testCampaignPost()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":10192,"identity_id":"","created_date":"02/02/2016 12:31:44 AM","completed_date":"02/02/2016 12:33:11 AM","status":7,"amount":"100.00","gst":"9.09","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"salesforce@pixo.com.au","is_company":false,"billing_company":"Web Developer","billing_street":"PO Box 251","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/event-registration/manage?d=1&order_id=10191","email_opt_in":true,"refund_date":null,"payment":{"ref_id":"","amount":"100.00","type":"Not Applicable"},"items":[{"amount":"100.00","type":2,"type_id":"3173","details":"Free Registration registration for The Forgotten Ones","event_campaign_id":5,"salesforce_event_campaign_id":"6EC114BD-6F93-47B9-8B3F-5A91B23BBB58","event_name":"The Forgotten Ones","campaign_name":"","campaign_url":"https://www.pixo.com.au/engonet-command-centre/event/view/5","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response= res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testMembershipCompanyPost()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":9155,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"23/07/2015 5:10:22 AM","completed_date":"23/07/2015 5:10:58 AM","status":7,"amount":"5.00","gst":"0.45","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"salesforce@pixo.com.au","is_company":true,"billing_company":"Pixo Pty Ltd","billing_street":"Level 2, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"03 9500 8080","billing_fax":"03 9500 8080","related_url":"https://www.pixo.com.au/engonet-command-centre/member/view/1","email_opt_in":true,"refund_date":null,"payment":{"ref_id":"1526-3477a764-30f9-11e5-9bd5-0022197fbe29","amount":"5.00","type":"Credit Card"},"items":[{"amount":"5.00","type":7,"type_id":"1","details":"Not for Profit Organisation Membership (Yearly)","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"Not for Profit Organisation","membership_frequency":"Yearly","membership_expire_date":"23/02/2017 5:57:32 AM"}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    static testMethod void testRefundPut()
    {
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.External_System_Name__c = 'Unity';
        insert testAccount;

        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'Contact';
        testContact.Email = 'testContact@test.com';
        testContact.External_System_Name__c = 'Unity';
        insert testContact;

        Opportunity testOpp = new Opportunity();
        testOpp.AccountID = testAccount.ID;
        testOpp.Name = 'Test Transaction';
        testOpp.StageName = 'Closed';
        testOpp.Amount = Decimal.valueOf(50);
        testOpp.Type = 'Donation';
        testOpp.npsp__Primary_Contact__c = testContact.ID;
        testOpp.CloseDate = Date.today();
        testOpp.External_ID__c = '9170';
        testOpp.Description = 'Test Description Text';
        testOpp.External_System_Name__c = 'Unity';
        testOpp.npe01__Do_Not_Automatically_Create_Payment__c = true;
        testOpp.LeadSource = 'Web';
        insert testOpp;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'PUT';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":9170,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"14/08/2015 2:26:03 AM","completed_date":"14/08/2015 2:26:09 AM","status":7,"amount":"20.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"salesforce@pixo.com.au","is_company":false,"billing_company":"Pixo Pty Ltd","billing_street":"Level 3, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/order/view/9170","email_opt_in":true,"refund_date":"30/04/2016 2:26:09 AM","payment":{"ref_id":"","amount":"20.00","type":"Not Applicable"},"items":[{"amount":"20.00","type":1,"type_id":"1","details":"Donation: $20.00","event_campaign_id":null,"salesforce_event_campaign_id":"null","event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response= res;

        EngonetRestAPI.put();
    }

    static testMethod void testSponsorDonationSoftCreditPost()  // updated
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100396,"identity_id":"85017525-b37b-46ac-9d95-f530ce16f50d","created_date":"05/09/2022 3:15:49 AM","completed_date":"05/09/2022 1:15:50 PM","status":7,"amount":"50.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"50.00","billing_first_name":"TestDH01","billing_last_name":"LastDH01","billing_email":"testdh01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"546 Collins St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/47","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100396","order_prefix":"a","shipping_street":"546 Collins St","shipping_city":"Melbourne","shipping_state":"VIC","shipping_postcode":"3000","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[3],"str_distinct_order_item_types":"3","order_item_count":1,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LeVmrDI7EF9k4gO1tWffBBt","amount":"50.00","type":"Credit Card"},"items":[{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"50.00","type":3,"type_id":"47","quantity":1,"details":"Sponsor Donation for Test Sponsor 01 Page","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/47","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"ada8ac0d-bf38-49e7-8060-dd3c5306d2c6","softCredit_first_name":"TestSponsor01","softCredit_last_name":"LastNameSponsor01","softCredit_email":"testsponsor01@pixo.com.au","softCredit_street":"652 Glen Huntly Rd","softCredit_city":"Caulfield South","softCredit_state":"VIC","softCredit_postcode":"3162","softCredit_country":"Australia","softCredit_phone":"111222111","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"Test Sponsor 01 Page","sponsor_page_id":47,"salesforce_sponsor_page_id":"1c422a76-53b6-465b-b97e-3a1dbf3474c3","sponsor_page_created_date":"31/08/2022 3:56:43 PM","sponsor_page_end_date":"31/08/2023 3:56:43 PM","sponsor_donation_amount":"50.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/47","is_team":false,"current_amount":"50.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testSponsorDonationToSelfPost()      // Updated
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100397,"identity_id":"85017525-b37b-46ac-9d95-f530ce16f50d","created_date":"05/09/2022 3:26:48 AM","completed_date":"05/09/2022 1:26:50 PM","status":7,"amount":"25.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"25.00","billing_first_name":"TestDH01","billing_last_name":"LastDH01","billing_email":"testdh01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"546 Collins St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/65","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100397","order_prefix":"a","shipping_street":"546 Collins St","shipping_city":"Melbourne","shipping_state":"VIC","shipping_postcode":"3000","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[3],"str_distinct_order_item_types":"3","order_item_count":1,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LeVxVDI7EF9k4gO115HXHKu","amount":"25.00","type":"Credit Card"},"items":[{"amount":"25.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"25.00","type":3,"type_id":"65","quantity":1,"details":"Sponsor Donation for TestFirst01 TestLast01 Page","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/65","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"85017525-b37b-46ac-9d95-f530ce16f50d","softCredit_first_name":"TestFirst01","softCredit_last_name":"TestLast01","softCredit_email":"test01@pixo.com.au","softCredit_street":"546 Collins St","softCredit_city":"Melbourne","softCredit_state":"VIC","softCredit_postcode":"3000","softCredit_country":"Australia","softCredit_phone":"333000222","softCredit_shipping_street":"546 Collins St","softCredit_shipping_city":"Melbourne","softCredit_shipping_state":"VIC","softCredit_shipping_postcode":"3000","softCredit_shipping_country":"Australia","sponsor_page_name":"TestFirst01 TestLast01 Page","sponsor_page_id":65,"salesforce_sponsor_page_id":"724ed830-604b-4d7b-8e82-fb5e1f954266","sponsor_page_created_date":"05/09/2022 12:50:49 PM","sponsor_page_end_date":"05/09/2023 12:50:49 PM","sponsor_donation_amount":"25.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/65","is_team":false,"current_amount":"25.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testSponsorDonationFromAndToExistingContact()
    {
        Contact testBillerContact = new Contact();
        testBillerContact.FirstName = 'Biller';
        testBillerContact.LastName = 'Contact';
        testBillerContact.Email = 'biller@test.com';
        testBillerContact.External_System_Name__c = 'Unity';
        insert testBillerContact;

        Contact testFundraiserContact = new Contact();
        testFundraiserContact.FirstName = 'Fundraiser';
        testFundraiserContact.LastName = 'User';
        testFundraiserContact.Email = 'fundraiser_contact@test.com';
        testFundraiserContact.External_System_Name__c = 'Unity';
        insert testFundraiserContact;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":100001,"identity_id":"206999b0-66a4-40c7-87ac-c7a06115a5af","created_date":"01/01/0001 12:00:00 AM","completed_date":"02/05/2019 5:11:05 AM","status":7,"amount":"2.00","gst":"0.00","billing_first_name":"Biller","billing_last_name":"Contact","billing_email":"biller@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/user-fundraising/view/40","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"1526-afdac880-6c98-11e9-accd-005056b2764e","amount":"2.00","type":"Credit Card"},"items":[{"amount":"2.00","type":3,"type_id":"40","details":"Sponsor Donation for Fundraiser Contact Fundraiser Contact","event_campaign_id":4,"salesforce_event_campaign_id":"6EC114BD-6F93-47B9-8B3F-5A91B23BBB78","event_name":"Sample Event Four","campaign_name":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/4","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":""}],"soft_credit":{"softCredit_identity_id":"206999b0-66a4-40c7-87ac-c7a06115a5af","softCredit_first_name":"Fundraiser","softCredit_last_name":"User","softCredit_email":"fundraiser_contact@test.com","softCredit_street":"293 Kings Street","softCredit_city":"Melbourne","softCredit_state":"VIC","softCredit_postcode":"3000","softCredit_country":"Australia","softCredit_phone":"900800700","softCredit_shipping_street": null,"softCredit_shipping_city": null,"softCredit_shipping_state": null,"softCredit_shipping_postcode": null,"softCredit_shipping_country": null,"sponsor_page_name": "Fundraiser Contact Page","sponsor_page_id": 40,"salesforce_sponsor_page_id": "667f879b-263d-8380-9e00-5d8f8b10a7ed","sponsor_page_created_date": "26/04/2019 3:24:03 AM","sponsor_page_end_date": "26/04/2020 3:24:02 AM","sponsor_donation_amount": "2.00","sponsor_page_url": "https://www.pixo.com.au/evenico/user-fundraising/view/40","is_team":false,"current_amount":"50.00","target_amount":"500.00"},"user_account": null,"recurring_order":null,"user_account_custom_fields": null}}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testStoreProductPost()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":100003,"identity_id":"206999b0-66a4-40c7-87ac-c7a06115a5af","created_date":"01/01/0001 12:00:00 AM","completed_date":"02/05/2019 5:14:19 AM","status":7,"amount":"5.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"email@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/100059","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"1526-237e800c-6c99-11e9-accd-005056b2764e","amount":"5.00","type":"Credit Card"},"items":[{"amount":"5.00","type":6,"type_id":"2","details":"Sample Product Two","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":""}],"soft_credit":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testNoContactBillerIdentityId()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":100002,"created_date":"01/01/0001 12:00:00 AM","completed_date":"02/05/2019 4:30:39 AM","status":7,"amount":"10.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"email@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/event/view/2","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"1526-09ee2b5b-6c93-11e9-accd-005056b2764e","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","type":10,"type_id":"2","details":"Event Donation for Sample Event Two","event_campaign_id":2,"salesforce_event_campaign_id":"6EC114BD-6F93-47B9-8B3F-5A91B23BBB28","event_name":"Sample Event Two","campaign_name":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/2","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":""}],"soft_credit":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    static testMethod void testRefundOppNotInSalesforcePut()
    {
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.External_System_Name__c = 'Unity';
        insert testAccount;

        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'Contact';
        testContact.Email = 'testContact@test.com';
        testContact.External_System_Name__c = 'Unity';
        insert testContact;

        Opportunity testOpp = new Opportunity();
        testOpp.AccountID = testAccount.ID;
        testOpp.Name = 'Test Transaction';
        testOpp.StageName = 'Closed';
        testOpp.Amount = Decimal.valueOf(50);
        testOpp.Type = 'Donation';
        testOpp.npsp__Primary_Contact__c = testContact.ID;
        testOpp.CloseDate = Date.today();
        testOpp.External_ID__c = '2000';
        testOpp.Description = 'Test Description Text';
        testOpp.External_System_Name__c = 'Unity';
        testOpp.npe01__Do_Not_Automatically_Create_Payment__c = true;
        testOpp.LeadSource = 'Web';
        insert testOpp;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'PUT';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":3000,"identity_id":"74a3de5b-191b-48ee-8884-5adba57637da","created_date":"14/08/2015 2:26:03 AM","completed_date":"14/08/2015 2:26:09 AM","status":7,"amount":"20.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"salesforce@pixo.com.au","is_company":false,"billing_company":"Pixo Pty Ltd","billing_street":"Level 3, 24 Glenferrie Road","billing_city":"Malvern","billing_state":"Victoria","billing_postcode":"3004","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/engonet-command-centre/order/view/9170","email_opt_in":true,"refund_date":"30/04/2016 2:26:09 AM","payment":{"ref_id":"","amount":"20.00","type":"Not Applicable"},"items":[{"amount":"20.00","type":1,"type_id":"1","details":"Donation: $20.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":""}]}');

        RestContext.request = req;
        RestContext.response= res;

        EngonetRestAPI.put();
    }
    
    static testMethod void testRefundEventRegistrationPut()
    {
        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'Test Event';
        testCampaign.Type = 'Event';
        testCampaign.Status = 'In Progress';
        testCampaign.External_ID__c = '1';
        testCampaign.External_System_Name__c = 'Unity';
        testCampaign.External_System_Link__c = 'https://www.pixo.com.au/evenico/event/view/1';
        testCampaign.Total_Registrants__c = 10;
        insert testCampaign;
        
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.External_System_Name__c = 'Unity';
        insert testAccount;

        Opportunity testOpp = new Opportunity();
        testOpp.AccountID = testAccount.ID;
        testOpp.Name = 'Test Transaction';
        testOpp.StageName = 'Closed';
        testOpp.Amount = Decimal.valueOf(25);
        testOpp.Type = 'Event Registration';
        testOpp.CloseDate = Date.today();
        testOpp.External_ID__c = '100005';
        testOpp.Description = 'Adult ticket registratoin for Test Event';
        testOpp.External_System_Name__c = 'Unity';
        testOpp.npe01__Do_Not_Automatically_Create_Payment__c = true;
        testOpp.LeadSource = 'Web';
        insert testOpp;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'PUT';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":100005,"identity_id":"58c5f9f5-c9fa-4303-a1b3-81f31098111c","created_date":"01/01/0001 12:00:00 AM","completed_date":"02/05/2019 4:51:55 AM","status":6,"amount":"25.00","gst":"1.82","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"email@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":null,"billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/event-registration/manage?d=1&order_id=100051","email_opt_in":false,"refund_date":"03/05/2019 1:55:27 AM","recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"1526-0217641d-6c96-11e9-accd-005056b2764e","amount":"25.00","type":"Credit Card"},"items":[{"amount":"25.00","type":2,"type_id":"29","details":"Adult ticket registration for Test Event","event_campaign_id":1,"salesforce_event_campaign_id":"6EC114BD-6F93-47B9-8B3F-5A91B23BBB18","event_name":"Test Event","campaign_name":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/1","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":""}],"soft_credit":null}');

        RestContext.request = req;
        RestContext.response= res;

        EngonetRestAPI.put();
    }

    static testMethod void testUpdateExistingContact()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"UserAccount","order_url":null,"order_prefix":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"592c8ae2-5ef8-4cb9-ae5f-04f705bad6e5","user_first_name":"User","user_last_name":"Name","user_email":"user@test.com","user_gender":"","user_date_of_birth":"05/01/2000 12:00:00 AM","user_organisation":"","user_ABN":"","user_job_title":"","user_phone":"987987987","user_mobile":"1234512345","user_mailing_street":"123 Test Street","user_mailing_city":"Test City","user_mailing_state":"Test State","user_mailing_postal_code":"9879","user_mailing_country":"Australia","user_shipping_street":"123 Test Street","user_shipping_city":"Test City","user_shipping_state":"Test State","user_shipping_postal_code":"9879","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false}}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateIndividualContact()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"c7bd062c-a153-4a76-8f73-0b424e511169","user_first_name":"eUser07","user_last_name":"eLast07","user_email":"euser07@test.com","user_gender":"Prefer to not specify","user_date_of_birth":"20/06/1985 12:00:00 AM","user_organisation":"","user_ABN":"","user_job_title":"Admin","user_phone":"987654321","user_mailing_street":"45 Clarke St","user_mailing_city":"Southbank","user_mailing_state":"VIC","user_mailing_postal_code":"3006","user_mailing_country":"Australia","user_shipping_street":"45 Clarke St","user_shipping_city":"45 Clarke St","user_shipping_state":"VIC","user_shipping_postal_code":"3006","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateOrgContact()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"a82c1d76-e21d-4068-bb7a-0cf56488f67f","user_first_name":"eUser08","user_last_name":"eLast08","user_email":"euser08@test.com","user_gender":"Male","user_date_of_birth":"27/02/1986 12:00:00 AM","user_organisation":"e08 Company","user_ABN":"ABNE0808","user_job_title":"Manager","user_phone":"8888007777","user_mailing_street":"640 Swanston St","user_mailing_city":"Carlton","user_mailing_state":"VIC","user_mailing_postal_code":"3053","user_mailing_country":"Australia","user_shipping_street":"65 Kings Street","user_shipping_city":"Melbourne","user_shipping_state":"VIC","user_shipping_postal_code":"3000","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":true},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testPersonalGeneralDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":108159,"identity_id":"","created_date":"01/01/0001 12:00:00 AM","completed_date":"14/02/2020 4:01:12 AM","status":7,"amount":"2.00","gst":"0.00","billing_first_name":"eUser01","billing_last_name":"eLast01","billing_email":"euser01@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/108159","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/108159","order_prefix":"t","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":{"ref_id":"1526-a3754206-4ede-11ea-ad2f-005056b2764e","amount":"2.00","type":"Credit Card"},"items":[{"amount":"2.00","type":1,"type_id":"","details":"Donation: $2.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testOrgGeneralDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":108160,"identity_id":"","created_date":"01/01/0001 12:00:00 AM","completed_date":"14/02/2020 4:04:21 AM","status":7,"amount":"5.00","gst":"0.00","billing_first_name":"eUser01","billing_last_name":"eLast01","billing_email":"euser01@test.com","is_company":true,"billing_company":"e01 Company","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/108160","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/108160","order_prefix":"t","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":{"ref_id":"1526-14406a51-4edf-11ea-ad2f-005056b2764e","amount":"5.00","type":"Credit Card"},"items":[{"amount":"5.00","type":1,"type_id":"","details":"Donation: $5.00","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testPurchaseStoreItemPersonal()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":108161,"identity_id":"7f58fca1-b129-49ce-95af-82cf998e6bfb","created_date":"01/01/0001 12:00:00 AM","completed_date":"01/01/0001 12:00:00 AM","status":3,"amount":"18.55","gst":"1.69","billing_first_name":"eUser01","billing_last_name":"eLast01","billing_email":"euser01@test.com","is_company":false,"billing_company":"","billing_street":"323 Victoria St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/108161","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/108161","order_prefix":"f","shipping_street":"45 Flinders Ln","shipping_city":"Melbourne","shipping_state":"3000","shipping_postcode":"VIC","shipping_country":"Australia","payment":{"ref_id":"ch_1GBvSwFnbDIPlpklqLIDUyeg","amount":"18.55","type":"Credit Card"},"items":[{"amount":"10.00","type":6,"type_id":"2","details":"Tote Bag","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testPurchaseStoreItemOrg()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":108162,"identity_id":"7f58fca1-b129-49ce-95af-82cf998e6bfb","created_date":"01/01/0001 12:00:00 AM","completed_date":"01/01/0001 12:00:00 AM","status":3,"amount":"13.55","gst":"1.23","billing_first_name":"eUser01","billing_last_name":"eLast01","billing_email":"euser01@test.com","is_company":false,"billing_company":"","billing_street":"323 Victoria St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/108162","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/108162","order_prefix":"f","shipping_street":"45 Flinders Ln","shipping_city":"Melbourne","shipping_state":"3000","shipping_postcode":"VIC","shipping_country":"Australia","payment":{"ref_id":"ch_1GBvVxFnbDIPlpklfm3ppokP","amount":"13.55","type":"Credit Card"},"items":[{"amount":"5.00","type":6,"type_id":"2","details":"Tote Bag","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":"","campaign_name":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testSponsorDonationByIndividual()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100620,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"01/01/0001 12:00:00 AM","completed_date":"30/11/2020 11:23:11 PM","status":7,"amount":"10.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":null,"billing_street":"123 Test Street","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"1234","billing_country":"Australia","billing_phone":"12345678","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/user-fundraising/view/251","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100620","order_prefix":"A","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Evenico QA 2.14.0","payment":{"ref_id":"1526-03572b5e-3363-11eb-b77d-005056b2764e","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","type":3,"type_id":"251","details":"Sponsor Donation for User Six Page","event_campaign_id":1,"salesforce_event_campaign_id":"a1195979-63f7-4782-a2fb-702455388824","event_name":"2.13 Testing Event","event_start_date":"15/06/2020 9:15:00 AM","event_end_date":"11/07/2021 9:15:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/1","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/evenico/user-fundraising/view/251","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"523aceff-a279-42e3-8efd-cfdc47d6da77","softCredit_first_name":"User","softCredit_last_name":"Six","softCredit_email":"user06@test.com","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":"User Six Page","sponsor_page_id":251,"salesforce_sponsor_page_id":"447f879b-213d-4480-9e00-5d8f7b10a9ed","sponsor_page_created_date":"26/10/2020 3:24:03 AM","sponsor_page_end_date":"26/10/2021 3:24:02 AM","sponsor_donation_amount":"10.00","sponsor_page_url":"https://www.pixo.com.au/evenico/user-fundraising/view/251","is_team":false,"current_amount":"50.00","target_amount":"500.00"},"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/ 

    static testMethod void testUpdateExistingIndividualContact()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'Biller';
        testExistingContact.LastName = 'Contact';
        testExistingContact.Email = 'biller@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e522222';
        insert testExistingContact;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"c7bd062c-a153-4a76-8f73-0b424e522222","user_first_name":"Biller","user_last_name":"Contact","user_email":"biller@test.com","user_gender":"Prefer to not specify","user_date_of_birth":"20/09/1985 12:00:00 AM","user_organisation":"","user_ABN":"","user_job_title":"Admin","user_phone":"987654321","user_mailing_street":"45 Clarke St","user_mailing_city":"Southbank","user_mailing_state":"VIC","user_mailing_postal_code":"3006","user_mailing_country":"Australia","user_shipping_street":"45 Clarke St","user_shipping_city":"45 Clarke St","user_shipping_state":"VIC","user_shipping_postal_code":"3006","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false}}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testUpdateExistingOrgContact()
    {
        Account testExistingOrg = new Account();
        testExistingOrg.Name = 'Test Company';
        insert testExistingOrg;
        
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'User';
        testExistingContact.LastName = 'Name';
        testExistingContact.Email = 'user@test.com';
        testExistingContact.npsp__Primary_Affiliation__c = testExistingOrg.ID;
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e555555';
        insert testExistingContact;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"c7bd062c-a153-4a76-8f73-0b424e555555","user_first_name":"User","user_last_name":"Name","user_email":"user@test.com","user_gender":"Male","user_date_of_birth":"08/08/1985 12:00:00 AM","user_organisation":"Test Company","user_ABN":"ABN12345","user_job_title":"Admin","user_phone":"987654321","user_mailing_street":"45 Clarke St","user_mailing_city":"Southbank","user_mailing_state":"VIC","user_mailing_postal_code":"3006","user_mailing_country":"Australia","user_shipping_street":"45 Clarke St","user_shipping_city":"45 Clarke St","user_shipping_state":"VIC","user_shipping_postal_code":"3006","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false}}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateContactWithCustomFields()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';        
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"d07079ec-1f78-49e9-a445-51b32590c5a2","user_salutation":"Mr","user_first_name":"User","user_last_name":"Four","user_email":"user04@test.com","user_gender":"Male","user_date_of_birth":"25/02/1998 12:00:00 AM","user_organisation":null,"user_ABN":"","user_job_title":"Manager","user_phone":"4455665544","user_mailing_street":"123 Test Street","user_mailing_city":"Melbourne","user_mailing_state":"VIC","user_mailing_postal_code":"3000","user_mailing_country":"Australia","user_shipping_street":"45 Test Street","user_shipping_city":"Melbourne","user_shipping_state":"VIC","user_shipping_postal_code":"3323","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false},"user_account_custom_fields":[{"form_field_id":10054,"field_type_id":1,"api_name":"AssistantName","form_field_name":"Assistant Name (account)","form_value":"ABC"},{"form_field_id":10053,"field_type_id":7,"api_name":"HasOptedOutOfFax","form_field_name":"HasOptedOutOfFax (account)","form_value":"0"},{"form_field_id":10052,"field_type_id":6,"api_name":"npe01__SystemAccountProcessor__c","form_field_name":"Account Processor (account)","form_value":"Individual"},{"form_field_id":10055,"field_type_id":3,"api_name":"npo02__Household_Naming_Order__c","form_field_name":"Household Naming Order (account)","form_value":"4.57852"},{"form_field_id":10056,"field_type_id":5,"api_name":"npo02__FirstCloseDate__c","form_field_name":"First Close Date (account)","form_value":"14/08/2015 2:26:03"},{"form_field_id":10057,"field_type_id":3,"api_name":"MobilePhone","form_field_name":"Mobile Phone (account)","form_value":"9988776655"},{"form_field_id":10058,"field_type_id":4,"api_name":"npe01__AlternateEmail__c","form_field_name":"Alternate Email (account)","form_value":"4user@test.com"}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testUpdateContactWithCustomFields()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'User';
        testExistingContact.LastName = 'Four';
        testExistingContact.Email = 'user04@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'd07079ec-1f78-49e9-a445-51b32590c5a2';
        insert testExistingContact;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":null,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"d07079ec-1f78-49e9-a445-51b32590c5a2","user_salutation":"","user_first_name":"User","user_last_name":"Four","user_email":"user04@test.com","user_gender":"","user_date_of_birth":"","user_organisation":null,"user_ABN":"","user_job_title":"","user_phone":"4455665544","user_mailing_street":null,"user_mailing_city":null,"user_mailing_state":null,"user_mailing_postal_code":null,"user_mailing_country":null,"user_shipping_street":null,"user_shipping_city":null,"user_shipping_state":null,"user_shipping_postal_code":null,"user_shipping_country":null,"user_marketing_approval":null,"user_is_company":false},"user_account_custom_fields":[{"form_field_id":10054,"field_type_id":1,"api_name":"AssistantName","form_field_name":"Assistant Name","form_value":"ABC"},{"form_field_id":10053,"field_type_id":7,"api_name":"HasOptedOutOfFax","form_field_name":"Opted out of Fax (account)","form_value":"0"},{"form_field_id":10052,"field_type_id":6,"api_name":"npe01__SystemAccountProcessor__c","form_field_name":"Account Processor (account)","form_value":"Individual"},{"form_field_id":10055,"field_type_id":3,"api_name":"npo02__Household_Naming_Order__c","form_field_name":"Household Naming Order (account)","form_value":"4.57852"},{"form_field_id":10056,"field_type_id":5,"api_name":"npo02__FirstCloseDate__c","form_field_name":"First Close Date (account)","form_value":"14/08/2015 2:26:03"},{"form_field_id":10057,"field_type_id":3,"api_name":"MobilePhone","form_field_name":"Mobile Phone (account)","form_value":"9988776655"},{"form_field_id":10058,"field_type_id":4,"api_name":"npe01__AlternateEmail__c","form_field_name":"Alternate Email (account)","form_value":"4user@test.com"}],"recurring_order":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testEventStartAndEndDate()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100281,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"01/01/0001 12:00:00 AM","completed_date":"11/06/2020 4:18:48 AM","status":7,"amount":"10.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":null,"billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/event/view/1","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100281","order_prefix":"A","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"ch_1GshsJC6drZ68KcbH9L4snJc","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","type":10,"type_id":"1","details":"Event Donation for 2.12 Event Gift Matching","event_campaign_id":1,"salesforce_event_campaign_id":"f4e7a24b-1d8d-43d0-b103-314a877fef20","event_name":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod t","event_start_date":"31/05/2020 3:55:00 AM","event_end_date":"23/09/2020 3:56:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/1","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/evenico/event/view/1","type_name":"Event Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testCampaignStartAndEndDate()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100282,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"01/01/0001 12:00:00 AM","completed_date":"11/06/2020 5:23:54 AM","status":7,"amount":"3.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":null,"billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/campaign/view/11","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100282","order_prefix":"A","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"ch_1GsitKC6drZ68Kcbkv3xnKQC","amount":"3.00","type":"Credit Card"},"items":[{"amount":"3.00","type":4,"type_id":"11","details":"Campaign Donation for SF for the yes!~","event_campaign_id":11,"salesforce_event_campaign_id":"510f7bda-9cdb-4cf9-9dbe-f59b6a06804b","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"QA Campaign 11","campaign_start_date":"22/05/2020 1:48:00 AM","campaign_end_date":"31/07/2020 1:48:00 AM","campaign_url":"https://www.pixo.com.au/evenico/campaign/view/11","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Campaign Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/
 
    static testMethod void testUntetheredSponsorDonationByIndividual()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101411,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"05/08/2022 7:09:32 AM","completed_date":"05/08/2022 5:09:33 PM","status":7,"amount":"110.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"110.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"9876 5432","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/101411","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101411","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"SF_Donor_ID__c","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[3],"str_distinct_order_item_types":"3","order_item_count":1,"payment":{"ref_id":"ch_3LTKf2KdHt4xSAm60IJrfNdL","amount":"110.00","type":"Credit Card"},"items":[{"amount":"110.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"100.00","type":3,"type_id":"60","quantity":1,"details":"Sponsor Donation for So untethered","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","softCredit_first_name":"Pixo","softCredit_last_name":"Support","softCredit_email":"support-admin@pixo.com.au","softCredit_street":"56 Montrose Road","softCredit_city":"Malvern","softCredit_state":"VIC","softCredit_postcode":"3144","softCredit_country":"Australia","softCredit_phone":"9876 5432","softCredit_shipping_street":"51 Allison Grove","softCredit_shipping_city":"Malvern","softCredit_shipping_state":"VIC","softCredit_shipping_postcode":"3144","softCredit_shipping_country":"Australia","sponsor_page_name":"So untethered","sponsor_page_id":60,"salesforce_sponsor_page_id":"9948bea2-127a-4050-9acc-45f8b3fed105","sponsor_page_created_date":"20/08/2021 1:26:55 PM","sponsor_page_end_date":"20/08/2022 1:26:54 PM","sponsor_donation_amount":"110.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/60","is_team":false,"current_amount":"1000099.0000","target_amount":"1000.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }
    
    static testMethod void testRefundSponsorDonationPut()
    {
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.External_System_Name__c = 'Unity';
        insert testAccount;

        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'User';
        testContact.Email = 'user06@test.com';
        testContact.External_System_Name__c = 'Unity';
        insert testContact;
        
        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'Test Event';
        testCampaign.Type = 'Event';
        testCampaign.Status = 'In Progress';
        testCampaign.External_ID__c = 'a1195979-63f7-4782-a2fb-702455388824';
        testCampaign.External_System_Name__c = 'Unity';
        testCampaign.External_System_Link__c = 'https://www.pixo.com.au/evenico/event/view/1';
        testCampaign.Total_Registrants__c = 100;
        insert testCampaign;

        Campaign testFundraisingPageCampaign = new Campaign();
        testFundraisingPageCampaign.Name = 'User Six Page';
        testFundraisingPageCampaign.Type = 'Fundraising Page';
        testFundraisingPageCampaign.Status = 'In Progress';
        testFundraisingPageCampaign.StartDate = Date.today();
        testFundraisingPageCampaign.IsActive = True;
        testFundraisingPageCampaign.Page_Owner__c = testContact.Id;
        testFundraisingPageCampaign.Total_Value_of_Fundraising_Page__c = Decimal.valueOf(1000);
        testFundraisingPageCampaign.External_ID__c = '447f879b-213d-4480-9e00-5d8f7b10a9ed';
        testFundraisingPageCampaign.External_System_Name__c = 'Unity';
        testFundraisingPageCampaign.External_System_Link__c = 'https://www.pixo.com.au/evenico/user-fundraising/view/251';
        insert testFundraisingPageCampaign;
        
        Opportunity testOpp = new Opportunity();
        testOpp.AccountID = testAccount.ID;
        testOpp.Name = 'Test Transaction';
        testOpp.StageName = 'Closed';
        testOpp.Amount = Decimal.valueOf(20);
        testOpp.Type = 'Sponsor Donation';
        testOpp.CloseDate = Date.today();
        testOpp.External_ID__c = '100555';
        testOpp.Description = 'Sponsor Donation for User Six Page';
        testOpp.External_System_Name__c = 'Unity';
        testOpp.npe01__Do_Not_Automatically_Create_Payment__c = true;
        testOpp.LeadSource = 'Web';
        testOpp.CampaignID = testFundraisingPageCampaign.Id;
        testOpp.Fundraising_Campaign__c = testFundraisingPageCampaign.Id;
        testOpp.Sponsor_Donation_Amount__c = Decimal.valueOf(20);
        insert testOpp;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'PUT';
        req.requestBody = blob.valueof('{"call_made_from":"Order","id":100555,"identity_id":"58c5f9f5-c9fa-4303-a1b3-81f31098111c","created_date":"01/01/0001 12:00:00 AM","completed_date":"02/05/2019 4:51:55 AM","status":6,"amount":"20.00","gst":"1.82","billing_first_name":"Pixo","billing_last_name":"Admin","billing_email":"email@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":null,"billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/user-fundraising/view/251","email_opt_in":false,"refund_date":"01/12/2020 1:55:27 AM","recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"is_admin_order":false,"website_info":"https://www.pixo.com.au","payment":{"ref_id":"1526-0217641d-6c96-11e9-accd-005056b2764e","amount":"20.00","type":"Credit Card"},"items":[{"amount":"20.00","type":3,"type_id":"251","details":"Sponsor Donation for User Six Page","event_campaign_id":1,"salesforce_event_campaign_id":"a1195979-63f7-4782-a2fb-702455388824","event_name":"Test Event","campaign_name":"","campaign_url":"https://www.pixo.com.au/evenico/event/view/1","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":""}],"soft_credit":{"softCredit_identity_id": "523aceff-a279-42e3-8efd-cfdc47d6da77","softCredit_first_name": "Test","softCredit_last_name": "User","softCredit_email": "user06@test.com","softCredit_street": "","softCredit_city": "","softCredit_state": "","softCredit_postcode": "","softCredit_country": "Australia","softCredit_phone": "","softCredit_shipping_street": null,"softCredit_shipping_city": null,"softCredit_shipping_state": null,"softCredit_shipping_postcode": null,"softCredit_shipping_country": null,"sponsor_page_name": "User Six Page","sponsor_page_id": 251,"salesforce_sponsor_page_id": "447f879b-213d-4480-9e00-5d8f7b10a9ed","sponsor_page_created_date": "26/10/2020 3:24:03 AM","sponsor_page_end_date": "26/10/2021 3:24:02 AM","sponsor_donation_amount": "20.00","sponsor_page_url": "https://www.pixo.com.au/evenico/user-fundraising/view/251"},"user_account": null,"user_account_custom_fields": null,"recurring_order":null}');

        RestContext.request = req;
        RestContext.response= res;

        EngonetRestAPI.put();
    }

    static testMethod void testInitialRecurringDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":102409,"identity_id":"4fb229c0-0868-4dce-b637-99f4d2724db5","created_date":"01/01/0001 12:00:00 AM","completed_date":"08/12/2020 1:24:10 AM","status":7,"amount":"8.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"Recurring","billing_last_name":"Donor","billing_email":"recdonor@pixo.com.au","is_company":false,"billing_company":null,"billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/102409","email_opt_in":false,"refund_date":null,"recurring_order_id":1077,"recurring_frequency_id":3,"recurring_initial_date":"08/12/2020 1:24:10 AM","recurring_is_initial_order":true,"recurring_number":1,"recurring_order_url":"https://www.pixo.com.au/evenico/recurring-order/view/1077","total_no_of_recurring_donations":9,"total_no_of_active_recurring_donations":6,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/102409","order_prefix":"A","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Evenico QA 2.14.0.","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"Do you want more Tim Tams","custom_field_value":"Tell us more","distinct_order_item_types":[1],"str_distinct_order_item_types":"1","order_item_count":1,"payment":{"ref_id":"1526-12e47273-38f4-11eb-b77d-005056b2764e","amount":"8.00","type":"Credit Card"},"items":[{"amount":"8.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $8.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testProcessExistingRecurringDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":102409,"identity_id":"4fb229c0-0868-4dce-b637-99f4d2724db5","created_date":"01/01/0001 12:00:00 AM","completed_date":"08/12/2020 1:24:10 AM","status":7,"amount":"8.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"Recurring","billing_last_name":"Donor","billing_email":"recdonor@pixo.com.au","is_company":false,"billing_company":null,"billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/102409","email_opt_in":false,"refund_date":null,"recurring_order_id":1077,"recurring_frequency_id":3,"recurring_initial_date":"08/12/2020 1:24:10 AM","recurring_is_initial_order":false,"recurring_number":3,"recurring_order_url":"https://www.pixo.com.au/evenico/recurring-order/view/1077","total_no_of_recurring_donations":9,"total_no_of_active_recurring_donations":6,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/102409","order_prefix":"A","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Evenico QA 2.14.0.","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"Do you want more Tim Tams","custom_field_value":"Tell us more","distinct_order_item_types":[1],"str_distinct_order_item_types":"1","order_item_count":1,"payment":{"ref_id":"1526-12e47273-38f4-11eb-b77d-005056b2764e","amount":"8.00","type":"Credit Card"},"items":[{"amount":"8.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $8.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCancelExistingRecurringDonationForExistingContact()
    {
        Contact testContact = new Contact();
        testContact.FirstName = 'Recurring';
        testContact.LastName = 'Donor';
        testContact.Email = 'recdonor@pixo.com.au';
        testContact.Recurring_Donor_Status__c = 'Active';
        testContact.Lapsed_Date__c = null;
        testContact.Total_No_of_Recurring_Donations__c = '9';
        testContact.Total_No_of_Active_Recurring_Donations__c = '5';
        testContact.External_System_Name__c = 'Unity';
        insert testContact;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"CancelRecurringOrder","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":null,"website_name":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":{"recurring_order_id":1075,"identity_id":"4fb229c0-0868-4dce-b637-99f4d2724db5","created_date":"07/12/2020 11:53:06 PM","order_status":5,"due_date":"14/12/2020 11:53:06 PM","recurring_frequency_id":3,"amount":"22.00","billing_first_name":"Recurring","billing_last_name":"Donor","billing_email":"recdonor@pixo.com.au","total_no_of_recurring_donations":9,"total_no_of_active_recurring_donations":4},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testFailExistingRecurringDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"FailedRecurringOrder","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":null,"website_name":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":{"recurring_order_id":1077,"identity_id":"4fb229c0-0868-4dce-b637-99f4d2724db5","created_date":"08/12/2020 1:24:11 AM","order_status":4,"due_date":"08/12/2020 12:10:02 AM","recurring_frequency_id":2,"amount":"12.00","billing_first_name":"Recurring","billing_last_name":"Donor","billing_email":"recdonor@pixo.com.au","total_no_of_recurring_donations":9,"total_no_of_active_recurring_donations":5},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testClaimedTicketRegistrantAsCampaignMember()    // Updated
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"no_of_event_reg_tickets":0,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"cd8eba72-3c19-471b-afc0-7c0f2d02ac35","softCredit_first_name":"TestClaimedUser01","softCredit_last_name":"LastNameClaimed01","softCredit_email":"testclaimeduser01@pixo.com.au","softCredit_street":null,"softCredit_city":null,"softCredit_state":null,"softCredit_postcode":null,"softCredit_country":null,"softCredit_phone":null,"softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":"TestClaimedUser01 LastNameClaimed01 Page","sponsor_page_id":64,"salesforce_sponsor_page_id":"4b632c98-5dc4-43d5-a4e4-347da1bf5e98","sponsor_page_created_date":"05/09/2022 12:50:49 PM","sponsor_page_end_date":"05/09/2023 12:50:49 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/64","is_team":false,"current_amount":"0.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":{"user_identity_id":"cd8eba72-3c19-471b-afc0-7c0f2d02ac35","user_salutation":"Ms","user_first_name":"TestClaimedUser01","user_last_name":"LastNameClaimed01","user_email":"testclaimeduser01@pixo.com.au","user_gender":"","user_date_of_birth":"","user_organisation":"","user_ABN":"","user_job_title":"","user_phone":"66600066","user_mailing_street":"650 Chapel St","user_mailing_city":"South Yarra","user_mailing_state":"VIC","user_mailing_postal_code":"3141","user_mailing_country":"Australia","user_shipping_street":"","user_shipping_city":"","user_shipping_state":"","user_shipping_postal_code":"","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false,"event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_campaign_name":"SF Test Event 01","event_or_campaign":"Event","campaign_start_date":"31/08/2022 12:00:00 AM","campaign_end_date":"10/09/2022 12:00:00 AM","event_or_campaign_url":"https://www.pixo.com.au/pixo-admin/events/17"},"recurring_order":null,"member_user":null,"user_account_custom_fields":[{"form_field_id":10043,"field_type_id":4,"api_name":"Final_Email__c","form_field_name":"SF Final Email (account)","form_value":"testclaimeduserfinal01@pixo.com.au"}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testClaimedTicketRegistrantAsCampaignMemberForExistingCampaign()     // Updated
    {
        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'Test Event';
        testCampaign.ParentId = null;
        testCampaign.Type = 'Event';
        testCampaign.Status = 'In Progress';
        testCampaign.IsActive = True;
        testCampaign.StartDate = Date.parse('01/01/2022');
        testCampaign.EndDate = Date.parse('31/12/2022');
        testCampaign.External_ID__c = '1d9fed5b-1363-486c-b84c-030ca5011dce';
        testCampaign.External_System_Name__c = 'Unity';
        testCampaign.External_System_Link__c = 'https://www.pixo.com.au/evenico/event/view/5';
        insert testCampaign;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"no_of_event_reg_tickets":0,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"cd8eba72-3c19-471b-afc0-7c0f2d02ac35","softCredit_first_name":"TestClaimedUser02","softCredit_last_name":"LastNameClaimed02","softCredit_email":"testclaimeduser02@pixo.com.au","softCredit_street":null,"softCredit_city":null,"softCredit_state":null,"softCredit_postcode":null,"softCredit_country":null,"softCredit_phone":null,"softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":"TestClaimedUser02 LastNameClaimed02 Page","sponsor_page_id":64,"salesforce_sponsor_page_id":"4b632c98-5dc4-43d5-a4e4-347da1bf5e98","sponsor_page_created_date":"05/09/2022 12:50:49 PM","sponsor_page_end_date":"05/09/2023 12:50:49 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/64","is_team":false,"current_amount":"0.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":{"user_identity_id":"cd8eba72-3c19-471b-afc0-7c0f2d02ac35","user_salutation":"Ms","user_first_name":"TestClaimedUser02","user_last_name":"LastNameClaimed01","user_email":"testclaimeduser02@pixo.com.au","user_gender":"","user_date_of_birth":"","user_organisation":"","user_ABN":"","user_job_title":"","user_phone":"66600066","user_mailing_street":"650 Chapel St","user_mailing_city":"South Yarra","user_mailing_state":"VIC","user_mailing_postal_code":"3141","user_mailing_country":"Australia","user_shipping_street":"","user_shipping_city":"","user_shipping_state":"","user_shipping_postal_code":"","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false,"event_campaign_id":17,"salesforce_event_campaign_id":"1d9fed5b-1363-486c-b84c-030ca5011dce","event_campaign_name":"Test Event","event_or_campaign":"Event","campaign_start_date":"01/01/2022 12:00:00 AM","campaign_end_date":"31/12/2022 23:59:00 AM","event_or_campaign_url":"https://www.pixo.com.au/evenico/event/view/5"},"recurring_order":null,"member_user":null,"user_account_custom_fields":[{"form_field_id":10043,"field_type_id":4,"api_name":"Final_Email__c","form_field_name":"SF Final Email (account)","form_value":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testUpdateExistingIndividualContactAddress()     // Update
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'Biller';
        testExistingContact.LastName = 'Contact';
        testExistingContact.Email = 'biller@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e522222';
        testExistingContact.MailingStreet = '123 Test Street';
        testExistingContact.MailingCity = 'Melbourne';
        testExistingContact.MailingState = 'VIC';
        testExistingContact.MailingPostalCode = '3000';
        testExistingContact.MailingCountry = 'Australia';
        testExistingContact.OtherStreet = '431 Other Test Street';
        testExistingContact.OtherCity = 'City';
        testExistingContact.OtherState = 'State';
        testExistingContact.OtherPostalCode = '1234';
        testExistingContact.OtherCountry = 'Australia';
        insert testExistingContact;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"no_of_event_reg_tickets":0,"payment":null,"items":null,"soft_credit":null,"user_account":{"user_identity_id":"c7bd062c-a153-4a76-8f73-0b424e522222","user_salutation":"Ms","user_first_name":"Biller","user_last_name":"Contact","user_email":"biller@test.com","user_gender":"Prefer to not specify","user_date_of_birth":"20/09/1985 12:00:00 AM","user_organisation":"","user_ABN":"","user_job_title":"Admin","user_phone":"987654321","user_mailing_street":"650 Chapel St","user_mailing_city":"South Yarra","user_mailing_state":"VIC","user_mailing_postal_code":"3141","user_mailing_country":"Australia","user_shipping_street":"","user_shipping_city":"","user_shipping_state":"","user_shipping_postal_code":"","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_campaign_name":null,"event_or_campaign":null,"campaign_start_date":null,"campaign_end_date":null,"event_or_campaign_url":null},"recurring_order":null,"member_user":null,"user_account_custom_fields":[{"form_field_id":10043,"field_type_id":4,"api_name":"Final_Email__c","form_field_name":"SF Final Email (account)","form_value":"billerfinal@test.com"}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testOrderDescription()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100128,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"23/08/2021 6:53:23 AM","completed_date":"23/08/2021 4:53:25 PM","status":7,"amount":"10.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"123 Test Street","billing_city":"City","billing_state":"State","billing_postcode":"1234","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/100128","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100128","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":"","payment":{"ref_id":"ch_3JRX28DI7EF9k4gO1wCQKelB","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $10.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testAdminOrderBasedOnDonorIDField()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'Biller';
        testExistingContact.LastName = 'Contact';
        testExistingContact.Email = 'biller@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e522222';
        insert testExistingContact;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        //req.requestBody = blob.valueof('{"id":100283,"identity_id":"c7bd062c-a153-4a76-8f73-0b424e522222","created_date":"10/09/2021 1:45:35 AM","completed_date":"10/09/2021 11:45:36 AM","status":7,"amount":"16.00","gst":"0.00","billing_first_name":"Biller","billing_last_name":"Contact","billing_email":"biller@test.com","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"111222333","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/100283","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":true,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100283","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name for testing","donor_id_api_name":"Salesforce_Contact_ID__c","api_salesforce_donor_id":"100131","payment":{"ref_id":"ch_3JXyo7KdHt4xSAm6184uVKDm","amount":"16.00","custom_field_name":"Do you want more Tim Tams","custom_field_value":"Yes please","type":"Credit Card"},"items":[{"amount":"16.00","type":1,"type_id":"","quantity":1,"details":"Donation: $16.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');
        req.requestBody = blob.valueof('{"id":101410,"identity_id":"","created_date":"04/08/2022 2:00:00 PM","completed_date":"05/08/2022 5:02:02 PM","status":7,"amount":"25.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"25.00","billing_first_name":"Biller","billing_last_name":"Contact","billing_email":"biller@test.com","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/101410","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":true,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101410","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"Salesforce_Contact_ID__c","api_salesforce_donor_id":"100131","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[1],"str_distinct_order_item_types":"1","order_item_count":1,"payment":{"ref_id":"ch_3LTKXlKdHt4xSAm61KAU8jMT","amount":"25.00","type":"Credit Card"},"items":[{"amount":"25.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"25.00","type":1,"type_id":"","quantity":1,"details":"Donation: $25.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');
        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testAdminOrderBasedOnFirstnameLastnameEmail()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100283,"identity_id":"c7bd062c-a153-4a76-8f73-0b424e522222","created_date":"10/09/2021 1:45:35 AM","completed_date":"10/09/2021 11:45:36 AM","status":7,"amount":"16.00","gst":"0.00","billing_first_name":"Biller","billing_last_name":"Contact","billing_email":"biller@test.com","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"111222333","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/100283","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":true,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100283","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name for testing","donor_id_api_name":"Salesforce_Contact_ID__c","api_salesforce_donor_id":"","custom_field_name":"Do you want more Tim Tams","custom_field_value":"Yes!!","payment":{"ref_id":"ch_3JXyo7KdHt4xSAm6184uVKDm","amount":"16.00","type":"Credit Card"},"items":[{"amount":"16.00","type":1,"type_id":"","quantity":1,"details":"Donation: $16.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testAdminOrderBasedOnIncorrectDonorIDField()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'Biller';
        testExistingContact.LastName = 'Contact';
        testExistingContact.Email = 'biller@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e522222';
        insert testExistingContact;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100283,"identity_id":"c7bd062c-a153-4a76-8f73-0b424e522222","created_date":"10/09/2021 1:45:35 AM","completed_date":"10/09/2021 11:45:36 AM","status":7,"amount":"16.00","gst":"0.00","billing_first_name":"Biller","billing_last_name":"Contact","billing_email":"biller@test.com","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"111222333","billing_fax":"","related_url":"https://www.pixo.com.au/evenico/order/view/100283","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":true,"call_made_from":"Order","order_url":"https://www.pixo.com.au/evenico/order/view/100283","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name for testing","donor_id_api_name":"Salesforce_Donor_Contact_ID__c","api_salesforce_donor_id":"100131","payment":{"ref_id":"ch_3JXyo7KdHt4xSAm6184uVKDm","amount":"16.00","type":"Credit Card"},"items":[{"amount":"16.00","type":1,"type_id":"","quantity":1,"details":"Donation: $16.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testInMemoryDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101168,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"16/02/2022 4:20:43 AM","completed_date":"16/02/2022 3:20:45 PM","status":7,"amount":"3.00","gst":"0.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"885522","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/memory/8","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101168","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","payment":{"ref_id":"ch_3KTf0SKdHt4xSAm61gJ1KH6J","amount":"3.00","type":"Credit Card"},"items":[{"amount":"3.00","type":9,"type_id":"8","quantity":1,"details":"In Memory Donation for MemoryFirst MemoryLast","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/memory/8","membership_level":"","membership_frequency":"","membership_expire_date":"","tribute_name":"MemoryFirst MemoryLast","item_related_url":"","type_name":"In Memory Donation"}],"soft_credit":{"softCredit_identity_id":"42144f27-801c-4c80-955a-ddfc0f065f87","softCredit_first_name":"Test","softCredit_last_name":"Admin","softCredit_email":"testadmin@pixo.com.au","softCredit_street":"123 Test Street","softCredit_city":"Melbourne","softCredit_state":"Victoria","softCredit_postcode":"3001","softCredit_country":"Australia","softCredit_phone":"147258369","softCredit_shipping_street":"463 Shipping Street","softCredit_shipping_city":"Melbourne","softCredit_shipping_state":"Victoria","softCredit_shipping_postcode":"3005","softCredit_shipping_country":"Australia","sponsor_page_name":null,"sponsor_page_id":null,"salesforce_sponsor_page_id":null,"sponsor_page_created_date":null,"sponsor_page_end_date":null,"sponsor_donation_amount":null,"sponsor_page_url":null,"is_team":false,"current_amount":"28.0000","target_amount":null,"in_memory_page_name":"MemoryFirst MemoryLast","in_memory_page_id":8,"salesforce_in_memory_page_id":"7c4adf29-48e4-4a83-bce5-e78d86cbd66e","in_memory_page_created_date":"12/01/2022 1:44:50 PM"},"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    /*static testMethod void testMembershipOrder()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101296,"identity_id":"bc736d65-640c-4faa-9166-546690e6e8e4","created_date":"12/05/2022 6:32:06 AM","completed_date":"12/05/2022 4:32:08 PM","status":7,"amount":"160.00","gst":"13.64","billing_first_name":"Test","billing_last_name":"user","billing_email":"testuser@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/6","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101296","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"payment":{"ref_id":"ch_3KyVZDKdHt4xSAm61gQRRMNh","amount":"160.00","type":"Credit Card"},"items":[{"amount":"150.00","type":7,"type_id":"6","quantity":1,"details":"Member registration for Half Yearly","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Test membership one","salesforce_membership_id":"68fa9506-a878-4780-88c6-fd4602564b53","membership_level":"Half Yearly","membership_frequency":"Half-yearly","membership_valid_from":"12/05/2022 4:32:08 PM","membership_valid_to":"12/11/2022 5:32:08 PM","membership_origin":"","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/1/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/6","type_name":"Membership"},{"amount":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $10.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    static testMethod void testExpiredMembership()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"ExpiredMembership","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":{"member_identity_id":"b0cede6c-1d90-4265-a875-9eb740fb68d1","member_first_name":"Test","member_last_name":"Member","member_email":"testmember@pixo.com.au","member_phone":"","member_mailing_street":null,"member_mailing_city":null,"member_mailing_state":null,"member_mailing_postal_code":null,"member_mailing_country":null,"member_shipping_street":null,"member_shipping_city":null,"member_shipping_state":null,"member_shipping_postal_code":null,"member_shipping_country":null,"membership_program_name":"Final Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testExpiredMembershipExistingContact()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'Member';
        testExistingContact.LastName = 'Contact';
        testExistingContact.Email = 'member@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e533222';
        insert testExistingContact;

        Campaign testExistingCampaign = new Campaign();
        testExistingCampaign.Name = 'Test Membership Program';
        testExistingCampaign.External_ID__c = '0cb107a9-7df1-40b2-a974-22062845550e';
        testExistingCampaign.External_System_Link__c = 'https://www.pixo.com.au/pixo-admin/memberships/5/types';
        insert testExistingCampaign;

        CampaignMember testExistingCampaignMember = new CampaignMember();
        testExistingCampaignMember.CampaignID = testExistingCampaign.Id;
        testExistingCampaignMember.ContactID = testExistingContact.Id;
        testExistingCampaignMember.Status = 'Responded';
        insert testExistingCampaignMember;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"ExpiredMembership","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":{"member_identity_id":"b0cede6c-1d90-4265-a875-9eb740fb68d1","member_first_name":"Member","member_last_name":"Contact","member_email":"member@test.com","member_phone":"","member_mailing_street":null,"member_mailing_city":null,"member_mailing_state":null,"member_mailing_postal_code":null,"member_mailing_country":null,"member_shipping_street":null,"member_shipping_city":null,"member_shipping_state":null,"member_shipping_postal_code":null,"member_shipping_country":null,"membership_program_name":"Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testClaimedMembership()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"ClaimedMembership","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":{"member_identity_id":"54e36671-e078-44e6-a6a4-75062ebc0eae","member_first_name":"Member","member_last_name":"Contact","member_email":"member@pixo.com.au","member_phone":"","member_mailing_street":"454 St Kilda Rd","member_mailing_city":"Melbourne","member_mailing_state":"VIC","member_mailing_postal_code":"3004","member_mailing_country":"Australia","member_shipping_street":"","member_shipping_city":"","member_shipping_state":"","member_shipping_postal_code":"","member_shipping_country":"Australia","membership_program_name":"Test Membership Program","salesforce_membership_id":"0d2678b2-5f6c-4699-a024-e2254cd5d9f7","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/4/types"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testClaimedMembershipExistingContact()
    {
        Contact testExistingContact = new Contact();
        testExistingContact.FirstName = 'MemberB';
        testExistingContact.LastName = 'ContactB';
        testExistingContact.Email = 'memberb@test.com';
        testExistingContact.External_System_Name__c = 'Unity';
        testExistingContact.External_ID__c = 'c7bd062c-a153-4a76-8f73-0b424e533222';
        insert testExistingContact;

        Campaign testExistingCampaign = new Campaign();
        testExistingCampaign.Name = 'Test Membership Program';
        testExistingCampaign.Type = 'Membership';
        testExistingCampaign.External_ID__c = '0cb107a9-7df1-40b2-a974-22062845550e';
        testExistingCampaign.External_System_Link__c = 'https://www.pixo.com.au/pixo-admin/memberships/5/types';
        insert testExistingCampaign;

        CampaignMember testExistingCampaignMember = new CampaignMember();
        testExistingCampaignMember.CampaignID = testExistingCampaign.Id;
        testExistingCampaignMember.ContactID = testExistingContact.Id;
        testExistingCampaignMember.Status = 'Lapsed';
        insert testExistingCampaignMember;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"ClaimedMembership","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":{"member_identity_id":"54e36671-e078-44e6-a6a4-75062ebc0eae","member_first_name":"MemberB","member_last_name":"ContactB","member_email":"memberb@pixo.com.au","member_phone":"","member_mailing_street":"454 St Kilda Rd","member_mailing_city":"Melbourne","member_mailing_state":"VIC","member_mailing_postal_code":"3004","member_mailing_country":"Australia","member_shipping_street":"","member_shipping_city":"","member_shipping_state":"","member_shipping_postal_code":"","member_shipping_country":"Australia","membership_program_name":"Test Membership Program","salesforce_membership_id":"0d2678b2-5f6c-4699-a024-e2254cd5d9f7","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/4/types"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    /*static testMethod void testMembershipToBeApproved()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101347,"identity_id":"c561058f-55a4-450d-ab62-1b6620953cb0","created_date":"19/05/2022 5:28:16 AM","completed_date":"19/05/2022 3:28:22 PM","status":7,"amount":"150.00","gst":"13.64","billing_first_name":"Member01","billing_last_name":"Contact01","billing_email":"member01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/55","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101347","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"payment":{"ref_id":"ch_3L11uJKdHt4xSAm60vARxkG2","amount":"150.00","type":"Credit Card"},"items":[{"amount":"150.00","type":7,"type_id":"55","quantity":1,"details":"Member registration for Option 1D - Admin Approval","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_level":"Option 1 - Admin Approval","membership_frequency":"Daily","membership_valid_from":"","membership_valid_to":"","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/55","type_name":"Membership"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }*/

    static testMethod void testCreateFundraisingTeamPageAttachedToEvent()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"CreateFundraisingPage","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"2ad48772-5575-4c80-9029-15ee5e9e9196","softCredit_first_name":"SevenB","softCredit_last_name":"User07B","softCredit_email":"use07b@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"User 07 Team Page!","sponsor_page_id":243,"salesforce_sponsor_page_id":"14570ef6-8980-4bfc-a5cd-d67a843a8468","sponsor_page_created_date":"02/08/2022 12:08:43 PM","sponsor_page_end_date":"02/08/2023 12:08:43 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/243","is_team":true,"current_amount":"0.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":85,"salesforce_event_campaign_id":"dae1ee87-5491-4f65-b775-2f15cc8b46a6","event_name":"Test Fundraising Event 01","campaign_name":null,"event_campaign_start_date":"01/08/2022 12:00:00 AM","event_campaign_end_date":"03/08/2022 12:00:00 AM","event_campaign_url":"https://www.pixo.com.au/pixo-admin/events/85"},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateIndivFundraisingPageAttachedToCampaign()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"CreateFundraisingPage","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"09feee34-1a0c-4a25-a62f-563c7519b319","softCredit_first_name":"Joey","softCredit_last_name":"Tribbiani","softCredit_email":"joey@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"Joey Tribbianis Page - Campaign","sponsor_page_id":240,"salesforce_sponsor_page_id":"b6ccea14-ea94-4fe8-8d75-ef2a17a48bab","sponsor_page_created_date":"02/08/2022 11:55:08 AM","sponsor_page_end_date":"02/08/2023 11:59:59 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/240","is_team":false,"current_amount":"0.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":29,"salesforce_event_campaign_id":"c8b415d0-74c9-44af-86fe-8adda0957ed2","event_name":null,"campaign_name":"Test SF Fund. Camp. 01","event_campaign_start_date":"01/08/2022 12:00:00 AM","event_campaign_end_date":"20/08/2022 12:00:00 AM","event_campaign_url":"https://www.pixo.com.au/pixo-admin/campaigns/29"},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateUntetheredFundraisingPage()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"CreateFundraisingPage","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"f8927a92-67bb-4522-aeab-15cb94be3b0b","softCredit_first_name":"TwoB","softCredit_last_name":"User02B","softCredit_email":"user02b@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"TwoB User02Bs Page - untethered","sponsor_page_id":241,"salesforce_sponsor_page_id":"87f12c8e-953e-45df-b8c9-845f4ea4e71c","sponsor_page_created_date":"02/08/2022 12:04:39 PM","sponsor_page_end_date":"02/08/2023 12:04:39 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/241","is_team":false,"current_amount":"0.0000","target_amount":"750.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCreateFundraisingPageWhenTicketIsClaimed()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"f8927a92-67bb-4522-aeab-15cb94be3b0b","softCredit_first_name":"TwoB","softCredit_last_name":"User02B","softCredit_email":"user02b@pixo.com.au","softCredit_street":null,"softCredit_city":null,"softCredit_state":null,"softCredit_postcode":null,"softCredit_country":null,"softCredit_phone":null,"softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":"TwoB User02B","sponsor_page_id":234,"salesforce_sponsor_page_id":"322219c5-22f4-442b-86fa-a6f453d622f3","sponsor_page_created_date":"02/08/2022 11:21:52 AM","sponsor_page_end_date":"02/08/2023 11:21:41 AM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/234","is_team":false,"current_amount":"0.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":{"user_identity_id":"f8927a92-67bb-4522-aeab-15cb94be3b0b","user_salutation":"","user_first_name":"TwoB","user_last_name":"User02B","user_email":"user02b@pixo.com.au","user_gender":"","user_date_of_birth":"","user_organisation":"","user_ABN":"","user_job_title":"","user_phone":"","user_mailing_street":"","user_mailing_city":"","user_mailing_state":"","user_mailing_postal_code":"","user_mailing_country":"Australia","user_shipping_street":"","user_shipping_city":"","user_shipping_state":"","user_shipping_postal_code":"","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false,"event_campaign_id":85,"salesforce_event_campaign_id":"dae1ee87-5491-4f65-b775-2f15cc8b46a6","event_campaign_name":"Test Fundraising Event 01","event_or_campaign":"Event","campaign_start_date":"01/08/2022 12:00:00 AM","campaign_end_date":"03/08/2022 12:00:00 AM","event_or_campaign_url":"https://www.pixo.com.au/pixo-admin/events/85"},"recurring_order":null,"member_user":null,"user_account_custom_fields":[{"form_field_id":10070,"field_type_id":13,"api_name":"API SF for Multi","form_field_name":"2nd Directory Multi select (account)","form_value":""},{"form_field_id":10037,"field_type_id":4,"api_name":"","form_field_name":"Email for Andrew (account)","form_value":""},{"form_field_id":10046,"field_type_id":5,"api_name":"","form_field_name":"Date Account (account)","form_value":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testGeneralDonationOrderByIndividual()   // Updated
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101385,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"05/08/2022 2:15:53 AM","completed_date":"05/08/2022 12:15:54 PM","status":7,"amount":"10.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"9876 5432","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/101385","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101385","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"Do you want more Tim Tams","custom_field_value":"Tell us more","distinct_order_item_types":[1],"str_distinct_order_item_types":"1","order_item_count":1,"no_of_event_reg_tickets": 0,"payment":{"ref_id":"ch_3LTG4rKdHt4xSAm60YMc8lua","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $10.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testGeneralDonationOrderOnBehalfOfAnOrg()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101386,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"05/08/2022 2:17:43 AM","completed_date":"05/08/2022 12:17:44 PM","status":7,"amount":"5.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"5.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":true,"billing_company":"Pixo Org","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"9876 5432","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/101386","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101386","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"Do you want more Tim Tams","custom_field_value":"no","distinct_order_item_types":[1],"str_distinct_order_item_types":"1","order_item_count":1,"payment":{"ref_id":"ch_3LTG6eKdHt4xSAm61XdJyj12","amount":"5.00","type":"Credit Card"},"items":[{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"5.00","type":1,"type_id":"","quantity":1,"details":"Donation: $5.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationOnly()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101387,"identity_id":"fcebd32f-3b5e-4dee-ac8f-b17a37523d67","created_date":"05/08/2022 3:41:06 AM","completed_date":"05/08/2022 1:41:08 PM","status":3,"amount":"20.00","gst":"1.82","discount_amount":"0.00","subtotal_amount":"20.00","billing_first_name":"OneC","billing_last_name":"User01C","billing_email":"user01c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"45 Clarke St","billing_city":"Southbank","billing_state":"VIC","billing_postcode":"3006","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101387","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101387","order_prefix":"q","shipping_street":"45 Clarke St","shipping_city":"Southbank","shipping_state":"VIC","shipping_postcode":"3006","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,11],"str_distinct_order_item_types":"2,11","order_item_count":2,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTHPLKdHt4xSAm60TsQlRYg","amount":"20.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"276","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101387","type_name":"Event Registration"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":11,"type_id":"72","quantity":1,"details":"Booking Fee","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Booking Fee"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationWithMerch()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101388,"identity_id":"649621ce-6422-45eb-83e9-36b06abedbd3","created_date":"05/08/2022 3:51:30 AM","completed_date":"05/08/2022 1:51:32 PM","status":3,"amount":"60.00","gst":"5.45","discount_amount":"0.00","subtotal_amount":"60.00","billing_first_name":"TwoC","billing_last_name":"User02C","billing_email":"user02c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"65a Yellowbox Dr","billing_city":"Craigieburn","billing_state":"VIC","billing_postcode":"3064","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101388","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101388","order_prefix":"q","shipping_street":"535 Bourke St","shipping_city":"Melbourne","shipping_state":"VIC","shipping_postcode":"3000","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6],"str_distinct_order_item_types":"26","order_item_count":2,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTHZPKdHt4xSAm61OeHCSVi","amount":"60.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"277","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101388","type_name":"Event Registration"},{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":6,"type_id":"11","quantity":1,"details":"Free Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationAndSponsorDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101394,"identity_id":"ab39d5b7-bd4d-4c80-ac59-01a3f069d095","created_date":"05/08/2022 4:49:02 AM","completed_date":"05/08/2022 2:49:04 PM","status":3,"amount":"25.00","gst":"0.91","discount_amount":"0.00","subtotal_amount":"25.00","billing_first_name":"FiveCE","billing_last_name":"User05CE","billing_email":"user05ce@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/254","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101394","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,3],"str_distinct_order_item_types":"2,3","order_item_count":2,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTIT5KdHt4xSAm60CLIcLyl","amount":"25.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"283","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101394","type_name":"Event Registration"},{"amount":"15.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"15.00","type":3,"type_id":"254","quantity":1,"details":"Sponsor Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/254","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"ab39d5b7-bd4d-4c80-ac59-01a3f069d095","softCredit_first_name":"FiveCE","softCredit_last_name":"User05CE","softCredit_email":"user05ce@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"FiveCE User05CEs Page","sponsor_page_id":254,"salesforce_sponsor_page_id":"5edbbbd1-ad36-45e9-9184-02890c4a5977","sponsor_page_created_date":"05/08/2022 2:49:02 PM","sponsor_page_end_date":"05/08/2023 2:49:02 PM","sponsor_donation_amount":"15.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/254","is_team":false,"current_amount":"15.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationAndEventDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101395,"identity_id":"3297957b-0d61-4bd8-9244-2df4122cc0c3","created_date":"05/08/2022 4:53:29 AM","completed_date":"05/08/2022 2:53:31 PM","status":3,"amount":"30.00","gst":"0.91","discount_amount":"0.00","subtotal_amount":"30.00","billing_first_name":"SixC","billing_last_name":"User06C","billing_email":"user06c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/72","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101395","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,10],"str_distinct_order_item_types":"2,10","order_item_count":2,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTIXOKdHt4xSAm61Ogf50u1","amount":"30.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"284","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101395","type_name":"Event Registration"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"20.00","type":10,"type_id":"72","quantity":1,"details":"Event Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72","type_name":"Event Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationWithStoreAndEventDonation()     // 101
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101397,"identity_id":"c3ca9ddf-cab7-416d-9507-7f1812aa6e31","created_date":"05/08/2022 5:02:37 AM","completed_date":"05/08/2022 3:02:39 PM","status":3,"amount":"80.00","gst":"5.45","discount_amount":"0.00","subtotal_amount":"80.00","billing_first_name":"EightC","billing_last_name":"User08C","billing_email":"user08c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/72","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101397","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,10],"str_distinct_order_item_types":"2,6,10","order_item_count":3,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTIgEKdHt4xSAm61E1FGuKD","amount":"80.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"286","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101397","type_name":"Event Registration"},{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":6,"type_id":"11","quantity":1,"details":"Free Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"20.00","type":10,"type_id":"72","quantity":1,"details":"Event Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72","type_name":"Event Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationWithStoreAndSponsorDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101396,"identity_id":"f2a67a5b-78bd-4344-9778-74ae70da1c1e","created_date":"05/08/2022 4:58:19 AM","completed_date":"05/08/2022 2:58:20 PM","status":3,"amount":"65.00","gst":"5.45","discount_amount":"0.00","subtotal_amount":"65.00","billing_first_name":"SevenC","billing_last_name":"User07C","billing_email":"user07c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/256","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101396","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,3],"str_distinct_order_item_types":"2,6,3","order_item_count":3,"no_of_event_reg_tickets":1,"payment":{"ref_id":"ch_3LTIc3KdHt4xSAm61FaEO33K","amount":"65.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"285","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101396","type_name":"Event Registration"},{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":6,"type_id":"11","quantity":1,"details":"Free Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"5.00","type":3,"type_id":"256","quantity":1,"details":"Sponsor Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/256","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"f2a67a5b-78bd-4344-9778-74ae70da1c1e","softCredit_first_name":"SevenC","softCredit_last_name":"User07C","softCredit_email":"user07c@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"SevenC User07Cs Page","sponsor_page_id":256,"salesforce_sponsor_page_id":"1fcc9a1e-3029-4830-b1f6-899a4e71f30a","sponsor_page_created_date":"05/08/2022 2:58:19 PM","sponsor_page_end_date":"05/08/2023 2:58:19 PM","sponsor_donation_amount":"5.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/256","is_team":false,"current_amount":"5.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventRegistrationForAnotherUserWithStoreAndSponsorDonation()     // 101
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101399,"identity_id":"c3ca9ddf-cab7-416d-9507-7f1812aa6e31","created_date":"05/08/2022 5:33:17 AM","completed_date":"05/08/2022 3:33:18 PM","status":3,"amount":"90.00","gst":"6.36","discount_amount":"0.00","subtotal_amount":"80.00","billing_first_name":"EightC","billing_last_name":"User08C","billing_email":"user08ce@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/259","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101399","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,3,12],"str_distinct_order_item_types":"2,6,3,12","order_item_count":4,"payment":{"ref_id":"ch_3LTJ9tKdHt4xSAm61nRZybij","amount":"90.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":2,"type_id":"288","quantity":1,"details":"Fee 1 registration for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72/registrations?order_id=101399","type_name":"Event Registration"},{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":6,"type_id":"12","quantity":1,"details":"Product with shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"20.00","type":3,"type_id":"259","quantity":1,"details":"Sponsor Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/259","type_name":"Sponsor Donation"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping"}],"soft_credit":{"softCredit_identity_id":"c3ca9ddf-cab7-416d-9507-7f1812aa6e31","softCredit_first_name":"EightC","softCredit_last_name":"User08C","softCredit_email":"user08ce@pixo.com.au","softCredit_street":"","softCredit_city":"","softCredit_state":"","softCredit_postcode":"","softCredit_country":"Australia","softCredit_phone":"","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"EightCE User08CEs Page","sponsor_page_id":259,"salesforce_sponsor_page_id":"ea3ff3d6-4b46-47d7-9e45-61da6e4004c1","sponsor_page_created_date":"05/08/2022 3:33:17 PM","sponsor_page_end_date":"05/08/2023 3:33:17 PM","sponsor_donation_amount":"20.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/259","is_team":false,"current_amount":"20.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testClaimedTicket()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":null,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"UserAccount","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"payment":null,"items":null,"soft_credit":{"softCredit_identity_id":"21c6739d-85fa-464d-a538-ac4f0310fb43","softCredit_first_name":"EightCE","softCredit_last_name":"User08CE","softCredit_email":"user08ce@pixo.com.au","softCredit_street":null,"softCredit_city":null,"softCredit_state":null,"softCredit_postcode":null,"softCredit_country":null,"softCredit_phone":null,"softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":"EightCE User08CE","sponsor_page_id":259,"salesforce_sponsor_page_id":"ea3ff3d6-4b46-47d7-9e45-61da6e4004c1","sponsor_page_created_date":"05/08/2022 3:33:17 PM","sponsor_page_end_date":"05/08/2023 3:33:17 PM","sponsor_donation_amount":null,"sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/259","is_team":false,"current_amount":"20.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":{"user_identity_id":"21c6739d-85fa-464d-a538-ac4f0310fb43","user_salutation":"","user_first_name":"EightCE","user_last_name":"User08CE","user_email":"user08ce@pixo.com.au","user_gender":"","user_date_of_birth":"","user_organisation":"","user_ABN":"","user_job_title":"","user_phone":"","user_mailing_street":"","user_mailing_city":"","user_mailing_state":"","user_mailing_postal_code":"","user_mailing_country":"Australia","user_shipping_street":"","user_shipping_city":"","user_shipping_state":"","user_shipping_postal_code":"","user_shipping_country":"Australia","user_marketing_approval":null,"user_is_company":false,"event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_campaign_name":"Shipping!","event_or_campaign":"Event","campaign_start_date":"21/02/2022 12:00:00 AM","campaign_end_date":"15/02/2027 12:00:00 AM","event_or_campaign_url":"https://www.pixo.com.au/pixo-admin/events/72"},"recurring_order":null,"member_user":null,"user_account_custom_fields":[{"form_field_id":10070,"field_type_id":13,"api_name":"API SF for Multi","form_field_name":"2nd Directory Multi select (account)","form_value":""},{"form_field_id":10037,"field_type_id":4,"api_name":"","form_field_name":"Email for Andrew (account)","form_value":""},{"form_field_id":10046,"field_type_id":5,"api_name":"","form_field_name":"Date Account (account)","form_value":""}]}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testSponsorDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101400,"identity_id":"21c6739d-85fa-464d-a538-ac4f0310fb43","created_date":"05/08/2022 5:43:01 AM","completed_date":"05/08/2022 3:43:03 PM","status":7,"amount":"10.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"EightCE","billing_last_name":"User08CE","billing_email":"user08ce@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/166","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101400","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[3],"str_distinct_order_item_types":"3","order_item_count":1,"payment":{"ref_id":"ch_3LTJJKKdHt4xSAm60m35RsWA","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":3,"type_id":"166","quantity":1,"details":"Sponsor Donation for Individual Fundraiser","event_campaign_id":79,"salesforce_event_campaign_id":"3f49985c-f701-4649-964d-d2c517f060f1","event_name":"Event Fundraiser","event_start_date":"25/02/2022 12:00:00 AM","event_end_date":"26/02/2022 12:59:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/79","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/166","type_name":"Sponsor Donation"}],"soft_credit":{"softCredit_identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","softCredit_first_name":"Pixo","softCredit_last_name":"Support","softCredit_email":"support-admin@pixo.com.au","softCredit_street":"56 Montrose Road","softCredit_city":"Malvern","softCredit_state":"VIC","softCredit_postcode":"3144","softCredit_country":"Australia","softCredit_phone":"9876 5432","softCredit_shipping_street":"51 Allison Grove","softCredit_shipping_city":"Malvern","softCredit_shipping_state":"VIC","softCredit_shipping_postcode":"3144","softCredit_shipping_country":"Australia","sponsor_page_name":"Individual Fundraiser","sponsor_page_id":166,"salesforce_sponsor_page_id":"ae55ad24-4d7e-4a2c-bc72-4e4026e8e0c9","sponsor_page_created_date":"23/02/2022 1:35:34 PM","sponsor_page_end_date":"23/02/2023 1:35:34 PM","sponsor_donation_amount":"10.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/166","is_team":false,"current_amount":"60.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testCampaignDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101403,"identity_id":"21c6739d-85fa-464d-a538-ac4f0310fb43","created_date":"05/08/2022 5:50:08 AM","completed_date":"05/08/2022 3:50:09 PM","status":7,"amount":"15.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"15.00","billing_first_name":"EightCE","billing_last_name":"User08CE","billing_email":"user08ce@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"123456789","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/campaigns/29","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101403","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[4],"str_distinct_order_item_types":"4","order_item_count":1,"payment":{"ref_id":"ch_3LTJQCKdHt4xSAm60u3Mf6TK","amount":"15.00","type":"Credit Card"},"items":[{"amount":"15.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"15.00","type":4,"type_id":"29","quantity":1,"details":"Campaign Donation for Test Fundraising Campaign 01","event_campaign_id":29,"salesforce_event_campaign_id":"c8b415d0-74c9-44af-86fe-8adda0957ed2","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"Test SF Fund. Camp. 01","campaign_start_date":"01/08/2022 12:00:00 AM","campaign_end_date":"20/08/2022 12:00:00 AM","campaign_url":"https://www.pixo.com.au/pixo-admin/campaigns/29","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Campaign Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testStore()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101402,"identity_id":"21c6739d-85fa-464d-a538-ac4f0310fb43","created_date":"05/08/2022 5:47:20 AM","completed_date":"05/08/2022 3:47:21 PM","status":3,"amount":"100.00","gst":"9.09","discount_amount":"0.00","subtotal_amount":"50.00","billing_first_name":"EightCE","billing_last_name":"User08CE","billing_email":"user08ce@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/101402","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101402","order_prefix":"q","shipping_street":"640 Swanston St","shipping_city":"Carlton","shipping_state":"VIC","shipping_postcode":"3053","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[6],"str_distinct_order_item_types":"6","order_item_count":1,"payment":{"ref_id":"ch_3LTJNUKdHt4xSAm60nZv78AV","amount":"100.00","type":"Credit Card"},"items":[{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":6,"type_id":"12","quantity":1,"details":"Product with shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMembershipOnly()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101404,"identity_id":"b36ca547-b423-4bd9-af25-cc16514b284c","created_date":"05/08/2022 5:57:24 AM","completed_date":"05/08/2022 3:57:30 PM","status":7,"amount":"10.00","gst":"0.91","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"NineC","billing_last_name":"User09C","billing_email":"user09c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/63","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101404","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[7],"str_distinct_order_item_types":"7","order_item_count":1,"payment":{"ref_id":"ch_3LTJXGKdHt4xSAm60HS9Bry8","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":7,"type_id":"63","quantity":1,"details":"Member registration for Option 1A","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Final Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_level":"Option 1A","membership_frequency":"Daily","membership_valid_from":"05/08/2022 3:57:30 PM","membership_valid_to":"06/08/2022 3:57:30 PM","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/63","type_name":"Membership"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMembershipWithMerch()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101405,"identity_id":"b36ca547-b423-4bd9-af25-cc16514b284c","created_date":"05/08/2022 6:12:50 AM","completed_date":"05/08/2022 4:12:58 PM","status":3,"amount":"65.58","gst":"5.96","discount_amount":"0.00","subtotal_amount":"65.58","billing_first_name":"NineC","billing_last_name":"User09C","billing_email":"user09c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/64","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101405","order_prefix":"q","shipping_street":"694 Test Street","shipping_city":"TestCity","shipping_state":"TestState","shipping_postcode":"1232","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[7,6],"str_distinct_order_item_types":"7,6","order_item_count":2,"payment":{"ref_id":"ch_3LTJmEKdHt4xSAm61gsZ1PdQ","amount":"65.58","type":"Credit Card"},"items":[{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"4.55","amount_subtotal":"50.00","type":7,"type_id":"64","quantity":1,"details":"Member registration for Option 1B","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Final Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_level":"Option 1B","membership_frequency":"Quarterly","membership_valid_from":"05/08/2022 4:12:58 PM","membership_valid_to":"05/11/2022 5:12:58 PM","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/64","type_name":"Membership"},{"amount":"15.58","total_discount_amount":"0.00","total_tax_amount":"1.42","amount_subtotal":"15.58","type":6,"type_id":"4","quantity":1,"details":"Test","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMembershipWithDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101406,"identity_id":"b36ca547-b423-4bd9-af25-cc16514b284c","created_date":"05/08/2022 6:24:15 AM","completed_date":"05/08/2022 4:24:22 PM","status":7,"amount":"110.00","gst":"9.09","discount_amount":"0.00","subtotal_amount":"110.00","billing_first_name":"NineC","billing_last_name":"User09C","billing_email":"user09c@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/65","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101406","order_prefix":"q","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[7,1],"str_distinct_order_item_types":"7,1","order_item_count":2,"payment":{"ref_id":"ch_3LTJxGKdHt4xSAm61MC0LSzY","amount":"110.00","type":"Credit Card"},"items":[{"amount":"100.00","total_discount_amount":"0.00","total_tax_amount":"9.09","amount_subtotal":"100.00","type":7,"type_id":"65","quantity":1,"details":"Member registration for Option 1C","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Final Test Membership Program","salesforce_membership_id":"0cb107a9-7df1-40b2-a974-22062845550e","membership_level":"Option 1C","membership_frequency":"Half-yearly","membership_valid_from":"05/08/2022 4:24:22 PM","membership_valid_to":"05/02/2023 5:24:22 PM","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/5/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/65","type_name":"Membership"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":1,"type_id":"","quantity":1,"details":"Donation: $10.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMembershipWithMerchAndDonation() // 101
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100391,"identity_id":"60df7c3a-59bb-437b-98b8-eb2e394347f6","created_date":"05/09/2022 1:31:12 AM","completed_date":"05/09/2022 11:31:19 AM","status":3,"amount":"117.00","gst":"6.09","discount_amount":"0.00","subtotal_amount":"112.00","billing_first_name":"TestDC01","billing_last_name":"LastDC01","billing_email":"testdc01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/148","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100391","order_prefix":"a","shipping_street":"564 Test Street","shipping_city":"TestSuburb","shipping_state":"Vic","shipping_postcode":"3333","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[7,6,1,12],"str_distinct_order_item_types":"7,6,1,12","order_item_count":6,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LeU9gDI7EF9k4gO0UFEfpkF","amount":"117.00","type":"Credit Card"},"items":[{"amount":"2.00","total_discount_amount":"0.00","total_tax_amount":"0.18","amount_subtotal":"2.00","type":7,"type_id":"148","quantity":1,"details":"Member registration for Daily membership","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"SF Test Membership Hotfix 01","salesforce_membership_id":"8fbf404c-f3cc-462a-aa7c-166174abe2d1","membership_level":"Daily membership","membership_frequency":"Daily","membership_valid_from":"05/09/2022 11:31:19 AM","membership_valid_to":"06/09/2022 11:31:19 AM","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/14/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/148","type_name":"Membership"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":6,"type_id":"15","quantity":1,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"17","quantity":1,"details":"T-Shirt (One size)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"50.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"50.00","type":1,"type_id":"1","quantity":1,"details":"Donation: $50.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation"},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.45","amount_subtotal":"5.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testInMemoryDonationOrder()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101408,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"05/08/2022 6:34:41 AM","completed_date":"05/08/2022 4:34:43 PM","status":7,"amount":"10.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"10.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"9876 5432","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/memory/8","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101408","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[9],"str_distinct_order_item_types":"9","order_item_count":1,"no_of_event_reg_tickets": 0,"payment":{"ref_id":"ch_3LTK7KKdHt4xSAm61AfL4s3k","amount":"10.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":9,"type_id":"8","quantity":1,"details":"In Memory Donation for MemoryFirst MemoryLast","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/memory/8","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"MemoryFirst MemoryLast","item_related_url":"","type_name":"In Memory Donation"}],"soft_credit":{"softCredit_identity_id":"42144f27-801c-4c80-955a-ddfc0f065f87","softCredit_first_name":"Test","softCredit_last_name":"Admin","softCredit_email":"testadmin@pixo.com.au","softCredit_street":null,"softCredit_city":null,"softCredit_state":null,"softCredit_postcode":null,"softCredit_country":null,"softCredit_phone":"","softCredit_shipping_street":null,"softCredit_shipping_city":null,"softCredit_shipping_state":null,"softCredit_shipping_postcode":null,"softCredit_shipping_country":null,"sponsor_page_name":null,"sponsor_page_id":null,"salesforce_sponsor_page_id":null,"sponsor_page_created_date":null,"sponsor_page_end_date":null,"sponsor_donation_amount":null,"sponsor_page_url":null,"is_team":false,"current_amount":"30.0000","target_amount":null,"in_memory_page_name":"MemoryFirst MemoryLast","in_memory_page_id":8,"salesforce_in_memory_page_id":"795dcb90-5a6b-488a-9cbf-1a157d9848f7","in_memory_page_created_date":"12/01/2022 1:44:50 PM","event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testEventDonationOrder()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":101409,"identity_id":"c9aa3cc4-d3e2-496e-be83-8da833766de2","created_date":"05/08/2022 6:37:02 AM","completed_date":"05/08/2022 4:37:04 PM","status":7,"amount":"20.00","gst":"0.00","discount_amount":"0.00","subtotal_amount":"20.00","billing_first_name":"Pixo","billing_last_name":"Support","billing_email":"support-admin@pixo.com.au","is_company":false,"billing_company":"","billing_street":"56 Montrose Road","billing_city":"Malvern","billing_state":"VIC","billing_postcode":"3144","billing_country":"Australia","billing_phone":"9876 5432","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/72","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/101409","order_prefix":"q","shipping_street":"51 Allison Grove","shipping_city":"Malvern","shipping_state":"VIC","shipping_postcode":"3144","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"QA Site","donor_id_api_name":"donor_id","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[10],"str_distinct_order_item_types":"10","order_item_count":1,"payment":{"ref_id":"ch_3LTK9bKdHt4xSAm61YS6TQbB","amount":"20.00","type":"Credit Card"},"items":[{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"20.00","type":10,"type_id":"72","quantity":1,"details":"Event Donation for Shipping!","event_campaign_id":72,"salesforce_event_campaign_id":"264d42a5-6454-4324-afdc-7d129782a678","event_name":"Shipping!","event_start_date":"21/02/2022 12:00:00 AM","event_end_date":"15/02/2027 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/72","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/72","type_name":"Event Donation"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMultipleEventRegistrationsWithStoreAndSponsorDonation()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        //req.requestBody = blob.valueof('{"id":100375,"identity_id":"1523eb5d-8abe-41ea-a494-1c0ac88daedc","created_date":"01/09/2022 5:06:03 AM","completed_date":"01/09/2022 3:06:05 PM","status":3,"amount":"230.00","gst":"18.64","discount_amount":"0.00","subtotal_amount":"225.00","billing_first_name":"TestBF01","billing_last_name":"LastBF01","billing_email":"testbf01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"378 Little Bourke St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100375","order_prefix":"a","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,3,12],"str_distinct_order_item_types":"2,6,3,12","order_item_count":10,"no_of_event_reg_tickets":3,"payment":{"ref_id":"ch_3Ld5bMDI7EF9k4gO0GxiXszS","amount":"230.00","type":"Credit Card"},"items":[{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"55","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":6,"type_id":"15","quantity":1,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"17","quantity":1,"details":"T-Shirt (One size)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"56","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"15","quantity":2,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"57","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"15","quantity":3,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"25.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"25.00","type":3,"type_id":"51","quantity":1,"details":"Sponsor Donation for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","type_name":"Sponsor Donation"},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.45","amount_subtotal":"5.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping"}],"soft_credit":{"softCredit_identity_id":"1523eb5d-8abe-41ea-a494-1c0ac88daedc","softCredit_first_name":"TestBF01","softCredit_last_name":"LastBF01","softCredit_email":"testbf01@pixo.com.au","softCredit_street":"378 Little Bourke St","softCredit_city":"Melbourne","softCredit_state":"VIC","softCredit_postcode":"3000","softCredit_country":"Australia","softCredit_phone":"555444333","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"TestBF01 LastBF01","sponsor_page_id":51,"salesforce_sponsor_page_id":"5c3acdaf-cff0-4223-bb00-379d86016fec","sponsor_page_created_date":"01/09/2022 3:06:03 PM","sponsor_page_end_date":"01/09/2023 3:06:03 PM","sponsor_donation_amount":"25.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","is_team":false,"current_amount":"25.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');
        req.requestBody = blob.valueof('{"id":100375,"identity_id":"1523eb5d-8abe-41ea-a494-1c0ac88daedc","created_date":"01/09/2022 5:06:03 AM","completed_date":"01/09/2022 3:06:05 PM","status":3,"amount":"230.00","gst":"18.64","discount_amount":"0.00","subtotal_amount":"225.00","billing_first_name":"TestBF01","billing_last_name":"LastBF01","billing_email":"testbf01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"378 Little Bourke St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100375","order_prefix":"a","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,3,12],"str_distinct_order_item_types":"2,6,3,12","order_item_count":10,"no_of_event_reg_tickets":3,"payment":{"ref_id":"ch_3Ld5bMDI7EF9k4gO0GxiXszS","amount":"230.00","type":"Credit Card"},"items":[{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"55","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"40.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"40.00","type":6,"type_id":"15","quantity":4,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"17","quantity":1,"details":"T-Shirt (One size)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"56","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"15","quantity":2,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"57","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100375","type_name":"Event Registration"},{"amount":"25.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"25.00","type":3,"type_id":"51","quantity":1,"details":"Sponsor Donation for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","type_name":"Sponsor Donation"},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.45","amount_subtotal":"5.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping"}],"soft_credit":{"softCredit_identity_id":"1523eb5d-8abe-41ea-a494-1c0ac88daedc","softCredit_first_name":"TestBF01","softCredit_last_name":"LastBF01","softCredit_email":"testbf01@pixo.com.au","softCredit_street":"378 Little Bourke St","softCredit_city":"Melbourne","softCredit_state":"VIC","softCredit_postcode":"3000","softCredit_country":"Australia","softCredit_phone":"555444333","softCredit_shipping_street":"","softCredit_shipping_city":"","softCredit_shipping_state":"","softCredit_shipping_postcode":"","softCredit_shipping_country":"Australia","sponsor_page_name":"TestBF01 LastBF01","sponsor_page_id":51,"salesforce_sponsor_page_id":"5c3acdaf-cff0-4223-bb00-379d86016fec","sponsor_page_created_date":"01/09/2022 3:06:03 PM","sponsor_page_end_date":"01/09/2023 3:06:03 PM","sponsor_donation_amount":"25.00","sponsor_page_url":"https://www.pixo.com.au/pixo-admin/fundraisers/51","is_team":false,"current_amount":"25.0000","target_amount":"500.0000","in_memory_page_name":null,"in_memory_page_id":null,"salesforce_in_memory_page_id":null,"in_memory_page_created_date":null,"event_campaign_id":null,"salesforce_event_campaign_id":null,"event_name":null,"campaign_name":null,"event_campaign_start_date":null,"event_campaign_end_date":null,"event_campaign_url":null},"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');
        
        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMultipleEventRegistrationsWithStoreAndEventDonation()    // 101
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100374,"identity_id":"9706774a-96a8-49d7-867b-1c0419608ebc","created_date":"01/09/2022 4:49:19 AM","completed_date":"01/09/2022 2:49:21 PM","status":3,"amount":"235.00","gst":"20.45","discount_amount":"0.00","subtotal_amount":"230.00","billing_first_name":"TestBC01","billing_last_name":"LastBC01","billing_email":"testbc01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"325 Little Collins St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/events/17","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100374","order_prefix":"a","shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[2,6,10,12],"str_distinct_order_item_types":"2,6,10,12","order_item_count":11,"no_of_event_reg_tickets":3,"payment":{"ref_id":"ch_3Ld5LADI7EF9k4gO1umSVkJR","amount":"235.00","type":"Credit Card"},"items":[{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"52","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100374","type_name":"Event Registration"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":6,"type_id":"15","quantity":1,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"17","quantity":1,"details":"T-Shirt (One size)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"53","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100374","type_name":"Event Registration"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"15","quantity":2,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":2,"type_id":"54","quantity":1,"details":"Single registration for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17/registrations?order_id=100374","type_name":"Event Registration"},{"amount":"30.00","total_discount_amount":"0.00","total_tax_amount":"2.73","amount_subtotal":"30.00","type":6,"type_id":"15","quantity":3,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"10.00","type":10,"type_id":"17","quantity":1,"details":"Event Donation for SF Test Event 01","event_campaign_id":17,"salesforce_event_campaign_id":"1a9e2027-8e66-42c9-9753-d43923b4c4f5","event_name":"SF Test Event 01","event_start_date":"31/08/2022 12:00:00 AM","event_end_date":"10/09/2022 12:00:00 AM","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"https://www.pixo.com.au/pixo-admin/events/17","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/events/17","type_name":"Event Donation"},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.45","amount_subtotal":"5.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }
    
    static testMethod void testStoreOnlyOrder()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100383,"identity_id":"","created_date":"02/09/2022 5:43:06 AM","completed_date":"02/09/2022 3:43:07 PM","status":3,"amount":"55.00","gst":"5.00","discount_amount":"0.00","subtotal_amount":"50.00","billing_first_name":"TestCK01","billing_last_name":"LastCK01","billing_email":"testck01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/100383","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100383","order_prefix":"a","shipping_street":"534 Flinders St","shipping_city":"Melbourne","shipping_state":"VIC","shipping_postcode":"3000","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[6],"str_distinct_order_item_types":"6","order_item_count":2,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LdSekDI7EF9k4gO1h8Nx17O","amount":"55.00","type":"Credit Card"},"items":[{"amount":"10.00","total_discount_amount":"0.00","total_tax_amount":"0.91","amount_subtotal":"10.00","type":6,"type_id":"15","quantity":1,"details":"Cap","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"},{"amount":"40.00","total_discount_amount":"0.00","total_tax_amount":"3.64","amount_subtotal":"40.00","type":6,"type_id":"16","quantity":2,"details":"Water Bottle","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testFreeFormAdminOrder()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100388,"identity_id":"","created_date":"31/08/2022 2:00:00 PM","completed_date":"01/09/2022 12:00:00 AM","status":7,"amount":"20.00","gst":"1.82","discount_amount":"0.00","subtotal_amount":"20.00","billing_first_name":"TestDA01","billing_last_name":"LastDA01","billing_email":"testda01@pixo.com.au","is_company":false,"billing_company":"","billing_street":"","billing_city":"","billing_state":"","billing_postcode":"","billing_country":"Australia","billing_phone":"202303404","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/orders/100388","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":true,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100388","order_prefix":"a","shipping_street":"","shipping_city":"","shipping_state":"","shipping_postcode":"","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":"","custom_field_name":"","custom_field_value":"","distinct_order_item_types":[8],"str_distinct_order_item_types":"8","order_item_count":1,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LeTg3DI7EF9k4gO1uAJCiJ2","amount":"20.00","type":"Credit Card"},"items":[{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":8,"type_id":"","quantity":1,"details":"Test Admin other order","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Free Form"}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testMembershipRequiringAdminApproval()   // 101
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":100407,"identity_id":"a3d60da3-4ed9-4e87-a1ca-7027dd100842","created_date":"06/10/2022 2:34:22 AM","completed_date":"06/10/2022 1:34:29 PM","status":3,"amount":"85.00","gst":"7.27","discount_amount":"0.00","subtotal_amount":"80.00","billing_first_name":"FirstA","billing_last_name":"LastA","billing_email":"test01a@pixo.com.au","is_company":false,"billing_company":"","billing_street":"535 Bourke St","billing_city":"Melbourne","billing_state":"VIC","billing_postcode":"3000","billing_country":"Australia","billing_phone":"","billing_fax":"","related_url":"https://www.pixo.com.au/pixo-admin/members/159","email_opt_in":false,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Order","order_url":"https://www.pixo.com.au/pixo-admin/orders/100407","order_prefix":"a","shipping_street":"535 Bourke St","shipping_city":"Melbourne","shipping_state":"VIC","shipping_postcode":"3000","shipping_country":"Australia","website_info":"https://www.pixo.com.au","website_name":"Site Name","donor_id_api_name":"","api_salesforce_donor_id":null,"custom_field_name":"","custom_field_value":"","distinct_order_item_types":[7,6,1,12],"str_distinct_order_item_types":"7,6,1,12","order_item_count":5,"no_of_event_reg_tickets":0,"payment":{"ref_id":"ch_3LpjunDI7EF9k4gO1eVRPcHa","amount":"85.00","type":"Credit Card"},"items":[{"amount":"35.00","total_discount_amount":"0.00","total_tax_amount":"3.18","amount_subtotal":"35.00","type":7,"type_id":"159","quantity":1,"details":"Member registration for Oct monthly - admin","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"Test Membership Oct 01","salesforce_membership_id":"734e95a6-65a6-4664-b5de-5c7a4a75d726","membership_level":"Oct monthly - admin","membership_frequency":"Monthly","membership_valid_from":"06/10/2022 1:34:35 PM","membership_valid_to":"06/11/2022 1:34:35 PM","membership_origin":"New","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/15/types","tribute_name":"","item_related_url":"https://www.pixo.com.au/pixo-admin/members/159","type_name":"Membership","membership_approval_date":null},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"15","quantity":2,"details":"Cap (Adult Cap)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store","membership_approval_date":null},{"amount":"20.00","total_discount_amount":"0.00","total_tax_amount":"1.82","amount_subtotal":"20.00","type":6,"type_id":"16","quantity":1,"details":"Water Bottle (Water bottle 500ml)","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Store","membership_approval_date":null},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.00","amount_subtotal":"5.00","type":1,"type_id":"","quantity":1,"details":"Donation: $5.00","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Donation","membership_approval_date":null},{"amount":"5.00","total_discount_amount":"0.00","total_tax_amount":"0.45","amount_subtotal":"5.00","type":12,"type_id":"1","quantity":1,"details":"Shipping","event_campaign_id":null,"salesforce_event_campaign_id":"","event_name":"","event_start_date":"","event_end_date":"","campaign_name":"","campaign_start_date":"","campaign_end_date":"","campaign_url":"","membership_program_name":"","salesforce_membership_id":"","membership_level":"","membership_frequency":"","membership_valid_from":"","membership_valid_to":"","membership_origin":"","membership_program_url":"","tribute_name":"","item_related_url":"","type_name":"Shipping","membership_approval_date":null}],"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testAdminApprovingMembership()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"ApproveMembership","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"no_of_event_reg_tickets":0,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":{"member_identity_id":"bbdc7aa5-bedc-4f18-94ab-908dae4dd70c","member_first_name":"FirstJ02A","member_last_name":"LastJ02A","member_email":"testj02a@pixo.com.au","member_phone":"","member_mailing_street":"232 High St","member_mailing_city":"Kew","member_mailing_state":"VIC","member_mailing_postal_code":"3101","member_mailing_country":"Australia","member_shipping_street":"232 High St","member_shipping_city":"Kew","member_shipping_state":"VIC","member_shipping_postal_code":"3101","member_shipping_country":"Australia","membership_program_name":"Test Membership Oct 01","salesforce_membership_id":"734e95a6-65a6-4664-b5de-5c7a4a75d726","membership_program_url":"https://www.pixo.com.au/pixo-admin/memberships/15/types","membership_approval_date":"06/10/2022 2:59:46 PM","membership_valid_from":"06/10/2022 2:19:50 PM","membership_valid_to":"06/11/2022 2:19:50 PM","membership_order_id":"100413"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

    static testMethod void testNewsletterPanel()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/engonet/order/';  //Request URL
        req.httpMethod = 'POST';
        req.requestBody = blob.valueof('{"id":null,"identity_id":null,"created_date":null,"completed_date":null,"status":null,"amount":null,"gst":null,"discount_amount":null,"subtotal_amount":null,"billing_first_name":null,"billing_last_name":null,"billing_email":null,"is_company":false,"billing_company":null,"billing_street":null,"billing_city":null,"billing_state":null,"billing_postcode":null,"billing_country":null,"billing_phone":null,"billing_fax":null,"related_url":null,"email_opt_in":null,"refund_date":null,"recurring_order_id":null,"recurring_frequency_id":null,"recurring_initial_date":null,"recurring_is_initial_order":null,"recurring_number":null,"recurring_order_url":null,"total_no_of_recurring_donations":0,"total_no_of_active_recurring_donations":0,"is_admin_order":false,"call_made_from":"Newsletter","order_url":null,"order_prefix":null,"shipping_street":null,"shipping_city":null,"shipping_state":null,"shipping_postcode":null,"shipping_country":null,"website_info":"https://www.pixo.com.au","website_name":null,"donor_id_api_name":null,"api_salesforce_donor_id":null,"custom_field_name":null,"custom_field_value":null,"distinct_order_item_types":null,"str_distinct_order_item_types":null,"order_item_count":0,"no_of_event_reg_tickets":0,"payment":null,"items":null,"soft_credit":null,"user_account":null,"recurring_order":null,"member_user":null,"newsletter":{"first_name":"first name","last_name":"last naqme","email":"email@pixo.com.au"},"user_account_custom_fields":null}');

        RestContext.request = req;
        RestContext.response = res;

        EngonetRestAPI.post();
    }

}