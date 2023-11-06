from sagemaker.model import Model


def deploy_model(
    model_name: str, pycaret_ecr_name: str, instance_type: str,
    endpoint_name, role: str
) -> None:
    model_file = f"s3://{model_name}-model/final_best_model.tar.gz"
    model = Model(
        image_uri=f"135544376709.dkr.ecr.eu-west-1.amazonaws.com/\
        {pycaret_ecr_name}:latest",  # The ECR image you pushed
        model_data=model_file,  # Location of your serialized model
        role=role,
    )

    predictor = model.deploy(
        initial_instance_count=1,
        instance_type=instance_type,
        endpoint_name=endpoint_name,
    )
    print(predictor)
