function pigeon_print(out)

fprintf("Model runtime = %.2f seconds\n", out.runtime_total);

%Print Present Mars values
fprintf("\n---Present Mars---\n");
fprintf("pN2  = %.2f-%.2f mbar\n",0.12,0.13);
fprintf("d15N = %.2f +/- %.f per mil\n",572,82);

%Print the model results
fprintf("---Model Results---\n")
fprintf("pN2(start) = %.2f mbar\n",out.pressures(1));
fprintf("pN2(end)   = %.2f mbar\n",out.pressures(end));
fprintf("d15N(end)  = %.2f per mil\n\n",out.deltas_pm(end));

%fprintf("------------------------------------------------------------------");

return