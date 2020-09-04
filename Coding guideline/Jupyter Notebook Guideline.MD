# Jupyter Notebook Guideline

 1. **Structure** : Give your notebook required proper structure with a title, Header, TOC etc.
 2. **Use classes & Module** :  Refactor your code, push your code to modules and classes. 

> Notebooks should not contain complex logic, and they should be easy to follow. Instead of having all the code in the notebook, extract them into modules/ classes (code behind) and use those modules from your notebook.

 3. **Variable** : As Jupyter Notebooks enable working with data in a cell-by-cell structure, so use new variables preferably. 

> Be cautious, variables of big dataset, preferably should move to your
> classes/ modules. Having big dataset memory multiple times is resource
> intensive.

 4. **Data caching** : Since each cells data is automatically is available for future reference without the need of running the whole script again, use that to avoid multiple trips to DB/ repo.
Add local caching mode (based on JSON) where the raw data is stored locally to prevent having to download all data every-time the full notebook needs to be executed (would be good to see if GitHub has a way to only fetch data after a particular date, so that we can then implement a 'only download changes since last execution' mode)
 5. **Common code** : All common code should move to Helper classes, as a good coding practice. Notebook should have minimum code until we get to the Visualisations section. E.g. On the Pie chart cell, create method to create pie charts, with only dynamic parameters being passed. 
Likewise, *pd.set_options('...')* code should be in method *configure_pandas()*. 

 6. **Do not keep sensitive information** : Any sensitive information like API keys, token, username/ password etc. should never be added to a Notebook. 
 7. **Graphs** :  The data should be in a Node/Edge format  (VisJS is a good API to use https://visjs.github.io/vis-network/docs/network/ which looks like https://visjs.github.io/vis-network/examples/). This data should be stored in JSON and then loaded by the Graph visualisation APIs/code.
 8. **Coding standard** : Respective coding guideline (e.g. Python coding guideline) should be followed. 

