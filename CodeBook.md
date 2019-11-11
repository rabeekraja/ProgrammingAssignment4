## Code Book

This code book describe the data used in this project, as well as the processing steps required to create the resulting tidy data set in txt
and csv format.

### Overview

30 volunteers (Age Group of 19-48 years) performed 6 different activities while wearing a smartphone.
The smartphone captured various data about their movements as below.
## Activities List
1) WALKING
2) WALKING_UPSTAIRS
3) WALKING_DOWNSTAIRS
4) SITTING
5) STANDING
6) LAYING


### Explanation of each file

* `features_info.txt`: Shows information about the variables used on the feature vector.
* `features.txt`: List of all features.Names of the 561 features.
* `activity_labels.txt`: Names and IDs for each of the 6 activities as listed above.

* `train/X_train.txt`: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* `train/subject_train.txt`: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in `X_train.txt`.
* `train/y_train.txt`: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in `X_train.txt`.

* `test/X_test.txt`: 2947 observations of the 561 features, for 9 of the 30 volunteers.
* `test/subject_test.txt`: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in `X_test.txt`.
* `test/y_test.txt`: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in `X_test.txt`.


### Remarks on Data files that were used

This analysis was done using test & train folders at top level data files - Sub folder not used.

### Processing steps
Library plyr were used to tidy the final data.
1. Only relevant data files were read into data frames, column headers were added, and the training and test sets were combined into a single data set as mergedDataSet.
2. All feature columns were removed that did not contain the exact string "mean()" or "std()". This left 66 feature columns, plus the subjectID and activity columns.
3. The activity column was converted from a integer to a factor, using labels describing the activities.
4. A tidy data set was created containing the mean of each feature for each subject and each activity. Thus, subject #1 has 6 rows in the tidy data set (one row for each activity), and each row contains the mean value for each of the 66 features for that subject/activity combination. Since there are 30 subjects, there are a total of 180 rows.
5. The tidy data set was output to a CSV file and txt file.

Gathered Data got 561 rows and 4 columns of data and then final set have 180 rows and 68 columns of data that is tidy.
