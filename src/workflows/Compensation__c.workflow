<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Compensation_created</fullName>
        <description>Compensation created</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compensation_created</template>
    </alerts>
    <alerts>
        <fullName>Uruguay_Compensation_Created</fullName>
        <description>Uruguay Compensation Created</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseCreatedWebInquiries</template>
    </alerts>
    <rules>
        <fullName>Email Notification Compensation Created</fullName>
        <actions>
            <name>Compensation_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Compensation__c.Location__c</field>
            <operation>equals</operation>
            <value>Uruguay</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
