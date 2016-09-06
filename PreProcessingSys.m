function PreProcessingSys(L,Simulation,d)

fid = fopen('PreProcessedSys.m','w');

NAgen  = size(L,1);

Counter = 1;
for RowCounter=1:NAgen
    
    if Simulation == 0
        
        fprintf(fid, 'x%s = sdpvar(1);\n', num2str(RowCounter));
        
    else
        
        fprintf(fid, 'x%s = input(%s);\n', num2str(RowCounter),num2str(Counter));
        Counter = Counter + 1;
        
    end
    
end

fprintf(fid, '\n');

for RowCounter=1:NAgen
    
    if Simulation == 0
        
        fprintf(fid, 'y%s = sdpvar(1);\n', num2str(RowCounter));
        
    else
        
        fprintf(fid, 'y%s = input(%s);\n', num2str(RowCounter),num2str(Counter));
        Counter = Counter + 1;
        
    end
    
end

fprintf(fid, '\n');
Counter = 1;
for RowCounter=1:NAgen
    
    if Simulation == 0
        
        fprintf(fid, 'u%s = sdpvar(1);\n', num2str(RowCounter));
        
    else
        
        fprintf(fid, 'u%s = u(%s);\n', num2str(RowCounter),num2str(RowCounter));
        
    end
    
end

if Simulation == 0
    
    fprintf(fid, 'u = [');
    
    for RowCounter=1:NAgen
        
        if RowCounter < NAgen
            
            fprintf(fid, 'u%s; ', num2str(RowCounter));
            
        else
            
            fprintf(fid, 'u%s]; ', num2str(RowCounter));
            
        end
        
    end
    
    fprintf(fid, '\n\n');
    
    for RowCounter=1:NAgen
        
        fprintf(fid, 'q%s = [x%s;y%s];\n', num2str(RowCounter), num2str(RowCounter), num2str(RowCounter));
        
    end
    
    fprintf(fid, '\n');
    fprintf(fid, 'q = [');
    
    
    for RowCounter=1:NAgen
        
        if RowCounter < NAgen
            
            fprintf(fid, 'q%s; ', num2str(RowCounter));
            
        else
            
            fprintf(fid, 'q%s];\n ', num2str(RowCounter));
            
        end
        
    end
    
end

fprintf(fid, '\n');

for RowCounter=1:NAgen
    
    fprintf(fid, 'x%sdot = -x%s - x%s^3 + y%s^2 -%f*(', num2str(RowCounter),num2str(RowCounter),num2str(RowCounter),num2str(RowCounter),d);
    
    for ColumnCounter = 1:NAgen
        
        if L(RowCounter,ColumnCounter) < 0
            
            fprintf(fid, '%s*x%s^3', num2str(L(RowCounter,ColumnCounter)),num2str(ColumnCounter));
            
        else
            
            fprintf(fid, '+%s*x%s^3', num2str(L(RowCounter,ColumnCounter)),num2str(ColumnCounter));
            
        end
        
        if ColumnCounter == NAgen
            
            fprintf(fid, ');\n');
            
        else
            
            fprintf(fid, ' ');
            
        end
        
        
    end
    
end

fprintf(fid, '\n');

for RowCounter=1:NAgen
    
    fprintf(fid, 'y%sdot = u%s;\n', num2str(RowCounter),num2str(RowCounter));
    
end

fprintf(fid, '\n');

if Simulation == 0
    
    for RowCounter=1:NAgen
        
        fprintf(fid, 'f%s = [x%sdot;y%sdot];\n', num2str(RowCounter),num2str(RowCounter),num2str(RowCounter));
        
    end
    
    fprintf(fid, 'f = [');
    
    for RowCounter=1:NAgen
        
        if RowCounter < NAgen
            
            fprintf(fid, 'f%s; ', num2str(RowCounter));
            
        else
            
            fprintf(fid, 'f%s]; ', num2str(RowCounter));
            
        end
        
    end
    
    fprintf(fid, '\n\n');
    
    for RowCounter = 1:NAgen
        
        for ColumnCounter = 1:NAgen
            
            if RowCounter == 1 
                
                if ColumnCounter <= 2
                    
                    fprintf(fid, 'A%s%s = jacobian(f%s,q%s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            elseif RowCounter == NAgen 
                
                if ColumnCounter >= NAgen - 1
                    
                    fprintf(fid, 'A%s%s = jacobian(f%s,q%s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            else
                
                if ColumnCounter <= RowCounter + 1 && ColumnCounter >= RowCounter - 1
                    
                    fprintf(fid, 'A%s%s = jacobian(f%s,q%s);\n', num2str(RowCounter),num2str(ColumnCounter),num2str(RowCounter),num2str(ColumnCounter));
                    
                end
                
            end
            
        end
        
        fprintf(fid, 'B%s  = jacobian(f%s,u%s);\n\n', num2str(RowCounter),num2str(RowCounter),num2str(RowCounter));
        
    end
    
else
    
    fprintf(fid, 'xdot = [');
    
    for RowCounter=1:NAgen
        
        if RowCounter < NAgen
            
            fprintf(fid, 'x%sdot; ', num2str(RowCounter));
            
        else
            
            fprintf(fid, 'x%sdot];\n ', num2str(RowCounter));
            
        end
        
    end
    
    fprintf(fid, 'ydot = [');
    
    for RowCounter=1:NAgen
        
        if RowCounter < NAgen
            
            fprintf(fid, 'y%sdot; ', num2str(RowCounter));
            
        else
            
            fprintf(fid, 'y%sdot];\n ', num2str(RowCounter));
            
        end
        
    end
    
end

fclose(fid);

end