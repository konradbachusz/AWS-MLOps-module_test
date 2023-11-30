from sagemaker.model import Model


def deploy_model(
    model_name: str, pycaret_ecr_name: str, instance_type: str, endpoint_name,
    role: str, region_name: str
) -> None:

    """This script deploys the sagemaker endpoint using the tar.gz file
    saved in s3.

    Args:
        model_name (str): The name of the bucket and name of the file in s3
        pycaret_ecr_name (str): The name of the ECR image
        instance_type (str): The sagemaker instance type you want to deploy
        endpoint_name (_type_): What you will like to call the endpoint.
        role (str): Your execution role
    """
    model_file = f"s3://{model_name}-model/{model_name}.tar.gz"
    model = Model(
        image_uri=(
            f"135544376709.dkr.ecr.{region_name}.amazonaws.com/"
            f"{pycaret_ecr_name}:latest"
        ),  # The ECR image you pushed
        model_data=model_file,  # Location of your serialized model
        role=role,
    )
    model.deploy(
        initial_instance_count=1,
        instance_type=instance_type,
        endpoint_name=endpoint_name,
    )
