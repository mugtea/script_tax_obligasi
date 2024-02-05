CREATE FUNCTION sf_formatTanggal(@tanggal DATE)
RETURNS VARCHAR(255)
AS
BEGIN
  DECLARE @varhasil VARCHAR(255);

  SELECT @varhasil = CONCAT(
    
    DATEPART(DAY, @tanggal),' ',
    CASE DATEPART(MONTH, @tanggal) 
      WHEN 1 THEN 'Januari' 
      WHEN 2 THEN 'Februari' 
      WHEN 3 THEN 'Maret' 
      WHEN 4 THEN 'April' 
      WHEN 5 THEN 'Mei' 
      WHEN 6 THEN 'Juni' 
      WHEN 7 THEN 'Juli' 
      WHEN 8 THEN 'Agustus' 
      WHEN 9 THEN 'September'
      WHEN 10 THEN 'Oktober' 
      WHEN 11 THEN 'November' 
      WHEN 12 THEN 'Desember' 
    END,' ',
    DATEPART(YEAR, @tanggal)
  );

  RETURN @varhasil;
END