# This is Emil Jurga's personal repository for his various personal functions in R. 

Some brief notes on the usage:

## ```save_figtex```

Use this function in conjunction with a latex document that is compiled seperately!
This function prints out the specied figure as a pdf/png, and also creates a latex 
file that can be input into the master documnet with an \include{} statement. 

Set the following code in the preamble of the master tex document in order to specify 
the directory where these tex files live. Here, the PATH is the path, relative to the 
main tex document, that points to the root of the project directory where the Rscripts 
are ultimately run from. 

```
\makeatletter 
	\def\input@path{{PATH}} 
\makeatother 
```

