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

INSERT INTO [dbo].[StatementGenerator] ([FK_MsDataSourcePackage_ID], [StatementGeneratorName], [Fk_MsStatementTemplate_Id], [IsSeperateStatement], [FieldCustomerName], [FieldCustomerNameAlias], [FieldBranchCode], [FieldCustomerNumber], [FieldCIFNumber], [FieldAccountNo], [FieldProduct], [FieldPostalCode], [IsUseCombineStatement], [CombineTableName], [FieldCIFCombineTable], [FieldAccountCombineTable], [FieldCustomerNumberCombineTable], [IsUseSamplingData], [SamplingValue], [FK_SamplingType_Id], [IsEncryptFile], [FK_EncryptionKeyType_ID], [EncryptionKeyValue], [IsProsesEmailDelivery], [IsDisabledEncryptionforEmailDeliveryFile], [IsJointAccount], [IsEZipStatementOnEmailDelivery], [IsProsesSMSNotification], [IsProsesStatementDistribution], [IsDisabledEncryptionForStatementDisbtribution], [IsZipStatementOnDelivery], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy], [IsUseChecksumValidation], [ChecksumTable], [FieldNominalChecksum], [FieldNominal], [FieldCountChecksum], [FieldDateValidation], [Validation], [FieldNameValidation], [TableNameValidation], [FieldEMaterai], [FieldTotalNominalTransaction]) VALUES ((select top 1 PK_MsDataSourcePackage_ID from MsDataSourcePackage where DataSourcePackageCode = 'Tax Package Reporting Casa TD'), 'Tax Reporting Casa TD', (select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ('Tax Reporting Casa TD')), '0', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[customer_name]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[customer_name]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[cif]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[cif]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[account_no]', NULL, '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]', '0', NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', NULL, NULL, '0', NULL, '0', NULL, '0', '1', '0', '0', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system', '0', '', '', '', '', NULL, '0', '', '', '0', '0');
INSERT INTO [dbo].[StatementGenerator] ([FK_MsDataSourcePackage_ID], [StatementGeneratorName], [Fk_MsStatementTemplate_Id], [IsSeperateStatement], [FieldCustomerName], [FieldCustomerNameAlias], [FieldBranchCode], [FieldCustomerNumber], [FieldCIFNumber], [FieldAccountNo], [FieldProduct], [FieldPostalCode], [IsUseCombineStatement], [CombineTableName], [FieldCIFCombineTable], [FieldAccountCombineTable], [FieldCustomerNumberCombineTable], [IsUseSamplingData], [SamplingValue], [FK_SamplingType_Id], [IsEncryptFile], [FK_EncryptionKeyType_ID], [EncryptionKeyValue], [IsProsesEmailDelivery], [IsDisabledEncryptionforEmailDeliveryFile], [IsJointAccount], [IsEZipStatementOnEmailDelivery], [IsProsesSMSNotification], [IsProsesStatementDistribution], [IsDisabledEncryptionForStatementDisbtribution], [IsZipStatementOnDelivery], [Activation], [CreatedDate], [CreatedBy], [LastUpdatedDate], [LastUpdatedBy], [ApprovedDate], [ApprovedBy], [IsUseChecksumValidation], [ChecksumTable], [FieldNominalChecksum], [FieldNominal], [FieldCountChecksum], [FieldDateValidation], [Validation], [FieldNameValidation], [TableNameValidation], [FieldEMaterai], [FieldTotalNominalTransaction]) VALUES ((select top 1 PK_MsDataSourcePackage_ID from MsDataSourcePackage where DataSourcePackageCode = 'Tax Package Reporting Syariah'), 'Tax Reporting Syariah', (select top 1 Pk_MsStatementTemplate_Id from  MSSTATEMENTTEMPLATE WHERE STATEMENTTEMPLATENAME in ( 'Tax Reporting Syariah')), '0', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[customer_name]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[customer_name]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[cif]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[cif]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[account_no]', NULL, '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]', '0', NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', NULL, NULL, '0', NULL, '0', NULL, '0', '1','0',  '0', '1', GETDATE(), 'system', GETDATE(), 'system', GETDATE(), 'system', '0', '', '', '', '', NULL, '0', '', '', '0', '0');

INSERT INTO [dbo].[StatementGeneratorPrimaryKey] ([FK_StatementGenerator_ID], [TableNameField], [PrimaryKeyField]) VALUES ((select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Reporting Casa TD')), '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation]', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[DataID]');
INSERT INTO [dbo].[StatementGeneratorPrimaryKey] ([FK_StatementGenerator_ID], [TableNameField], [PrimaryKeyField]) VALUES ((select top 1 PK_StatementGenerator_ID From StatementGenerator where StatementGeneratorName in ('Tax Reporting Syariah')), '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation]', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[DataID]');

INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] ([FK_StatementGenerator_ID], [ParameterNameField], [FieldMapping]) VALUES ((SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Reporting Casa TD'), 'fk_taxrequestlist', '[TaxCustomerDeductedAdvice_OBS_CASATD_CustomerInformation].[fk_taxrequestlist]');

INSERT INTO [dbo].[StatementGeneratorStatementParameterMapping] ([FK_StatementGenerator_ID], [ParameterNameField], [FieldMapping]) VALUES ((SELECT TOP 1 PK_StatementGenerator_ID FROM StatementGenerator WHERE StatementGeneratorName = 'Tax Reporting Syariah'), 'fk_taxrequestlist', '[TaxCustomerDeductedAdvice_OBS_Syariah_CustomerInformation].[fk_taxrequestlist]');



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
