clear
clc
close all
A = [1 0 0 1 0 0 ; 1 1 0 0 0 1; 1 0 0 1 0 0 ; 1 0 1 0 1 0 ; 1 0 0 1 0 0; 1 1 0 0 0 1];
[Au,ia,ic] = unique(A, 'rows', 'stable')
Counts = accumarray(ic, 1);
Out = [Counts Au]
