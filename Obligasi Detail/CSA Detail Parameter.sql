USE EngineStatement_BDI
GO 

--insert parameter template

delete from [StatementGeneratorStatementParameterMapping] where FK_StatementGenerator_ID in (select PK_StatementGenerator_ID from StatementGenerator where Fk_MsStatementTemplate_Id in (select Pk_MsStatementTemplate_Id from MsStatementTemplate where StatementTemplateName = 'Tax Obligasi Detail'))
DELETE FROM ReportParameter WHERE Fk_MsStatementTemplate_Id IN (select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] IN ( 'Tax Obligasi Detail'))
delete from StatementGeneratorPrimaryKey where FK_StatementGenerator_ID in (select PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Obligasi Detail') )
DELETE FROM STATEMENTGENERATOR WHERE StatementGeneratorName IN ('Tax Obligasi Detail')
DELETE FROM MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ( 'Tax Obligasi Detail')
DELETE FROM [DatabaseFriendlyField] WHERE FK_DatabaseFriendly_ID in (select PK_DatabaseFriendly_ID from DatabaseFriendly WHERE [OriginalTable] = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation')
  DELETE FROM [DatabaseFriendly] WHERE [OriginalTable] = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'

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
'Tax Obligasi Detail', --[StatementTemplateName],
'TaxReports', --[ReportPath],
'TaxCustomerDeductedAdvice_Oligasi_Detail', --[ReportName],
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
(select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] = 'Tax Obligasi Detail'), --[Fk_MsStatementTemplate_Id],
'cif', --[ReportParameterName],
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
'Tax Obligasi Detail', --[StatementGeneratorName],
(select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ('Tax Obligasi Detail')), --[Fk_MsStatementTemplate_Id],
'0', --[IsSeperateStatement],
'[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[customer_name]', --[FieldCustomerName],
  '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[customer_name]', --[FieldCustomerNameAlias],
  '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[Fk_TaxRequestList]', --[FieldBranchCode],
  '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[cif]', --[FieldCustomerNumber],
  '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[cif]', --[FieldCIFNumber],
  '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[account_no]', --[FieldAccountNo],
NULL, --[FieldProduct],
'[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[Fk_TaxRequestList]', --[FieldPostalCode],
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
go

INSERT INTO [dbo].[StatementGeneratorPrimaryKey] (
[FK_StatementGenerator_ID],
[TableNameField],
[PrimaryKeyField]) VALUES (
(select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Obligasi Detail')), --[FK_StatementGenerator_ID],
'[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation]', --[TableNameField],
'[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[DataID]'); --[PrimaryKeyField]


INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] (
 [FK_StatementGenerator_ID],
 [ParameterNameField],
 [FieldMapping]) VALUES (
 (SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Obligasi Detail'), --[FK_StatementGenerator_ID],
 'cif', -- [ParameterNameField],
 '[TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation].[cif]'); -- [FieldMapping]
 GO



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
 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation', --[OriginalTable],
 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation', --[FriendlyTableName],
 '0', --[IsView],
 '1', --[Activation],
getdate(), --[CreatedDate],
 'system', --[CreatedBy],
 NULL, --[LastUpdatedDate],
 'system', --[LastUpdatedBy],
getdate(), --[ApprovedDate],
 'system'); --[ApprovedBy]
 GO
 
 
  ALTER TABLE [DatabaseFriendlyField]
  DROP CONSTRAINT if exists FK_DatabaseFriendlyField_DatabaseFriendly;
 GO

 INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'DataID', '1', 'DataID', 'DataID');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'branch_code', '1', 'branch_code', 'branch_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'cif', '1', 'cif', 'cif');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'postal_code', '1', 'postal_code', 'postal_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'customer_name', '1', 'customer_name', 'customer_name');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation'), 'account_no', '1', 'account_no', 'account_no');
GO

  
use EngineStatement_BDI
  select * From ReportParameter
  select *From [StatementGeneratorStatementParameterMapping]

  delete from [StatementGeneratorStatementParameterMapping] where ParameterNameField ='Fk_TaxRequestList'


  select * From TaxCustomerDeductedAdvice_ObligasiDetail_CustomerInformation

  select * from FileData