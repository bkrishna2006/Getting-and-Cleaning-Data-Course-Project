Steps followed

1. Downloading data from the URL (done outside of script)
2. Load the features and activity labels data
3. Extract only required features (mean & std deviation) from the features dataset
4. Bring consistency to feature names by changing to Uppercase, removing "-", "(", ")" etc)
5. Loaded the train and test data from .txt files by extracting activities, subjects data
6. Merged train and test data sets
7. Added descriptive column names
8. Turned activities and subjects into factors
9. Installed and loaded package reshape2 to be able to use the melt command.
10. Calculated the mean and wrote the tidy data set.
