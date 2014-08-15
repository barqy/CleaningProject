write_tidy<-function(dsroot="UCI HAR Dataset"){

	# load the data with subject column from the train or test dir
	load_frame<-function(dsname){
		dirname = file.path(dsroot,dsname)
		data = read.csv(file.path(dirname,paste0("X_",dsname,".txt")),sep="",header=FALSE,colClasses="double")
		subj = read.csv(file.path(dirname,paste0("subject_",dsname,".txt")),sep="",header=FALSE)
		act = read.csv(file.path(dirname,paste0("y_",dsname,".txt")),sep="",header=FALSE,colClasses="character")
		return( cbind(subj,act,data[,cols]) )
	}

	# get the required columns
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
	#	write.table(dataa[,2:clen],"fulldata.txt",row.names=FALSE,quote=FALSE,sep="\t")

	# aggregate (mean) by subject and activity
	aggdt=aggregate(dataa[,4:clen],by=list(dataa$subject,dataa$activity),FUN="mean")
	names(aggdt) = c("subject","activity",features[cols,2])
	write.table(aggdt,"tidy_aggds.txt",row.names=FALSE,quote=FALSE,sep="\t")
}
