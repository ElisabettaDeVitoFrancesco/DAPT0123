CREATE DATABASE M7_Water_Quality_Analysis;

USE M7_Water_Quality_Analysis;


--------------------------------------------------------------------------------------------------------------------
-- Spatial data
--------------------------------------------------------------------------------------------------------------------
SELECT TOP 100 * FROM spatial_data;

SELECT DISTINCT(countryCode)
FROM spatial_data
ORDER BY countryCode;

SELECT ID
	, countryCode
	, thematicIdIdentifier
	, monitoringSiteIdentifier
	, monitoringSiteIdentifierScheme
	, waterBodyIdentifier
	, waterBodyIdentifierScheme
	, WaterBodyName
	, specialisedZoneType
	, naturalAWBHMWB
	, subUnitIdentifier
	, lon
	, lat
FROM spatial_data
WHERE specialisedZoneType = 'riverWaterBody' OR specialisedZoneType = 'lakeWaterBody';

SELECT COUNT(countryCode)
FROM spatial_data; -- 54322

SELECT COUNT(DISTINCT(thematicIdIdentifier))
FROM spatial_data; --54212

SELECT COUNT(DISTINCT(monitoringSiteIdentifier))
FROM spatial_data; -- 54212

SELECT COUNT(DISTINCT(monitoringSiteIdentifierScheme))
FROM spatial_data; -- 2

SELECT COUNT(DISTINCT(waterBodyIdentifier))
FROM spatial_data; -- 26310

SELECT COUNT(DISTINCT(waterBodyIdentifierScheme))
FROM spatial_data; -- 4

SELECT DISTINCT(waterBodyIdentifierScheme)
FROM spatial_data; -- euGroundWaterBodyCode eionetGroundWaterBodyCode eionetSurfaceWaterBodyCode euSurfaceWaterBodyCode

SELECT COUNT(DISTINCT(subUnitIdentifier))
FROM spatial_data; -- 255

-- Create a view to connect to Power BI
DROP VIEW IF EXISTS spatial_data_v;

GO

CREATE VIEW spatial_data_v AS (
		SELECT ID
			, countryCode
			, thematicIdIdentifier
			, monitoringSiteIdentifier
			, monitoringSiteIdentifierScheme
			, waterBodyIdentifier
			, waterBodyIdentifierScheme
			, WaterBodyName
			, specialisedZoneType
			, naturalAWBHMWB
			, subUnitIdentifier
			, lon
			, lat
		FROM spatial_data
		WHERE specialisedZoneType = 'riverWaterBody' OR specialisedZoneType = 'lakeWaterBody');

GO
--------------------------------------------------------------------------------------------------------------------
-- Emission data
--------------------------------------------------------------------------------------------------------------------
SELECT TOP 100 * FROM emissions_data;

SELECT countryCode
	, spatialUnitIdentifier
	, spatialUnitIdentifierScheme
	, observedPropertyDeterminandCode
	, observedPropertyDeterminandLabel
	, parameterEmissionsSourceCategory
	, UID
	, resultsEmissionsValueNEW
	, TimeReferenceStart
	, TimeReferenceEnd
FROM emissions_data;

SELECT DISTINCT(spatialUnitIdentifier) FROM emissions_data ORDER BY spatialUnitIdentifier;
SELECT DISTINCT(spatialUnitIdentifierScheme) FROM emissions_data ORDER BY spatialUnitIdentifierScheme;


-- Create a view to connect to Power BI
DROP VIEW IF EXISTS emissions_data_v;

GO

CREATE VIEW emissions_data_v AS (
		SELECT countryCode
			, spatialUnitIdentifier
			, spatialUnitIdentifierScheme
			, observedPropertyDeterminandCode
			, observedPropertyDeterminandLabel
			, parameterEmissionsSourceCategory
			, UID
			, resultsEmissionsValueNEW
			, TimeReferenceStart
			, TimeReferenceEnd
		FROM emissions_data);

GO

--------------------------------------------------------------------------------------------------------------------
-- Monitoring data
--------------------------------------------------------------------------------------------------------------------
SELECT TOP 100 * FROM monitoring_data;
SELECT DISTINCT(observedProperty) FROM monitoring_data;
SELECT DISTINCT(resultObservationStatus) FROM monitoring_data;
SELECT DISTINCT(metadata_statusCode) FROM monitoring_data;
SELECT DISTINCT(metadata_observationStatus) FROM monitoring_data;

SELECT countryCode
	, monitoringSiteIdentifier
	, monitoringSiteIdentifierScheme
	, resultObservedValue
	, UID
	, phenomenonTimePeriodStart
	, phenomenonTimePeriodEnd
FROM monitoring_data;

-- Create a view to connect to Power BI
DROP VIEW IF EXISTS monitoring_data_v;

GO

CREATE VIEW monitoring_data_v AS (
		SELECT countryCode
			, monitoringSiteIdentifier
			, monitoringSiteIdentifierScheme
			, resultObservedValue
			, UID
			, phenomenonTimePeriodStart
			, phenomenonTimePeriodEnd
		FROM monitoring_data);

GO

--------------------------------------------------------------------------------------------------------------------
-- Measured water quality data
--------------------------------------------------------------------------------------------------------------------
SELECT TOP 100 * FROM measured_data;
SELECT DISTINCT(parameterWaterBodyCategory) FROM measured_data;
SELECT DISTINCT(procedureAnalysedMatrix) FROM measured_data;
SELECT DISTINCT(observedPropertyDeterminandLabel) FROM measured_data ORDER BY observedPropertyDeterminandLabel;

SELECT countryCode
	, monitoringSiteIdentifier
	, monitoringSiteIdentifierScheme
	, parameterWaterBodyCategory
	, observedPropertyDeterminandCode
	, observedPropertyDeterminandLabel
	, resultUom
	, resultMeanValue
	, resultMedianValue
	, resultStandardDeviationValue
	, UID
	, phenomenonTimeReferenceYear
	, parameterSamplingPeriodStart
	, parameterSamplingPeriodEnd
FROM measured_data
WHERE procedureAnalysedMatrix = 'W';


SELECT countryCode
	, phenomenonTimeReferenceYear
	, AVG(resultMeanValue) AS mean_TOC
FROM measured_data
WHERE observedPropertyDeterminandLabel = 'Total organic carbon (TOC)'
GROUP BY countryCode, phenomenonTimeReferenceYear
ORDER BY countryCode, phenomenonTimeReferenceYear; -- Measured data not in each year

SELECT countryCode
	, phenomenonTimeReferenceYear
	, ROUND(AVG(resultMeanValue), 2) AS mean_Ammonium_country_year
	, COUNT(resultMeanValue) AS reported_mean_measurements
FROM measured_data
WHERE observedPropertyDeterminandLabel = 'Ammonium'
GROUP BY countryCode, phenomenonTimeReferenceYear
ORDER BY countryCode, phenomenonTimeReferenceYear;

SELECT phenomenonTimeReferenceYear
	, ROUND(AVG(resultMeanValue), 2) AS mean_Ammonium_year
	, COUNT(resultMeanValue) AS reported_mean_measurements
FROM measured_data
WHERE observedPropertyDeterminandLabel = 'Ammonium'
GROUP BY phenomenonTimeReferenceYear
ORDER BY phenomenonTimeReferenceYear;

SELECT DISTINCT(observedPropertyDeterminandLabel)
	, observedPropertyDeterminandCode
	, resultUom
FROM measured_data;

-- Create a view to connect to Power BI
DROP VIEW IF EXISTS measured_data_v;

GO

CREATE VIEW measured_data_v AS (

		SELECT countryCode
			, monitoringSiteIdentifier
			, monitoringSiteIdentifierScheme
			, parameterWaterBodyCategory
			, observedPropertyDeterminandCode
			, observedPropertyDeterminandLabel
			, resultUom
			, resultMeanValue
			, resultMedianValue
			, resultStandardDeviationValue
			, UID
			, phenomenonTimeReferenceYear
			, parameterSamplingPeriodStart
			, parameterSamplingPeriodEnd
		FROM measured_data
		WHERE procedureAnalysedMatrix = 'W');

GO