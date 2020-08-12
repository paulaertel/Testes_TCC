using DataFrames, StatsPlots, RDatasets, CSV
# pgfplotsx()
#pyplot()

function pairplot(df::DataFrame,grouper::Symbol)
    colsymbols = setdiff(Symbol.(names(df)),[grouper])
    colnames = String.(colsymbols)
    num_cols = length(colnames)
    plt = []
    # Diagonal
    for (indexcol,col) in enumerate(colsymbols)
        for (indexrow,coldiff) in enumerate(colsymbols)
            x_label = (indexcol == num_cols ? colnames[indexrow] : "")
            y_label = (indexrow == 1 ? colnames[indexcol] : "")
            if col == coldiff

                push!(plt,@df df histogram(cols(col),xlabel=x_label,ylabel=y_label))
            else
                push!(plt,@df df scatter(cols(col),cols(coldiff),group=cols(grouper),xlabel=x_label,ylabel=y_label))
            end    
        end
    end
    plt = plot(reshape(plt,num_cols,num_cols) ...,layout=grid(num_cols,num_cols),leg=false,size =(900,900))
    return plt
end

##
#iris = dataset("datasets", "iris")
#plt = pairplot(iris,:Species)   
## 
#savefig(plt,"PairPlotIris.pdf")
##
#col_headers = ["id" ,"diagnosis" ,"radius_mean" ,"texture_mean" ,"perimeter_mean" ,"area_mean" ,"smoothness_mean" ,"compactness_mean" ,"concavity_mean" ,"concave points_mean" ,"symmetry_mean" ,"fractal_dimension_mean" ,"radius_se" ,"texture_se" ,"perimeter_se" ,"area_se" ,"smoothness_se" ,"compactness_se" ,"concavity_se" ,"concave points_se" ,"symmetry_se" ,"fractal_dimension_se" ,"radius_worst" ,"texture_worst" ,"perimeter_worst" ,"area_worst" ,"smoothness_worst" ,"compactness_worst" ,"concavity_worst" ,"concave points_worst" ,"symmetry_worst" ,"fractal_dimension_worst"]
#cancer_df = CSV.read("cancer_data.csv", DataFrame,header = col_headers)
#select!(cancer_df,Not(:id))
#plt1 = pairplot(select(cancer_df,1:6),:diagnosis)
##
#savefig(plt1,"PairPlotCancer.pdf")