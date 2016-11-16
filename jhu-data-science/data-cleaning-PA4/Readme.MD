# Getting and Cleaning Data Course Project
The purpose of this project is to prepare tidy data that can be used for later analysis.

File `CodeBook.MD` explains where does the raw data comes from and how it has been transformed to produce tidy data.
File `run_analysis.R` is the main R script that will take the raw data and produce a tidy data file called `tidyData.txt`.
Finally  `clean_features.R` contains an util function to make columns names of the tidy data both human readable and syntactically valid.

To use this project, follow this steps :

1. Retrieve the two R files of this repo
2. Download [the raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzipped it in R files directory
3. Launch `run_analysis.R` (make sure your working directory is set to the one containing those files)

## License

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. 
Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.