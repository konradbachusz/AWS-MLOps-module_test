import tarfile
import boto3


def save_model_to_s3(
    trained_model_name: str, bucket_name: str, final_model: object
) -> None:
    """This saves the pkl model is s3 bucket

    Args:
        trained_model_name (str): name of the file you are trying to save in s3
        bucket_name (str): name of the bucket you are saving the file
        final_model (object): the ml model you are trying to save
    """    

    with tarfile.open("final_best_model.tar.gz", "w:gz") as tar:
        tar.add(f"{trained_model_name}.pkl")

    s3 = boto3.client("s3")
    s3.upload_file(
        f"{trained_model_name}.tar.gz", bucket_name,
        f"{trained_model_name}.tar.gz")
