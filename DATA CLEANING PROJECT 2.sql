select * from [dbo].[nashville housing]

-- Populate Property Address data

select PropertyAddress
from [dbo].[nashville housing]
where  PropertyAddress is null

select * from [dbo].[nashville housing]
order by ParcelID 

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [dbo].[nashville housing] a
JOIN [dbo].[nashville housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [dbo].[nashville housing] a
JOIN [dbo].[nashville housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)
 
 select PropertyAddress
from [dbo].[nashville housing]   

Select PropertyAddress
From [dbo].[nashville housing]


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
 from [dbo].[nashville housing] 

 ALTER TABLE [dbo].[nashville housing]
Add PropertySplitAddress Nvarchar(255);

Update [dbo].[nashville housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE [dbo].[nashville housing]
Add PropertySplitCity Nvarchar(255);

Update [dbo].[nashville housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

select * from [dbo].[nashville housing]

 
Select OwnerAddress
From  [dbo].[nashville housing]


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [dbo].[nashville housing]

ALTER TABLE  [dbo].[nashville housing]
Add OwnerSplitAddress Nvarchar(255);

Update  [dbo].[nashville housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE  [dbo].[nashville housing]
Add OwnerSplitCity Nvarchar(255);

Update  [dbo].[nashville housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE [dbo].[nashville housing]
Add OwnerSplitState Nvarchar(255);

Update[dbo].[nashville housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



 
  -- Remove Duplicates  
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From [dbo].[nashville housing]
--order by ParcelID
)
delete
From RowNumCTE
Where row_num > 1
--order by propertyAddress


-- Delete Unused Columns


ALTER TABLE [dbo].[nashville housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate 