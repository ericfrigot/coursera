Note that files are referenced starting from root directory of this project.

# Study Design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the 
data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter 
into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See `UCI HAR Dataset/features_info.txt` for more details. 

# Code book

## For each record it is provided

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

## The dataset includes the following files

* `UCI HAR Dataset/README.txt`
* `UCI HAR Dataset/features_info.txt`: Shows information about the variables used on the feature vector.
* `UCI HAR Dataset/features.txt`: List of all features.
* `UCI HAR Dataset/activity_labels.txt`: Links the class labels with their activity name.
* `UCI HAR Dataset/train/X_train.txt`: Training set.
* `UCI HAR Dataset/train/y_train.txt`: Training labels.
* `UCI HAR Dataset/test/X_test.txt`: Test set.
* `UCI HAR Dataset/test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* `UCI HAR Dataset/train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* `UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 
128 element vector. The same description applies for the `UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt` and `UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt` files for the Y and Z axis. 
* `UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* `UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Notes

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

# Features information

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals 
(prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth 
filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in `UCI HAR Dataset/features.txt`

# Summary
The summary contained in the tidy data produced by this project respect the following steps 

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Produce a tidy data set with the average of each variable for each activity and each subject.

## Make variables names human readable

Variables names produced in this project mainly comes from `UCI HAR Dataset/train/X_train.txt` and `UCI HAR Dataset/test/X_test.txt`.
Their names can be find in `UCI HAR Dataset/features.txt`. There are two problems with those names :

1. They are not syntactically correct (according to R read.table function). Some of them contain parenthesis or comma which can lead to error
if they are manipulated by other tools or used as a file name.
2. They are not human readable. For exemple 'tGravityAcc-sma()' stand for : Time Gravity Acceleration Signal Magnitude Area. 

The purpose of R script `clean_features.R` is a response to those problems. It will both remove incorrect characters and make the variables names
more readable.

## Merging required data all together

This part is done in R script `run_analysis.R` by the following steps :

1. Load activity names and features names
2. Convert feature names according to what is explain just above
3. Load train and test data sets (use features names to have tidy variables names), labels and subjects
4. Bind data sets and labels (they have the same number of rows)
5. Bind data sets and subjects (they also have the same number of rows)
6. Bind train and test data sets all together
7. Merge activity names in the produced data set
8. Filter the data set to only keep the activity name, the subject id and features containing 'Mean' or 'StandardDeviation'

## Produce the tidy data

This part is also done in the R script `run_analysis.R`. It uses 'dplyr' package from R to first group the data by activity name and subject id and
then apply a mean function on all the other columns.

The final data is a matrice of 6 (activities) for each 30 (subjects) which gives 180 rows. It contains 86 features.
