%finds index of border relative to border point
function cIndex = findIndex(diff)
  indx = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];
  flag = 0;
  cIndex = 0;
  for i = 1:8
     if indx(i,1) == diff(1) && indx(i,2) == diff(2)
       flag = 1;
       cIndex = i;
     end
    if flag ~= 0
       break;
    end
end


end


 