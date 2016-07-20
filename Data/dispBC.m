function dispBC()
%{
This function displays header information for the fields contained in the
bathyduck 1D boundary condition data file. This is especially useful for
finding fields of interest to load using the getBC function. It also gives
info about the size of the fields when subselecting a time slice to load.
%}

url='http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/FRF-ocean_waves_awac04_201510.nc';
ncdisp(url)

end