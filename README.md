# Universis_Task
This is the DevOps Challenge


STEP2:

For this step i have created a python script and i have used 6 reference file, first i have used string slicing to extract the data (date, year, month, filetype, etc..).
after that i have created a target path (the structure is according mentioned in the discription) and  target dir using makedirs, than after used shutil.copy to copy files from source to destination. I have also handled error using try and except, and initially i have declred a variable count =0 for source folder and after copying it 
incremented and using len checked length for source and target for moved and removed file. I have attached script.py for step2.

Below are the images
Source dir:
![image](https://user-images.githubusercontent.com/47473997/235584918-18fc5cd3-7a8d-4b06-ad55-ec82d146d252.png)

Target dir:
![image](https://user-images.githubusercontent.com/47473997/235585191-e113ca23-9503-4fba-ba46-d546b59fdef7.png)

