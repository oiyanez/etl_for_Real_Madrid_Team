import os
import boto3
import psycopg2

def load_file(file_name, bucket_name, redshift_credentials):
    # Upload the file to S3
    s3_client = boto3.client('s3')
    s3_key = f'teams/{file_name}'

    try:
        s3_client.upload_file(
            Filename=f'./csv_files/{file_name}',
            Bucket=bucket_name,
            Key=s3_key
        )
        print(f'Cargar el archivo a s3: {s3_key}')
    except Exception as e:
        print(f"Error al cargar el archivo a S3: {str(e)}")
        return

    # Connect to Redshift
    with psycopg2.connect(**redshift_credentials) as redshift_connection:
        with redshift_connection.cursor() as redshift_cursor:
            table_name = file_name.split('.')[0]
            
            # Aquí deberías tener la declaración CREATE TABLE adecuada
            create_table_statement = f'''                            
            CREATE TABLE IF NOT EXISTS real_madrid 
            (
            jugador VARCHAR(255),
            equipo VARCHAR(255),
            posicion VARCHAR(255),
            valor_actual_mercado float,
            fecha_de_contratacion VARCHAR(255),
            expiracion_de_contrato VARCHAR(255));
            '''
            redshift_cursor.execute(create_table_statement)
            print(f'Table created or already exists: {table_name}')
            
            
            sentence = f'''COPY public.{table_name} FROM 's3://{bucket_name}/{s3_key}'
                CREDENTIALS 'aws_access_key_id={os.environ.get('AWS_ACCESS_KEY_ID')};aws_secret_access_key={os.environ.get('AWS_SECRET_ACCESS_KEY')}' 
                csv delimiter '|' REGION 'sa-east-1' IGNOREHEADER 1 '''



            try:
                # Execute the COPY command in Redshift
                redshift_cursor.execute(sentence)
                redshift_connection.commit()
                print(f'Successfully loaded data into Redshift table: {table_name}')
            except Exception as e:
                print(f"Error loading data into Redshift table {table_name}: {str(e)}")

# Define your Redshift and S3 credentials
redshift_credentials = {
    'dbname': os.environ.get('REDSHIFT_DATABASE'),
    'user': os.environ.get('REDSHIFT_USER'),
    'password': os.environ.get('REDSHIFT_PASSWORD'),
    'host': os.environ.get('REDSHIFT_HOST'),
    'port': 5439
}
s3_credentials = {
    'aws_access_key_id': os.environ.get('AWS_ACCESS_KEY_ID'),
    'aws_secret_access_key': os.environ.get('AWS_SECRET_ACCESS_KEY'),
}

# Example: Load a file named 'Real_Madrid.csv' into Redshift bucket 'etl-teams'
load_file('real_madrid.csv', 'etl-teams', redshift_credentials)
