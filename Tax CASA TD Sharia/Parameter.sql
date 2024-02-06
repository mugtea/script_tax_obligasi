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


