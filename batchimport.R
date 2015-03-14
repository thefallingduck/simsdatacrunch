####Function to batch import .asc files from CAMECA 1280 ion microprobe
#creates one datafile that can be explored further

quickcompile<-function(directory){
  
  normwd<-getwd()
  filenames<-list.files(path = directory, pattern = NULL, all.files = FALSE,
                        full.names = FALSE, recursive = FALSE,
                        ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)   #create vector of filenames in folder for input
  
  factor.table<-read.table(text=filenames,sep='.',as.is=TRUE)  #Break delimited filenames into a table
  
  names(factor.table)<-c('analysis','file type') #Replace column names
  
  factor.table$Cond<-sub('[.].*','',factor.table$Cond) #Clip the .csv from the last column
  
  library('mefa')
  out.table<-data.frame()
  setwd(directory)
  
  for(i in 1:length(filenames))
  {
    
    #This part will nead some 'read lines' work probably?
    x<-read.table(filenames[i],sep=',',header=TRUE)  #read in .csv dataset
    y<-rep(factor.table[i,],times=nrow(x)) #create factor table for .csv dataset
    z<-cbind(x,y)
    
    
    out.table<-rbind(out.table,z)
    
  }
  
  setwd(normwd)
  
  return(out.table)
  
}