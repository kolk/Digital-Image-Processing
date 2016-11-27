function histEq(l)
   %l = imread('face.png');
   
   l = 1.0 * l;
   p = prob(l);
   tr = cmf(p);
   %print tr;
   s = round(7*tr);
   %print s
   his = findHist(s,l);
   disp(his);
end
 

function his = findHist(s,l)
   his = zeros(length(l),1);
   dic = containers.Map('KeyType','double','ValueType', 'any');
   pixSum = sum(l);
   for i = 1:length(s)
      if isKey(dic, s(i))
         %t = dic[s[i]];
         dic(s(i)) = [dic(s(i)) i];
      else
         dic(s(i)) = [i];
      end
   end
   
   kys = cell2mat(keys(dic));
   for j = 1:length(kys)
      indi = dic(kys(j));
      his(kys(j)) = sum(l(indi))/pixSum; 
   end
   
end

function p = prob(l)
   p = zeros(length(l),1);
   p = l/sum(l);
   %{
   s = sum(l);
   for i = 1:length(l)
      p(i) = l(i)/s;
   end
   %}
end

function c = cmf(l)
   c = zeros(length(l),1);
   s = l(1);
   c(1) = l(1);
   for i = 2:length(l)
       s = s + l(i);
       c(i) = s;
      end
end