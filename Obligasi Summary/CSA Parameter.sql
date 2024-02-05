USE EngineStatement_BDI
GO 

--insert parameter template

DELETE FROM ReportParameter WHERE Fk_MsStatementTemplate_Id IN (select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] IN ( 'Tax Obligasi Summary'))
DELETE FROM STATEMENTGENERATOR WHERE StatementGeneratorName IN ('Tax Obligasi Summary')

DELETE FROM MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ( 'Tax Obligasi Summary')

--sesuaikan path ssrs nya
INSERT INTO [dbo].[MsStatementTemplate] ( 
[StatementTemplateName],
[ReportPath],
[ReportName],
[Activation],
[CreatedDate],
[CreatedBy],
[LastUpdatedDate],
[LastUpdatedBy],
[ApprovedDate],
[ApprovedBy],
[Description],
[EMateraiTemplateID],
[JarakAtasEMaterai],
[JarakKiriEMaterai]) VALUES (
'Tax Obligasi Summary', --[StatementTemplateName],
'TaxReports', --[ReportPath],
'TaxCustomerDeductedAdvice_Oligasi_Summary', --[ReportName],
'1', --[Activation],
GETDATE(), --[CreatedDate],
'system', --[CreatedBy],
GETDATE(), --[LastUpdatedDate],
'system', --[LastUpdatedBy],
GETDATE(), --[ApprovedDate],
'system', --[ApprovedBy],
'', --[Description],
(select MAX(Pk_MsStatementTemplate_Id)+1 from MsStatementTemplate), --[EMateraiTemplateID],
0, --[JarakAtasEMaterai],
0); --[JarakKiriEMaterai]
  


INSERT INTO [dbo].[ReportParameter] (
[Fk_MsStatementTemplate_Id],
[ReportParameterName],
[ReportParameterDataType],
[Activation],
[CreatedDate],
[CreatedBy],
[LastUpdatedDate],
[LastUpdatedBy],
[ApprovedDate],
[ApprovedBy]) VALUES (
(select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] = 'Tax Obligasi Summary'), --[Fk_MsStatementTemplate_Id],
'DataID', --[ReportParameterName],
'Text', --[ReportParameterDataType],
'1', --[Activation],
GETDATE(), --[CreatedDate],
'system', --[CreatedBy],
GETDATE(), --[LastUpdatedDate],
'system', --[LastUpdatedBy],
GETDATE(), --[ApprovedDate],
'system'); --[ApprovedBy]



INSERT INTO [dbo].[StatementGenerator] (
[FK_MsDataSourcePackage_ID],
[StatementGeneratorName],
[Fk_MsStatementTemplate_Id],
[IsSeperateStatement],
[FieldCustomerName],
[FieldCustomerNameAlias],
[FieldBranchCode],
[FieldCustomerNumber],
[FieldCIFNumber],
[FieldAccountNo],
[FieldProduct],
[FieldPostalCode],
[IsUseCombineStatement],
[CombineTableName],
[FieldCIFCombineTable],
[FieldAccountCombineTable],
[FieldCustomerNumberCombineTable],
[IsUseSamplingData],
[SamplingValue],
[FK_SamplingType_Id],
[IsEncryptFile],
[FK_EncryptionKeyType_ID],
[EncryptionKeyValue],
[IsProsesEmailDelivery],
[IsDisabledEncryptionforEmailDeliveryFile],
[IsJointAccount],
[IsEZipStatementOnEmailDelivery],
[IsProsesSMSNotification],
[IsProsesStatementDistribution],
[IsDisabledEncryptionForStatementDisbtribution],
[IsZipStatementOnDelivery],
[Activation],
[CreatedDate],
[CreatedBy],
[LastUpdatedDate],
[LastUpdatedBy],
[ApprovedDate],
[ApprovedBy],
[IsUseChecksumValidation],
[ChecksumTable],
[FieldNominalChecksum],
[FieldNominal],
[FieldCountChecksum],
[FieldDateValidation],
[Validation],
[FieldNameValidation],
[TableNameValidation],
[FieldEMaterai],
[FieldTotalNominalTransaction]) VALUES (
'', --[FK_MsDataSourcePackage_ID],
'Tax Obligasi Summary', --[StatementGeneratorName],
(select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ('Tax Obligasi Summary')), --[Fk_MsStatementTemplate_Id],
'0', --[IsSeperateStatement],
'[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[customer_name]', --[FieldCustomerName],
  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[customer_name]', --[FieldCustomerNameAlias],
  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[Fk_TaxRequestList]', --[FieldBranchCode],
  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[cif]', --[FieldCustomerNumber],
  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[cif]', --[FieldCIFNumber],
  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[account_no]', --[FieldAccountNo],
NULL, --[FieldProduct],
'[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[Fk_TaxRequestList]', --[FieldPostalCode],
'0', --[IsUseCombineStatement],
NULL, --[CombineTableName],
NULL, --[FieldCIFCombineTable],
NULL, --[FieldAccountCombineTable],
NULL, --[FieldCustomerNumberCombineTable],
'0', --[IsUseSamplingData],
NULL, --[SamplingValue],
NULL, --[FK_SamplingType_Id],
'0', --[IsEncryptFile],
NULL, --[FK_EncryptionKeyType_ID],
NULL, --[EncryptionKeyValue],
'0', --[IsProsesEmailDelivery],
NULL, --[IsDisabledEncryptionforEmailDeliveryFile],
'0', --[IsJointAccount],
NULL, --[IsEZipStatementOnEmailDelivery],
'0', --[IsProsesSMSNotification],
'1', --[IsProsesStatementDistribution],
'0', --[IsDisabledEncryptionForStatementDisbtribution],
'0', --[IsZipStatementOnDelivery],
'1', --[Activation],
GETDATE(), --[CreatedDate],
'system', --[CreatedBy],
GETDATE(), --[LastUpdatedDate],
'system', --[LastUpdatedBy],
GETDATE(), --[ApprovedDate],
'system', --[ApprovedBy],
'0', --[IsUseChecksumValidation],
'', --[ChecksumTable],
'', --[FieldNominalChecksum],
'', --[FieldNominal],
'', --[FieldCountChecksum],
NULL, --[FieldDateValidation],
'0', --[Validation],
'', --[FieldNameValidation],
'', --[TableNameValidation],
'0', --[FieldEMaterai],
'0'); --[FieldTotalNominalTransaction]
  
--INSERT INTO [dbo].[StatementGenerator] ([FK_MsDataSourcePackage_ID], [StatementGeneratorName], [Fk_MsStatementTemplate_Id], [IsSeperateStatement], [FieldCustomerName], [FieldCustomerNameAlias], [FieldBranchCode], [FieldCustomerNumber], [FieldCIFNumber], [FieldAccountNo], [FieldProduct], [FieldPostalCode], [IsUseCombineStatement], [CombineTableName], [FieldCIFCombineTable], [FieldAccountCombineTable], [FieldCustomerNumberCombineTable], [IsUseSamplingData], [SamplingValue], [FK_SamplingType_Id], [IsEncryptFile], [FK_EncryptionKeyType_ID], [EncryptionKeyValue], [IsProsesEmailDelivery], [IsDisabledEncryptionforEmailDeliveryFile], [IsJointAccount], [IsEZipStatementOnEmailDelivery], [IsProsesSMSNotification], [IsProsesStatementDistribution], [IsDisabledEncryptionForStatementDisbtribution], [IsZipStatementOnDelivery], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy], [IsUseChecksumValidation], [ChecksumTable], [FieldNominalChecksum], [FieldNominal], [FieldCountChecksum], [FieldDateValidation], [Validation], [FieldNameValidation], [TableNameValidation], [FieldEMaterai], [FieldTotalNominalTransaction]) VALUES ('', 'Tax Obligasi Summary', (select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ('Tax Obligasi Summary')), '0', '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[customer_name]', 
--  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[customer_name]', 
--  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[branch_code]',
--  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[cif]', 
--  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[cif]', 
--  '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[account_no]', NULL, '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[postal_code]', '0', NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', NULL, NULL, '0', NULL, '0', NULL, '0', '1', '0', '0', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system', '0', '', '', '', '', NULL, '0', '', '', '0', '0');


delete from StatementGeneratorPrimaryKey where FK_StatementGenerator_ID in (select PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Obligasi Summary') )
go

INSERT INTO [dbo].[StatementGeneratorPrimaryKey] (
[FK_StatementGenerator_ID],
[TableNameField],
[PrimaryKeyField]) VALUES (
(select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Obligasi Summary')), --[FK_StatementGenerator_ID],
'[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation]', --[TableNameField],
'[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[DataID]'); --[PrimaryKeyField]


DELETE  from [StatementGeneratorStatementParameterMapping] where ParameterNameField = 'Fk_TaxRequestList'

INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] (
 [FK_StatementGenerator_ID],
 [ParameterNameField],
 [FieldMapping]) VALUES (
 (SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Obligasi Summary'), --[FK_StatementGenerator_ID],
 'Fk_TaxRequestList', -- [ParameterNameField],
 '[TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation].[Fk_TaxRequestList]'); -- [FieldMapping]

INSERT INTO [dbo].[DatabaseFriendly] (
 [OriginalTable],
 [FriendlyTableName],
 [IsView],
 [Activation],
 [CreatedDate],
 [CreatedBy],
 [LastUpdatedDate],
 [LastUpdatedBy],
 [ApprovedDate],
 [ApprovedBy]
 ) VALUES (
 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation', --[OriginalTable],
 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation', --[FriendlyTableName],
 '0', --[IsView],
 '1', --[Activation],
getdate(), --[CreatedDate],
 'dsystem', --[CreatedBy],
 NULL, --[LastUpdatedDate],
 'dsystem', --[LastUpdatedBy],
getdate(), --[ApprovedDate],
 'dsystem'); --[ApprovedBy]

 

 INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'DataID', '1', 'DataID', 'DataID');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'branch_code', '1', 'branch_code', 'branch_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'cif', '1', 'cif', 'cif');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'postal_code', '1', 'postal_code', 'postal_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'customer_name', '1', 'customer_name', 'customer_name');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiSummary_CustomerInformation'), 'account_no', '1', 'account_no', 'account_no');


  