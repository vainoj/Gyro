---
title: "Codebook"
output: html_document
---

This Codebook describes the variables used in the project. The original source of the measurements signals is accelerometer and gyroscope data. Their unit is either frequency based or time based. In the original data, there are are 561 measurement variables in time and frequency domain, for example based on mean or signal entropy. In the "run_analysis.R", only mean() and std() based variables are selected leaving 79 variables.

In the "run_analysis.R" activity for each measurement is added. The possible values are:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

For creating the second dataset in the project, we calculate average for each pair of activity and subject. This gives 30*6 = 180 datalines.

