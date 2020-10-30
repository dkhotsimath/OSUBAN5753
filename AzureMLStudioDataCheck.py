# The script MUST contain a function named azureml_main,
# which is the entry point for this module.
# Imports up here can be used to

# The entry point function must have two input arguments:
#   Param<dataframe1>: a pandas.DataFrame
#   Param<dataframe2>: a pandas.DataFrame
# def azureml_main(dataframe1 = None, dataframe2 = None):
def azureml_main(dataframe1):
# Execution logic goes here

    import pandas as pd
    import datetime

    from matplotlib import pyplot as plt
    
    #plt.scatter(dataframe1.Price, dataframe1.Price)
    #img_file = "scatter.png"
    #plt.savefig(img_file)
    
    fig, ax = plt.subplots()
    ax.plot_date(pd.to_datetime(dataframe1['PriceDateString']), dataframe1.Price, '-')

    img_file2 = "trend.png"
    plt.savefig(img_file2)
    
    # Return value must be of a sequence of pandas.DataFrame
    # For example:
    #   -  Single return value: return dataframe1,
    #   -  Two return values: return dataframe1, dataframe2
    return dataframe1,
