% This script file prompts the user to enter the radius of a sphere and
% calculates the volume of that sphere.
% Then, it usees the display command to print the volume.
format short
disp('This script calculates the volume of sphere.');
r = input('Enter the radius of a sphere. ');
volume =  4/3*pi*r^3;
disp(volume);