# Terraform - Azure Virtual Machine Deployment

Este proyecto crea una infraestructura básica en Azure utilizando Terraform, la cual incluye una máquina virtual con acceso RDP, una red virtual, subred, IP pública y un grupo de seguridad de red.

## Requisitos

- [Terraform](https://www.terraform.io/downloads) instalado en tu máquina.
- Una suscripción de Azure.
- Autenticación configurada con Azure CLI o mediante un `service principal`.

## Archivos principales

### `main.tf`

Define los recursos de Azure necesarios:

- **Provider**: Configura el proveedor de Azure para la suscripción.
- **Resource Group**: Un grupo de recursos donde se alojarán todos los componentes.
- **Virtual Network**: La red virtual que define el espacio de direcciones.
- **Subnet**: La subred dentro de la red virtual.
- **Network Security Group (NSG)**: Define las reglas de seguridad para permitir el tráfico SSH (puerto 22) y RDP (puerto 3389).
- **Network Interface**: La interfaz de red de la máquina virtual.
- **Public IP**: Una dirección IP pública con SKU estándar.
- **Windows Virtual Machine**: Una máquina virtual basada en Windows Server 2019 Datacenter.

### `variables.tf`

Define las variables utilizadas en el `main.tf`, tales como:

- ID de suscripción.
- Nombre del grupo de recursos, red virtual, subred, y la interfaz de red.
- Espacios de direcciones IP.

### `output.tf`

Proporciona las salidas de las IDs de algunos de los recursos creados:

- ID de la interfaz de red (NIC).
- ID de la asociación de seguridad entre la NIC y el NSG.

## Uso

1. **Clona el repositorio** en tu máquina local:

   ```bash
   git clone https://github.com/tu-repositorio/terraform-azure-vm.git
   cd terraform-azure-vm
   ```

2. **Inicializa el proyecto de Terraform para descargar los proveedores necesarios**:
    ```bash
    terraform init
    ```

3. **Revisa el plan de ejecución para asegurarte de que los recursos que se van a crear son correctos**:
    ```bash
    terraform plan
    ```
4. **Aplica los cambios para crear la infraestructura en Azure**:
    ```bash
    terraform apply
    ```
5. **Obtención de la Dirección IP Pública: Se obtiene la dirección IP pública de la máquina virtual**:
    ```bash
    terraform output
    ```

# Acceso a la Máquina Virtual
## Conexión RDP (Windows)
1. Abrir el Escritorio remoto.
2. Ingresar la IP pública obtenida.
3. Utilizar las credenciales definidas en el archivo main.tf.
# Conexión SSH (Linux/MacOS)

1. Abrir una terminal.

2. Ejecutar el siguiente comando (reemplazar <public_ip> con la dirección IP pública):
    ```bash
    ssh distrimolta@<public_ip>
    ```
3. Introducir las credenciales de inicio de sesión y listo.

# Conclusión
La implementación de una máquina virtual en Azure utilizando Terraform simplifica significativamente el proceso de provisión y gestión de infraestructura. A través de una configuración declarativa, se puede asegurar que todos los recursos necesarios sean creados de manera coherente y reproducible. Esta metodología no solo facilita el despliegue inicial, sino que también permite un fácil escalado y mantenimiento de los recursos a lo largo del ciclo de vida de la infraestructura. 

# Notas Adicionales
* Las credenciales y valores sensibles deben ser modificados antes de un despliegue en producción.
* La dirección IP pública se ha configurado como estática para mantener su asignación durante reinicios.

## Imágenes

A continuación se muestran algunas imágenes relevantes a la implementación:

![Conexión Exitosa](img/conexionexitosa.png)
![Dirección IP Pública](img/example-public-ip.png)
![Grupo de Recursos](img/example-resourcestf.png)
![Máquina Virtual](img/example-vm.png)
![Prueba RDP](img/prueba-rdp.png)

