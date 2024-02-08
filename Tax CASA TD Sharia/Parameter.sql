use Enginestatement_BDI
go

--insert parameter template

DELETE FROM ReportParameter WHERE Fk_MsStatementTemplate_Id IN (select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] IN ( 'Tax Reporting Syariah','Tax Reporting Casa TD'))

delete from StatementGeneratorPrimaryKey where FK_StatementGenerator_ID in (select PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Reporting Casa TD','Tax Reporting Syariah') )

DELETE [dbo].[StatementGeneratorStatementParameterMapping] WHERE FK_StatementGenerator_ID IN (SELECT PK_StatementGenerator_ID fROM StatementGenerator WHERE StatementGeneratorName IN ('Tax Reporting Casa TD','Tax Reporting Syariah') )

DELETE FROM STATEMENTGENERATOR WHERE StatementGeneratorName IN ('Tax Reporting Casa TD','Tax Reporting Syariah')

DELETE FROM MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ( 'Tax Reporting Casa TD','Tax Reporting Syariah')

--sesuaikan path ssrs nya
INSERT INTO [dbo].[MsStatementTemplate] ( [StatementTemplateName], [ReportPath], [ReportName], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy], [Description], [EMateraiTemplateID], [JarakAtasEMaterai], [JarakKiriEMaterai]) VALUES ('Tax Reporting Casa TD', 'Danamon/TaxReports', 'TaxCustomerDeductedAdvice_OBS_CASATD', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system', '', (select MAX(Pk_MsStatementTemplate_Id)+1 from MsStatementTemplate), 0, 0);
  
--sesuaikan path ssrs nya
INSERT INTO [dbo].[MsStatementTemplate] ( [StatementTemplateName], [ReportPath], [ReportName], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy], [Description], [EMateraiTemplateID], [JarakAtasEMaterai], [JarakKiriEMaterai]) VALUES ('Tax Reporting Syariah', 'Danamon/TaxReports', 'TaxCustomerDeductedAdvice_OBS_Syariah', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system', '', (select MAX(Pk_MsStatementTemplate_Id)+1 from MsStatementTemplate), 0, 0);


--INSERT INTO [dbo].[ReportParameter] ([Fk_MsStatementTemplate_Id], [ReportParameterName], [ReportParameterDataType], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ((select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] = 'Tax Reporting Syariah'), 'CIF', 'Text', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system');
--INSERT INTO [dbo].[ReportParameter] ([Fk_MsStatementTemplate_Id], [ReportParameterName], [ReportParameterDataType], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ((select Pk_MsStatementTemplate_Id from MsStatementTemplate where [StatementTemplateName] = 'Tax Reporting Casa TD'), 'CIF', 'Text', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system');


DELETE FROM [SystemParameter] WHERE ParameterName IN ('EngineTaxStatus','Fk_MsStatementTemplate_Id_Tax_CasaTD','Fk_MsStatementTemplate_Id_Tax_Syariah','UrlService_TaxReporting')
INSERT INTO [dbo].[SystemParameter] ([ParameterName], [ParameterValue], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'EngineTaxStatus', 'Idle', '1', GETDATE(), 'Script', GETDATE(), 'Script', GETDATE(), 'Script');

INSERT INTO [dbo].[SystemParameter] ( [ParameterName], [ParameterValue], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'Fk_MsStatementTemplate_Id_Tax_CasaTD', 
(select Pk_MsStatementTemplate_Id from MsStatementTemplate where StatementTemplateName = 'Tax Reporting Casa TD'), 
'1', GETDATE(), 'Script', GETDATE(), 'Script', GETDATE(), 'Script');

INSERT INTO [dbo].[SystemParameter] ( [ParameterName], [ParameterValue], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'Fk_MsStatementTemplate_Id_Tax_Syariah', 
(select Pk_MsStatementTemplate_Id from MsStatementTemplate where StatementTemplateName = 'Tax Reporting Syariah'), 
'1', GETDATE(), 'Script', GETDATE(), 'Script', GETDATE(), 'Script');

  --sesuaikan path ip nya'
INSERT INTO [dbo].[SystemParameter] ( [ParameterName], [ParameterValue], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'UrlService_TaxReporting', 'http://127.0.0.1:11002/', '1', GETDATE(), 'Script', GETDATE(), 'Script', GETDATE(), 'Script');
go

  DELETE FROM [MsDataSourcePackage] WHERE [DataSourcePackageCode] = 'Tax Package Reporting CASA TD'
  DELETE FROM [MsDataSourcePackage] WHERE [DataSourcePackageCode] = 'Tax Package Reporting Syariah'
  INSERT INTO [dbo].[MsDataSourcePackage] ( [DataSourcePackageCode], [PackageStorageType], [PackageName], [PackageFullPath], [PackageServerName], [ServerUserName], [ServerPassword], [DataSourcePackageDescription], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'Tax Package Reporting CASA TD', 1, 'TaxReportingCasaTDPackage',
  'D:\Sahassa\Project\Danamon\Phase 3\SSIS\Tax SSIS - CasaTD\Integration Services Project1\',   --sesuaikan
  '', '', '',
  'Tax Reporting CasaTD Package',
  GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system');
  
  INSERT INTO [dbo].[MsDataSourcePackage] ( [DataSourcePackageCode], [PackageStorageType], [PackageName], [PackageFullPath], [PackageServerName], [ServerUserName], [ServerPassword], [DataSourcePackageDescription], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy]) VALUES ( 'Tax Package Reporting Syariah', 1, 'TaxReportingSyariahPackage',
  'D:\Sahassa\Project\Danamon\Phase 3\SSIS\Tax SSIS - Syariah\Integration Services Project1\',   --sesuaikan
  '', '', '',
  'Tax Reporting Syariah Package',
  GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system');
go

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
(select top 1 PK_MsDataSourcePackage_ID from MsDataSourcePackage where DataSourcePackageCode = 'Tax Package Reporting Casa TD'), -- [FK_MsDataSourcePackage_ID],
'Tax Reporting Casa TD', -- [StatementGeneratorName],
(select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ('Tax Reporting Casa TD')), -- [Fk_MsStatementTemplate_Id],
'0', -- [IsSeperateStatement],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[customer_name]', -- [FieldCustomerName],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[customer_name]', -- [FieldCustomerNameAlias],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]', -- [FieldBranchCode],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[cif]', -- [FieldCustomerNumber],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[cif]', -- [FieldCIFNumber],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[account_no]', -- [FieldAccountNo],
NULL, -- [FieldProduct],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]', -- [FieldPostalCode],
'0', -- [IsUseCombineStatement],
NULL, -- [CombineTableName],
NULL, -- [FieldCIFCombineTable],
NULL, -- [FieldAccountCombineTable],
NULL, -- [FieldCustomerNumberCombineTable],
'0', -- [IsUseSamplingData],
NULL, -- [SamplingValue],
NULL, -- [FK_SamplingType_Id],
'0', -- [IsEncryptFile],
NULL, -- [FK_EncryptionKeyType_ID],
NULL, -- [EncryptionKeyValue],
'1', -- [IsProsesEmailDelivery],
NULL, -- [IsDisabledEncryptionforEmailDeliveryFile],
'0', -- [IsJointAccount],
NULL, -- [IsEZipStatementOnEmailDelivery],
'0', -- [IsProsesSMSNotification],
'1', -- [IsProsesStatementDistribution],
'0', -- [IsDisabledEncryptionForStatementDisbtribution],
'0', -- [IsZipStatementOnDelivery],
'1', -- [Activation],
GETDATE(), -- [CreatedDate],
'system', -- [CreatedBy],
GETDATE(), -- [LastUpdatedDate],
'system', -- [LastUpdatedBy],
GETDATE(), -- [ApprovedDate],
'system', -- [ApprovedBy],
'0', -- [IsUseChecksumValidation],
'', -- [ChecksumTable],
'', -- [FieldNominalChecksum],
'', -- [FieldNominal],
'', -- [FieldCountChecksum],
NULL, -- [FieldDateValidation],
'0', -- [Validation],
'', -- [FieldNameValidation],
'', -- [TableNameValidation],
'0', -- [FieldEMaterai],
'0'); -- [FieldTotalNominalTransaction]


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
(select top 1 PK_MsDataSourcePackage_ID from MsDataSourcePackage where DataSourcePackageCode = 'Tax Package Reporting Syariah'), --[FK_MsDataSourcePackage_ID],
'Tax Reporting Syariah', --[StatementGeneratorName],
(select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ( 'Tax Reporting Syariah')), --[Fk_MsStatementTemplate_Id],
'0', --[IsSeperateStatement],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[customer_name]', --[FieldCustomerName],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[customer_name]', --[FieldCustomerNameAlias],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]', --[FieldBranchCode],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[cif]', --[FieldCustomerNumber],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[cif]', --[FieldCIFNumber],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[account_no]', --[FieldAccountNo],
NULL, --[FieldProduct],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]', --[FieldPostalCode],
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
'1', --[IsProsesEmailDelivery],
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

INSERT INTO [dbo].[StatementGeneratorPrimaryKey] (
[FK_StatementGenerator_ID],
[TableNameField],
[PrimaryKeyField]) VALUES (
(select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Reporting Casa TD')), --[FK_StatementGenerator_ID],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation]', --[TableNameField],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[DataID]'); --[PrimaryKeyField]


INSERT INTO [dbo].[StatementGeneratorPrimaryKey] ([FK_StatementGenerator_ID],
[TableNameField],
[PrimaryKeyField]) VALUES (
(select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Reporting Syariah')), --[FK_StatementGenerator_ID],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation]', --[TableNameField],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[DataID]'); --[PrimaryKeyField]


INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] (
[FK_StatementGenerator_ID],
[ParameterNameField],
[FieldMapping]
) VALUES (
(SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Reporting Casa TD'), --[FK_StatementGenerator_ID],
'fk_taxrequestlist', --[ParameterNameField],
'[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]'); --[FieldMapping]

INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] (
[FK_StatementGenerator_ID],
[ParameterNameField],
[FieldMapping]
) VALUES (
(SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Reporting Syariah'), --[FK_StatementGenerator_ID],
'fk_taxrequestlist', --[ParameterNameField],
'[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]'); --[FieldMapping]



DELETE FROM StatementGeneratorEmailTemplate WHERE FK_StatementGenerator_ID NOT IN (select PK_StatementGenerator_ID from StatementGenerator) or FK_StatementGenerator_ID in (select PK_StatementGenerator_ID from StatementGenerator where StatementGeneratorName in ('Tax Reporting CASA TD','Tax Reporting Syariah'))

INSERT INTO [dbo].[StatementGeneratorEmailTemplate] (
[FK_StatementGenerator_ID],
[IsUsedTableEmailAddressReference],
[FK_EmailFrom_ID],
[EmailTo],
[FK_EmailReplyTo_ID],
[EmailCC],
[EmailBCC],
[EmailSubject],
[EmailBody],
[IsEnabledPasswordParameter],
[IsUseRandomDigit],
[FieldLength],
[NumberDigit],
[IsEnableEmailConfirmation],
[DaysSendEmailConfirmation],
[IsAutomaticResendEmailIfConfirmationReply],
[FK_EmailConfirmationFrom_ID],
[EmailConfirmationTo],
[FK_EmailConfirmationReplyTo_ID],
[EmailConfirmationCC],
[EmailConfirmationBCC],
[EmailConfirmationSubject],
[EmailConfirmationBody],
[NumberRetryIfFailed],
[TimeMinutesWaitBeforeRety],
[IsUsedOrderBy],
[ColumnOrderBy],
[OrderByWith],
[IsHavingAttachment],
[AttachmentFileName],
[NumberSplitAttachment]) VALUES (
(select PK_StatementGenerator_ID from StatementGenerator where StatementGeneratorName = 'Tax Reporting Syariah'), --[FK_StatementGenerator_ID],
'0', --[IsUsedTableEmailAddressReference],
(select top 1 PK_MsEmailIdendity_Id from MsEmailIdentity where Name = 'BUZZNET'), --[FK_EmailFrom_ID],
'', --[EmailTo],
(select top 1 PK_MsEmailIdendity_Id from MsEmailIdentity where Name = 'BUZZNET'), --[FK_EmailReplyTo_ID],
'', --[EmailCC],
'', --[EmailBCC],
'[EMAIL SUBJECT]', --[EmailSubject],
'[EMAIL BODY]', --[EmailBody],
'0', --[IsEnabledPasswordParameter],
NULL, --[IsUseRandomDigit],
NULL, --[FieldLength],
NULL, --[NumberDigit],
'0', --[IsEnableEmailConfirmation],
NULL, --[DaysSendEmailConfirmation],
NULL, --[IsAutomaticResendEmailIfConfirmationReply],
NULL, --[FK_EmailConfirmationFrom_ID],
NULL, --[EmailConfirmationTo],
NULL, --[FK_EmailConfirmationReplyTo_ID],
NULL, --[EmailConfirmationCC],
NULL, --[EmailConfirmationBCC],
NULL, --[EmailConfirmationSubject],
NULL, --[EmailConfirmationBody],
1, --[NumberRetryIfFailed],
1, --[TimeMinutesWaitBeforeRety],
'0', --[IsUsedOrderBy],
'<<[[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[DataID]>>', --[ColumnOrderBy],
'ASC', --[OrderByWith],
'0', --[IsHavingAttachment],
'', --[AttachmentFileName],
0); --[NumberSplitAttachment]

INSERT INTO [dbo].[StatementGeneratorEmailTemplate] (
[FK_StatementGenerator_ID],
[IsUsedTableEmailAddressReference],
[FK_EmailFrom_ID],
[EmailTo],
[FK_EmailReplyTo_ID],
[EmailCC],
[EmailBCC],
[EmailSubject],
[EmailBody],
[IsEnabledPasswordParameter],
[IsUseRandomDigit],
[FieldLength],
[NumberDigit],
[IsEnableEmailConfirmation],
[DaysSendEmailConfirmation],
[IsAutomaticResendEmailIfConfirmationReply],
[FK_EmailConfirmationFrom_ID],
[EmailConfirmationTo],
[FK_EmailConfirmationReplyTo_ID],
[EmailConfirmationCC],
[EmailConfirmationBCC],
[EmailConfirmationSubject],
[EmailConfirmationBody],
[NumberRetryIfFailed],
[TimeMinutesWaitBeforeRety],
[IsUsedOrderBy],
[ColumnOrderBy],
[OrderByWith],
[IsHavingAttachment],
[AttachmentFileName],
[NumberSplitAttachment]) VALUES (
(select PK_StatementGenerator_ID from StatementGenerator where StatementGeneratorName = 'Tax Reporting Casa TD'), --[FK_StatementGenerator_ID],
'0', --[IsUsedTableEmailAddressReference],
(select top 1 PK_MsEmailIdendity_Id from MsEmailIdentity where Name = 'BUZZNET'), --[FK_EmailFrom_ID],
'', --[EmailTo],
(select top 1 PK_MsEmailIdendity_Id from MsEmailIdentity where Name = 'BUZZNET'), --[FK_EmailReplyTo_ID],
'', --[EmailCC],
'', --[EmailBCC],
'[EMAIL SUBJECT]', --[EmailSubject],
'[EMAIL BODY]', --[EmailBody],
'0', --[IsEnabledPasswordParameter],
NULL, --[IsUseRandomDigit],
NULL, --[FieldLength],
NULL, --[NumberDigit],
'0', --[IsEnableEmailConfirmation],
NULL, --[DaysSendEmailConfirmation],
NULL, --[IsAutomaticResendEmailIfConfirmationReply],
NULL, --[FK_EmailConfirmationFrom_ID],
NULL, --[EmailConfirmationTo],
NULL, --[FK_EmailConfirmationReplyTo_ID],
NULL, --[EmailConfirmationCC],
NULL, --[EmailConfirmationBCC],
NULL, --[EmailConfirmationSubject],
NULL, --[EmailConfirmationBody],
1, --[NumberRetryIfFailed],
1, --[TimeMinutesWaitBeforeRety],
'0', --[IsUsedOrderBy],
'<<[[TaxCustomerDeductedAdvice_OBS_CasaTD_CustomerInformation].[DataID]>>', --[ColumnOrderBy],
'ASC', --[OrderByWith],
'0', --[IsHavingAttachment],
'', --[AttachmentFileName],
0); --[NumberSplitAttachment]

 ALTER TABLE [DatabaseFriendlyField]
 DROP CONSTRAINT if exists FK_DatabaseFriendlyField_DatabaseFriendly;
 GO

DELETE From DatabaseFriendlyField where FK_DatabaseFriendly_ID in (select PK_DatabaseFriendly_ID From DatabaseFriendly where OriginalTable in ('CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation','CustomerTaxDeductedAdvice_OBS_Syariah_CustomerInformation'))

DELETE From DatabaseFriendly where OriginalTable in ('CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation','CustomerTaxDeductedAdvice_OBS_Syariah_CustomerInformation')

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
[ApprovedBy]) VALUES (
'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation', --[OriginalTable],
'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation', --[FriendlyTableName],
'0', --[IsView],
'1', --[Activation],
getdate(), --[CreatedDate],
'system', --[CreatedBy],
NULL, --[LastUpdatedDate],
'system', --[LastUpdatedBy],
getdate(), --[ApprovedDate],
'system'); --[ApprovedBy]


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
[ApprovedBy]) VALUES (
'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation', --[OriginalTable],
'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation', --[FriendlyTableName],
'0', --[IsView],
'1', --[Activation],
getdate(), --[CreatedDate],
'system', --[CreatedBy],
NULL, --[LastUpdatedDate],
'system', --[LastUpdatedBy],
getdate(), --[ApprovedDate],
'system'); --[ApprovedBy]



INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'DataID', '1', 'DataID', 'DataID');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'branch_code', '1', 'branch_code', 'branch_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'cif', '1', 'cif', 'cif');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'postal_code', '1', 'postal_code', 'postal_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'customer_name', '1', 'customer_name', 'customer_name');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_CASATD_CustomerInformation'), 'account_no', '1', 'account_no', 'account_no');


INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'DataID', '1', 'DataID', 'DataID');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'branch_code', '1', 'branch_code', 'branch_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'cif', '1', 'cif', 'cif');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'postal_code', '1', 'postal_code', 'postal_code');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'customer_name', '1', 'customer_name', 'customer_name');
INSERT INTO [dbo].[DatabaseFriendlyField] ( [FK_DatabaseFriendly_ID], [OriginalFieldName], [IsDisplayField], [ExpressionData], [FriendlyFieldName]) VALUES ((select top 1 PK_DatabaseFriendly_ID from DatabaseFriendly where OriginalTable = 'CustomerTaxDeductedAdvice_OBS_SYARIAH_CustomerInformation'), 'account_no', '1', 'account_no', 'account_no');
