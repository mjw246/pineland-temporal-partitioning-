# Multiscale Acoustic Temporal Niche Partitioning of Pineland Birds

Data and code accompanying: **Walters, M.J., Robinson, S.K., and Guralnick, R. "Multiscale acoustic temporal niche partitioning of pineland birds across a latitudinal gradient."**

## Overview

This repository contains data and R code for analyzing temporal acoustic niche partitioning in Florida pineland bird communities across a 600 km latitudinal gradient.

## Data Files

### Large-scale Temporal Partitioning (`Data/large_scale/`)

These files contain 3-hour scale temporal overlap and avoidance data between Northern Cardinal (NOCA) and four other species.

#### `tpart_large1.csv`
Raw overlap and avoidance percentages for all ARU-day replicates.

**Columns:**
- `ID`: Sequential replicate identifier
- `WEVI_a`: White-eyed Vireo avoidance percentage with NOCA
- `WEVI_o`: White-eyed Vireo overlap percentage with NOCA
- `CARW_a`: Carolina Wren avoidance percentage with NOCA
- `CARW_o`: Carolina Wren overlap percentage with NOCA
- `MODO_a`: Mourning Dove avoidance percentage with NOCA
- `MODO_o`: Mourning Dove overlap percentage with NOCA
- `PIWA_a`: Pine Warbler avoidance percentage with NOCA
- `PIWA_o`: Pine Warbler overlap percentage with NOCA

#### `tpart_large1b.csv`
White-eyed Vireo data from `tpart_large1.csv` with site and ARU information added.

**Columns:**
- All columns from `tpart_large1.csv` (WEVI data only)
- `site`: Site identifier
- `aru`: ARU number within site (1 or 2)

#### `tpart_large2.csv`
Summary statistics for overlap and avoidance used in Figure 3. Mean and standard deviation across all replicates for each species pair.

**Columns:**
- `species`: Four-letter species code (CARW, WEVI, MODO, PIWA)
- `song_overlap`: Mean overlap percentage with NOCA
- `song_avoidance`: Mean avoidance percentage with NOCA
- `std`: Standard deviation of overlap/avoidance across replicates

#### `tpart_large4.csv`
Species pair overlap by site richness, used in Figure 4. Data are grouped by acoustic similarity to NOCA.

**Columns:**
- `richness`: Species richness at site (from point counts)
- `species`: Acoustic similarity category
  - `"similar"`: Pooled data from CARW and WEVI (acoustically similar to NOCA)
  - `"dissimilar"`: Pooled data from MODO and PIWA (acoustically dissimilar to NOCA)
- `overlap`: Mean overlap percentage for the species category at that richness level

### Small-scale Temporal Partitioning (`Data/small_scale/`)

These files contain 1-minute scale temporal overlap data calculated using the SONG package (Masco et al. 2016). 
**SONG p-metric interpretation:**
- **p < 0.5**: Species overlap more than expected by chance (temporal aggregation)
- **p = 0.5**: Random/independent timing (null expectation)
- **p > 0.5**: Species overlap less than expected by chance (temporal avoidance)

#### `tpart_small.csv`
Species pair SONG p-metric values by site richness, used in Figure 4. Data are grouped by acoustic similarity to NOCA.

**Columns:**
- `richness`: Species richness at site (from point counts)
- `species`: Acoustic similarity category
  - `"similar"`: Pooled data from CARW and WEVI (acoustically similar to NOCA)
  - `"dissimilar"`: Pooled data from MODO and PIWA (acoustically dissimilar to NOCA)
- `p`: Mean SONG p-metric value for the species category at that richness level

#### `tpart_small2.csv`
Raw SONG p-metric values for all ARU-day replicates (each species paired with NOCA).

**Columns:**
- `wevi`: White-eyed Vireo-NOCA SONG p-metric
- `carw`: Carolina Wren-NOCA SONG p-metric
- `piwa`: Pine Warbler-NOCA SONG p-metric
- `modo`: Mourning Dove-NOCA SONG p-metric
- `null`: Null expectation values (all 0.5), representing random temporal overlap with no avoidance or aggregation

**Note:** Each row represents one ARU-day replicate. The `null` column provides the expected value under random temporal overlap for comparison.

### Sample Audio Data (`Data/sample_SONG/`)

This folder contains example data demonstrating the input format for the SONG package temporal overlap analysis.

#### `simple_song.csv`
Example song bout timing data from a single 1-minute recording period, showing Northern Cardinal and White-eyed Vireo vocalizations. This file illustrates the raw data structure used for calculating SONG p-metrics.

**Columns:**
- `start`: Start time of song bout (seconds within the 1-minute recording)
- `end`: End time of song bout (seconds within the 1-minute recording)
- `ID`: Species identifier (four-letter code: NOCA or WEVI)

**Example usage:**
This file format is used as input to the SONG package to calculate temporal overlap metrics. Each row represents a single continuous vocalization bout by one individual/species.

### Species Richness and Site Data (`Data/species_richness/`)

These files contain point count data and site-level environmental variables used to characterize avian communities and habitat structure across the study gradient.

#### `point_count_data.csv`
Raw point count observations from all sites. Each row represents detection of one or more individuals of a species during a single point count.

**Columns:**
- `day`: Date of point count (format: MM/DD/YYYY)
- `time`: Start time of point count (24-hour military time)
- `site`: Study site identifier
- `ARU`: ARU number within site (identifies point count location)
- `species`: Four-letter species code
- `abundance`: Number of individuals detected (visual + auditory detections)

**Note:** Point counts were 10 minutes in duration, conducted during peak breeding bird activity (1 hour before to 2 hours after dawn). Species richness was calculated as the total number of species detected per site across all point counts, excluding waterbirds and flyover species.

#### `richness_lat.csv`
Site-level summary data used in Table 1 and statistical analyses. Environmental variables are averaged across all ARUs within each site.

**Columns:**
- `site`: Study site identifier
- `richness`: Total species detected at site (from point counts)
- `lat`: Latitude (decimal degrees)
- `nnd`: Nearest neighbor distance - mean distance to nearest conspecific tree (m)
- `dbh`: Mean diameter at breast height of trees ≥5 cm DBH (cm)
- `ch`: Mean canopy height (m)
- `uh`: Mean understory height (m)
- `uss`: Understory stem density - number of stems per unit area
- `uso`: Understory visual obstruction - percent vegetation cover blocking horizontal visibility
- `bg`: Percent bare ground cover
- `jd`: Mean Julian date of ARU recordings (day of year)
- `area`: Area of contiguous pineland habitat within of site (ha)
- `temp_month`: Mean temperature during recording month (°C)
- `hum_month`: Mean humidity during recording month (%)

**Note:** Vegetation and habitat variables (`nnd` through `bg`) were measured at multiple points within each site and averaged. Climate variables (`temp_month`, `hum_month`) were obtained from [data source].





## Species Codes

- **NOCA** = Northern Cardinal (*Cardinalis cardinalis*)
- **CARW** = Carolina Wren (*Thryothorus ludovicianus*)
- **WEVI** = White-eyed Vireo (*Vireo griseus*)
- **PIWA** = Pine Warbler (*Setophaga pinus*)
- **MODO** = Mourning Dove (*Zenaida macroura*)

## Figures

- **Figure 3**: Uses `tpart_large2.csv` - Mean overlap and avoidance for each species pair
- **Figure 4**: Uses `tpart_large4.csv` - Relationship between overlap and species richness by acoustic similarity



