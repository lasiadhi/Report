
function [ vec1_m,vec2_m ] = vec_nz_mod( vec1,vec2 )
%=====================================================
%             DESCRIPTION
% This function will take only non-zero values from vector vec1 and 
% determine the indices of zero vector elements.Then it will extract
% vector elements from vec2 excluding the values at those indices.
%=====================================================
%                INPUT
% This function will take two vectors as input.
% vec1: vector to get nonzero values.
% vec2: vector to be modified depending on zero indices of vec1.
%======================================================
%               OUTPUT
% vec1_m: only the nonzero values of vec1
% vec2_m: vector elements only from desired indices of nonzero values of vec1 
%
% NOTE: output vectors will be of same size only if input vectors are of
% same size.
%======================================================
v1_in= ~vec1;      % indices for zero vector elements of vec1
vec1_m=nonzeros(vec1);   % nonzero vector elements of vec1

vec2(v1_in)=0;           % provide zero in the desired indices in vec2
vec2_m=nonzeros(vec2);   % returns nonzero vector elements of vec2 at desired indices

end

