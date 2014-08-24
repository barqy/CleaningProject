write_tidy<-function(dsroot="UCI HAR Dataset"){
# The function is Course Project in Getting and Cleaning Data course,
# see https://class.coursera.org/getdata-006
#
# The function creates tidy_aggds.txt file which merges training and test data sets,
# aggregates the data by subject and activity. 
#
# Input arguments:
# dsroot - directory name with the original data set, this can be absolute or relative path.


	# load the data with subject column from the train or test dir
	load_frame<-function(dsname){
	#
	# Input argument:
	# dsname - name of the data set, values are "train" or "test"
		dirname = file.path(dsroot,dsname)
		data = read.csv(file.path(dirname,paste0("X_",dsname,".txt")),sep="",header=FALSE,colClasses="double")
		subj = read.csv(file.path(dirname,paste0("subject_",dsname,".txt")),sep="",header=FALSE)
		act = read.csv(file.path(dirname,paste0("y_",dsname,".txt")),sep="",header=FALSE,colClasses="character")
		return( cbind(subj,act,data[,cols]) )
	}

	# get the required columns to aggregate
	print("Started...")
	features = read.csv(file.path(dsroot,"features.txt"),sep=" ",header=FALSE,colClasses="character")
	cols = grep("(mean|std)\\(\\)",features$V2)

	# concatenate train and test sets
	data = rbind(load_frame("train"),load_frame("test"))
	names(data) = c("subject","actnum",features[cols,2])

	# merge the data with activities, and replace labels
	activities = read.csv(file.path(dsroot,"activity_labels.txt"),sep=" ",header=FALSE,colClasses="character")
	names(activities) = c("actnum","activity")
	dataa = merge(activities,data)
	clen = ncol(dataa)

	# aggregate (mean) by subject and activity
	aggdt=aggregate(dataa[,4:clen],by=list(dataa$subject,dataa$activity),FUN="mean")
	names(aggdt) = c("subject","activity",features[cols,2])

	# write the aggregated data set
	write.table(aggdt,"tidy_aggds.txt",row.names=FALSE,quote=FALSE,sep="\t")
	print("done")
}
