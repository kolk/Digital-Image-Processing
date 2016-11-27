function chain = getChain(points)
   p = points(1,:);
   chain = ones(size(points,1),1).*-1;
   for i = 2: size(points, 1)
      if points(i,1) > p(1) && points(i,2) > p(2)
          chain(i-1) = 1;
      elseif points(i,1) > p(1) && points(i,2) == p(2)
          chain(i-1) = 2;
      elseif points(i,1) > p(1) && points(i,2) < p(2)
          chain(i-1) = 3;
      elseif points(i,1) == p(1) && points(i,2) < p(2)
          chain(i-1) = 4;
      elseif points(i,1) < p(1) && points(i,2) < p(2)
          chain(i-1) = 5;
      elseif points(i,1) < p(1) && points(i,2) == p(2)
          chain(i-1) = 6;
      elseif points(i,1) < p(1) && points(i,2) > p(2)
          chain(i-1) = 7;
      elseif points(i,1) > p(1) && points(i,2) == p(2)
          chain(i-1) = 0;
      end
   end
   chain = chain(chain > -1);
end