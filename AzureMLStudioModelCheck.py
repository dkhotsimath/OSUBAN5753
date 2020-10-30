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
    
    plt.scatter(dataframe1.Price, dataframe1['Scored Label Mean'])
    img_file1 = "ActualvsPred.png"
    plt.savefig(img_file1)
    
    fig, ax = plt.subplots()
    ax.plot_date(pd.to_datetime(dataframe1['PriceDateString']), dataframe1.Price, 'b-', label='Actual Price')
    ax.plot_date(pd.to_datetime(dataframe1['PriceDateString']), dataframe1['Scored Label Mean'], 'g-', label='Predicted Price')
    legend = ax.legend(loc='upper center', shadow=True, fontsize='large')
    plt.show()
    img_file3 = "trendCompare.png"
    plt.savefig(img_file3)
    
    # Return value must be of a sequence of pandas.DataFrame
    # For example:
    #   -  Single return value: return dataframe1,
    #   -  Two return values: return dataframe1, dataframe2
    return dataframe1,
