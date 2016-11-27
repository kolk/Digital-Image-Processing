function nChain = normalizeChain(chain)
  
   mini = sum(10.^(length(chain)-1:-1:0) .* chain');
   ind = 1;
   for i = 2:length(chain)
      rot = [chain(i:length(chain)); chain(1:i -1)];
     
      number = sum(10.^(length(chain)-1:-1:0) .* rot');
      if number < mini
          mini = number;
          ind = i;
      end
   end
   n = mini;
   nChain = [chain(ind:length(chain)); chain(1:ind -1)];%ones(length(chain),1)*-1;

end