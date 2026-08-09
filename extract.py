from datasets import load_dataset
import dlt

ds = load_dataset("hugginglearners/netflix-shows")
df = ds["train"].to_pandas()

print("df size ", df.shape)

# setting up dlt pipeline
pipeline = dlt.pipeline(
    pipeline_name="netflix_etl",
    destination="duckdb",
    dataset_name="bronze"
)

load_info = pipeline.run(df,table_name="netflix_titles")

print(load_info)