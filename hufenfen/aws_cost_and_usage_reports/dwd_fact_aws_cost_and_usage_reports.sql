CREATE TABLE cost.dwd_fact_aws_cost_and_usage_reports (
    `identity/LineItemId` String COMMENT '',
    `identity/TimeInterval` String COMMENT '',
    `bill/InvoiceId` String COMMENT '',
    `bill/InvoicingEntity` String COMMENT '',
    `bill/BillingEntity` String COMMENT '',
    `bill/BillType` String COMMENT '',
    `bill/PayerAccountId` String COMMENT '',
    `bill/BillingPeriodStartDate` String COMMENT '',
    `bill/BillingPeriodEndDate` String COMMENT '',
    `lineItem/UsageAccountId` String COMMENT '',
    `lineItem/LineItemType` String COMMENT '',
    `lineItem/UsageStartDate` String COMMENT '',
    `lineItem/UsageEndDate` String COMMENT '',
    `lineItem/ProductCode` String COMMENT '',
    `lineItem/UsageType` String COMMENT '',
    `lineItem/Operation` String COMMENT '',
    `lineItem/AvailabilityZone` String COMMENT '',
    `lineItem/ResourceId` String COMMENT '',
    `lineItem/UsageAmount` Decimal(38, 18) COMMENT '',
    `lineItem/NormalizationFactor` Decimal(10, 4) COMMENT '',
    `lineItem/NormalizedUsageAmount` Decimal(38, 18) COMMENT '',
    `lineItem/CurrencyCode` String COMMENT '',
    `lineItem/UnblendedRate` Decimal(38, 18) COMMENT '',
    `lineItem/UnblendedCost` Decimal(38, 18) COMMENT '',
    `lineItem/BlendedRate` Decimal(38, 18) COMMENT '',
    `lineItem/BlendedCost` Decimal(38, 18) COMMENT '',
    `lineItem/LineItemDescription` String COMMENT '',
    `lineItem/TaxType` String COMMENT '',
    `lineItem/LegalEntity` String COMMENT '',
    `product/ProductName` String COMMENT '',
    `product/PurchaseOption` String COMMENT '',
    `product/alarmType` String COMMENT '',
    `product/availability` String COMMENT '',
    `product/availabilityZone` String COMMENT '',
    `product/brokerEngine` String COMMENT '',
    `product/cacheEngine` String COMMENT '',
    `product/capacitystatus` String COMMENT '',
    `product/classicnetworkingsupport` String COMMENT '',
    `product/clientLocation` String COMMENT '',
    `product/clockSpeed` String COMMENT '',
    `product/computeFamily` String COMMENT '',
    `product/countsAgainstQuota` String COMMENT '',
    `product/currentGeneration` String COMMENT '',
    `product/dataTransferQuota` String COMMENT '',
    `product/databaseEngine` String COMMENT '',
    `product/dedicatedEbsThroughput` String COMMENT '',
    `product/deploymentOption` String COMMENT '',
    `product/description` String COMMENT '',
    `product/dominantnondominant` String COMMENT '',
    `product/durability` String COMMENT '',
    `product/ecu` String COMMENT '',
    `product/endpointType` String COMMENT '',
    `product/engineCode` String COMMENT '',
    `product/enhancedNetworkingSupport` String COMMENT '',
    `product/enhancedNetworkingSupported` String COMMENT '',
    `product/feeDescription` String COMMENT '',
    `product/freeOverage` String COMMENT '',
    `product/fromLocation` String COMMENT '',
    `product/fromLocationType` String COMMENT '',
    `product/fromRegionCode` String COMMENT '',
    `product/group` String COMMENT '',
    `product/groupDescription` String COMMENT '',
    `product/instanceFamily` String COMMENT '',
    `product/instanceType` String COMMENT '',
    `product/instanceTypeFamily` String COMMENT '',
    `product/intelAvx2Available` String COMMENT '',
    `product/intelAvxAvailable` String COMMENT '',
    `product/intelTurboAvailable` String COMMENT '',
    `product/licenseModel` String COMMENT '',
    `product/location` String COMMENT '',
    `product/locationType` String COMMENT '',
    `product/logsDestination` String COMMENT '',
    `product/marketoption` String COMMENT '',
    `product/maxIopsBurstPerformance` String COMMENT '',
    `product/maxIopsvolume` String COMMENT '',
    `product/maxThroughputvolume` String COMMENT '',
    `product/maxVolumeSize` String COMMENT '',
    `product/memory` String COMMENT '',
    `product/memoryGib` String COMMENT '',
    `product/messageDeliveryFrequency` String COMMENT '',
    `product/messageDeliveryOrder` String COMMENT '',
    `product/minVolumeSize` String COMMENT '',
    `product/networkPerformance` String COMMENT '',
    `product/normalizationSizeFactor` Decimal(10, 4) COMMENT '',
    `product/operatingSystem` String COMMENT '',
    `product/operation` String COMMENT '',
    `product/overageType` String COMMENT '',
    `product/physicalProcessor` String COMMENT '',
    `product/platoinstancename` String COMMENT '',
    `product/platostoragename` String COMMENT '',
    `product/platostoragetype` String COMMENT '',
    `product/platousagetype` String COMMENT '',
    `product/platovolumetype` String COMMENT '',
    `product/preInstalledSw` String COMMENT '',
    `product/pricingUnit` String COMMENT '',
    `product/processorArchitecture` String COMMENT '',
    `product/processorFeatures` String COMMENT '',
    `product/productFamily` String COMMENT '',
    `product/provisioned` String COMMENT '',
    `product/purchaseterm` String COMMENT '',
    `product/queueType` String COMMENT '',
    `product/region` String COMMENT '',
    `product/regionCode` String COMMENT '',
    `product/requestDescription` String COMMENT '',
    `product/requestType` String COMMENT '',
    `product/resourcePriceGroup` String COMMENT '',
    `product/routingTarget` String COMMENT '',
    `product/routingType` String COMMENT '',
    `product/servicecode` String COMMENT '',
    `product/servicename` String COMMENT '',
    `product/sku` String COMMENT '',
    `product/softwareType` String COMMENT '',
    `product/storage` String COMMENT '',
    `product/storageClass` String COMMENT '',
    `product/storageFamily` String COMMENT '',
    `product/storageMedia` String COMMENT '',
    `product/storageType` String COMMENT '',
    `product/tenancy` String COMMENT '',
    `product/toLocation` String COMMENT '',
    `product/toLocationType` String COMMENT '',
    `product/toRegionCode` String COMMENT '',
    `product/trafficDirection` String COMMENT '',
    `product/transferType` String COMMENT '',
    `product/usagetype` String COMMENT '',
    `product/vcpu` String COMMENT '',
    `product/version` String COMMENT '',
    `product/volumeApiName` String COMMENT '',
    `product/volumeType` String COMMENT '',
    `product/vpcnetworkingsupport` String COMMENT '',
    `pricing/LeaseContractLength` String COMMENT '',
    `pricing/OfferingClass` String COMMENT '',
    `pricing/PurchaseOption` String COMMENT '',
    `pricing/RateCode` String COMMENT '',
    `pricing/RateId` String COMMENT '',
    `pricing/currency` String COMMENT '',
    `pricing/publicOnDemandCost` Decimal(38, 18) COMMENT '',
    `pricing/publicOnDemandRate` Decimal(38, 18) COMMENT '',
    `pricing/term` String COMMENT '',
    `pricing/unit` String COMMENT '',
    `reservation/AmortizedUpfrontCostForUsage` Decimal(38, 18) COMMENT '',
    `reservation/AmortizedUpfrontFeeForBillingPeriod` Decimal(38, 18) COMMENT '',
    `reservation/EffectiveCost` Decimal(38, 18) COMMENT '',
    `reservation/EndTime` String COMMENT '',
    `reservation/ModificationStatus` String COMMENT '',
    `reservation/NormalizedUnitsPerReservation` Decimal(10, 4) COMMENT '',
    `reservation/NumberOfReservations` Nullable(Int32) COMMENT '',
    `reservation/RecurringFeeForUsage` Decimal(38, 18) COMMENT '',
    `reservation/ReservationARN` String COMMENT '',
    `reservation/StartTime` String COMMENT '',
    `reservation/SubscriptionId` String COMMENT '',
    `reservation/TotalReservedNormalizedUnits` Decimal(10, 4) COMMENT '',
    `reservation/TotalReservedUnits` Decimal(38, 18) COMMENT '',
    `reservation/UnitsPerReservation` Decimal(10, 4) COMMENT '',
    `reservation/UnusedAmortizedUpfrontFeeForBillingPeriod` Decimal(38, 18) COMMENT '',
    `reservation/UnusedNormalizedUnitQuantity` Decimal(38, 18) COMMENT '',
    `reservation/UnusedQuantity` Decimal(38, 18) COMMENT '',
    `reservation/UnusedRecurringFee` Decimal(38, 18) COMMENT '',
    `reservation/UpfrontValue` Decimal(38, 18) COMMENT '',
    `savingsPlan/TotalCommitmentToDate` Decimal(38, 18) COMMENT '',
    `savingsPlan/SavingsPlanARN` String COMMENT '',
    `savingsPlan/SavingsPlanRate` Decimal(38, 18) COMMENT '',
    `savingsPlan/UsedCommitment` Decimal(38, 18) COMMENT '',
    `savingsPlan/SavingsPlanEffectiveCost` Decimal(38, 18) COMMENT '',
    `savingsPlan/AmortizedUpfrontCommitmentForBillingPeriod` String COMMENT '',
    `savingsPlan/RecurringCommitmentForBillingPeriod` Decimal(38, 18) COMMENT '',
    `savingsPlan/StartTime` String COMMENT '',
    `savingsPlan/EndTime` String COMMENT '',
    `savingsPlan/OfferingType` String COMMENT '',
    `savingsPlan/PaymentOption` String COMMENT '',
    `savingsPlan/PurchaseTerm` String COMMENT '',
    `savingsPlan/Region` String COMMENT ''
) ENGINE = S3(
    'https://shiyou-master-billings.s3.ap-southeast-1.amazonaws.com/aws-cur/shiyou-master-cur/*/*.csv.gz',
    'CSVWithNames'
) SETTINGS input_format_with_names_use_header = 1,
input_format_skip_unknown_fields = 1;
