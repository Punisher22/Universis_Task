import os
import shutil

#source and target dir 
target = '/vijul/home/dir/vijul-parent'
source = '/home/ec2-user/os'

#First let me show you the files in the source
print(os.listdir(source))

count =0
# Iterate over the files in the source directory
#Currently I have added 6 files for reference

for filename in os.listdir(source):

    # Extract date info used string slicing
    date = filename[6:12]
    year = '20' + date[4:]
    month = date[2:4]
    day = date[:2]

    # Extract the file type code
    ftype = filename[:2]

    # target path based on type and data
    pathoftarget = os.path.join(target, year, month, day, ftype)
    
    # Create target directory if it doesn't exist
    os.makedirs(pathoftarget, exist_ok=True)

    # Copy the file to target dir
    try:
     pathofsource = os.path.join(source, filename)
     shutil.copy2(pathofsource, pathoftarget)

    except IsADirectoryError:
     print("Opps! it's a directory")
    
    count +=1
#verify the length of source
if len(source) == count:
    print("moved")
else:
    print("error")

# Remove the files from target dir
for root, dirs, files in os.walk(target):
    for name in files:
        os.remove(os.path.join(root, name))


# Verified removal of files from target 
if not os.listdir(target):
    print('removed')
else:
    print('ERROR')
