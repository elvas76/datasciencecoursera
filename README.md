## Analysis of Samsung data

The script begins by reading the following files, assumed to be located in the
same directory as the run_analysis.R script:

* activity_labels.txt
* features.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

First, the dataframes corresponding to the y_test and X_test are binded vertically (by columns),
in order to create the data_test dataframe
The same is done to the y_train and X_train dataframes, generating the data_train dataframe.
Then, the test and train dataframes created above are binded horizontally (by rows) into the full data dataframe.
Column labels are obtained from the features dataframe, together with the column "activity_id" which comes from y_train and y_test 
dataframes.

The next step consists in selecting the columns that contain the string "mean" or the string "std". This is done by means of the grep
function.

It's now time to combine the data whith the activity_labels file. This is accomplished by the merge function using the column "activity_id" as the by parameter, thus creating the more descriptive column "activity_name".
The "activity_id" columns is no longer necessary and is dropped.

Now, it's time to group the dataframe by the newly created "activity_name" column. We accomplish this by means of the summarise_each
function in the dplyr package. All remaining columns are summarised by the mean() function.

Lastly, the resulting grouped dataframe is saved to a file named "tidy_dataset.txt" using the write.table function ommiting row names.
