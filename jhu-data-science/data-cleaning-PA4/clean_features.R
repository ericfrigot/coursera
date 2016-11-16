# Take a vector of features and make them human readable using information from (F./UCI HAR Dataset/features_info.txt)
# Also make them syntactically valid.
# A syntactically valid name consists of letters, numbers and the dot or underline characters and starts with a letter 
# or the dot not followed by a number. Here we choose a camel case approach
makeFeaturesHumanReadable <- function(data) {
  result <- data
  result <- sub("-mean", "Mean", result)
  result <- sub("-std", "StandardDeviation", result)
  result <- sub("-mad", "MedianAbsoluteDeviation", result)
  result <- sub("-max", "Max", result)
  result <- sub("-min", "Min", result)
  result <- sub("-sma", "SignalMagnitudeArea", result)
  result <- sub("-energy", "Energy", result)
  result <- sub("-iqr", "InterquartileRange", result)
  result <- sub("-entropy", "SignalEntropy", result)
  result <- sub("-arCoeff", "AutoregresionCoefficients", result)
  result <- sub("-correlation", "CorrelationCoefficent", result)
  result <- sub("-maxInds", "MaxFrequencyMagnitude", result)
  result <- sub("-meanFreq", "MeanFrequency", result)
  result <- sub("-skewness", "Skewness", result)
  result <- sub("-kurtosis", "Kurtosis", result)
  result <- sub("-bandsEnergy", "BandsEnergy", result)
  result <- sub("-angle", "Angle", result)
  
  result <- sub("Acc", "Acceleration", result)
  result <- sub("Gyro", "AngularPosition", result)
  
  result <- sub("^t", "time", result)
  result <- sub("^f", "frequency", result)
  
  result <- gsub("-X", "X", result)
  result <- gsub("-Y", "Y", result)
  result <- gsub("-Z", "Z", result)
  
  result <- sub("angle\\(tBody", "angleTimeBody", result)
  result <- sub(",gravity", "Gravity", result)
  
  
  result <- gsub("-1", "1", result)
  result <- gsub("-2", "2", result)
  result <- gsub("-3", "3", result)
  result <- gsub("-4", "4", result)
  result <- gsub("-5", "5", result)
  result <- gsub("-9", "9", result)
  
  result <- gsub(",", "\\.", result)
  result <- gsub("\\(", "", result)
  result <- gsub(")", "", result)
  result
}