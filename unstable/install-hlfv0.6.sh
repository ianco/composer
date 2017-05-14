(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� w<Y �[o�0�yx�� �21�BJѸ)	l}�B�Gnr.-���g��U�6M�O"�s�v��96�om�[��!j�\���@J��bw��w�$I�"J"�@��n�+Pl�b����R$#� P������5�J�H�}O�f�"D$�
� \䮨�${ ���`�q��FDx0W[����ctZu��4�z@P��c::�I�L@Ԯ`�%�K-�!/���\�EG�D��(��.�F�g��O��n�ʠ��2ڶ���r&ZjO�Z�B�M�B-��l"��y[�ٚy��l�oVڟ��1W����i��>(��׏k=����|6�����O� �I{��n�FHo�A��p8����T�݁r��|~4���8�G�B+0gv3g5<��ߪk6BS�u����L���c����QX܉����ޝ<���~������m3��L�P�@-t
@�#`]<�F�2�K$��(3[Y��3ݟ��l���ܭ�{viK_�k(�K�l��<�,������|��*�g���P�� ~� �Z��!+��͜��AaU�)�f��Ђ��<�E�~�\�*lZ�LxwL�M�����⸈
�3�[�[���$��E�<�C�-�l�l:aq�}78����B���$��>i�����C�1���%4��xU����8�#�)� ,����[��$ϙ���\�3�yS�M��i!���Q�->|A�z��ǧ����p8���p8���p8���p8���'T$<� (  