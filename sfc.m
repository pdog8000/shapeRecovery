function [normalMap,lightMatrix] = sfc(sphere,object)

sphere = sphere/max(abs(sphere(:)));
object = object/max(abs(object(:)));
%Format the inputs
object(isnan(object)) = 0;
sphere(isnan(sphere)) = 0;
om = size(object,1);
on = size(object,2);
sm = size(sphere,1);
sphereN = genSphereNormals(sm/2);
object = reshape(object,om*on,3);
sphere = reshape(sphere,sm*sm,3);
sphereN = reshape(sphereN,sm*sm,3);

%Estimate linear transform between normals and RGB values
lightMatrix = sphereN\sphere;

%Use estimated transform to recover object normals
normalMap = object/lightMatrix;
%Transpose matrix to match up with original formulae
lightMatrix = lightMatrix';

%Format output
normalMap = reshape(normalMap,om,on,3);
%normalMap = normaliseVectorImage(normalMap);

%figure;
%imshow(normalMap);
end