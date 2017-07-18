---
title: "Readme"
output: html_document
---

This document decribes the project files. Script "run_analysis.R" does the transformations mentioned in the project requirements producing output "data2.txt".

Notice that "run_analysis.R" assumes that all the data files of the Samsung data need to be in the working directory as mentioned in the project requirements.


Codebook.md describes the used variables.

Description of "run_analysis.R":

1) Read train and test data.
2) Combine train and test data.
3) Locate mean() and std() variables and filter out all the other columns.
4) Read labels and insert descriptive activity names.
5) Create second dataset: first read subject numbers.
6) Then calculate averages for activities.
7) Then calculate averages for subjects.
8) Write output file "data2.txt".


