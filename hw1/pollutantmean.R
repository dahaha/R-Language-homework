filenameConvert<-function(i){
        if(i < 10){
                newID <- paste("00", i, sep = "")
                fileID <- paste(newID, ".csv", sep = "") # 001.csv       
        } else if(i >= 10 & i <= 99){
                newID <- paste("0", i, sep = "")
                fileID <- paste(newID, ".csv", sep = "")    
        } else{
                fileID <- paste(i, ".csv", sep = "")  
        }  
        
        fileID
        
        
}


pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        ##paste(getwd(),directory,sep="/")
        
        setwd(paste("/Users/zhuangenze/Desktop",directory,sep="/"))
        means <- c() 
        for(i in id){
                data <- read.csv(filenameConvert(i))
                
                my_mean <-c(data[,pollutant])
                
                means <- c(means,my_mean)
        }
        
       
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        print(mean(means,na.rm=TRUE))
}

complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        setwd(paste("/Users/zhuangenze/Desktop",directory,sep="/"))
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        csv_id = c()
        num = c()
        for(i in id){
                csv_id = c(csv_id,i)
                data <- na.omit(read.csv(filenameConvert(i)))
                num = c(num,nrow(data))
        }
        data.frame(id<-csv_id,nobs<-num)
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}

corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        setwd(paste("/Users/zhuangenze/Desktop",directory,sep="/"))
        f <- length(list.files())
        output = c()
        for(i in 1:f){
                data <- na.omit(read.csv(filenameConvert(i)))
                
                if(nrow(data)>threshold){
                       
                       output <- c(output,cor(data$sulfate, data$nitrate,use="complete.obs"))
                }
                
        }
        output
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
}
