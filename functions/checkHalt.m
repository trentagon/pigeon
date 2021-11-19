function running = checkHalt(sv,in)

running = 1;
if sv.t > in.t_end
    running = 0;
end

return