function L=LinearLaplacianGenerator(NAgents)

L = zeros(NAgents,NAgents);

for RowCounter = 1:NAgents
    
    for ColumnCounter = 1:NAgents
        
        if ColumnCounter >= RowCounter
            
            if ColumnCounter == RowCounter
                
                if RowCounter == 1 || RowCounter == NAgents
                    
                    L(RowCounter,ColumnCounter) = 1/2;
                    
                else
                    
                    L(RowCounter,ColumnCounter) = 1;
                    
                end
                
            elseif ColumnCounter == RowCounter - 1 || ColumnCounter == RowCounter + 1
                
                L(RowCounter,ColumnCounter) = -1;
                
            end
            
        end
        
    end
    
end

L = L + transpose(L);


end