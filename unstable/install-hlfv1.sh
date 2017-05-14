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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� w<Y �]Ys�Jγ~5/����o�Jմ6 ����)�v6!!~��/ql[7��/��[�V����9ݸ�>Y�Wn��!��S��i�xEiyx��G
�I+ʡ8F�_j��4�16��Nk�/���N��˽����H����4��Ӄ�����CF���ٕ�K�k�MAe \,!p��x���ީ.�?Z\+������W\������O���/�$�����q�2.�?U���_��k�?�xv���'=�(`� ����Z�{��X@P���/��'�������g�^����c�?��.��.�y��S6�6J�4JS�C6�,BQ>B:>���`��x�(��M�Yc���Q��O�"^��8�>��xq��������:��Zy�j=]6�!�ڢuʃ���Me�w٤�0	���
V�ׂ���ikA�*̄Բ�O�4q��W��B���f<�-�x�X��I�	ܑ�㹉�S�z�B4�Y��|��,=�N�R7��@��4}������@�e����E/�P׾}�N�U����;�7�/�ۋ�K�O�?w�a�aT��W
>J�wWǯ׉=x�+�%p��'�J�����uC�d�P���_������� �9ʚ���d���̐�Ys)n[D� m.W�����4̸PѲ�5K05�!�-sp�x@"�)m�2{8޺�X�8T8���u�IY�!kH��:s�� �|�D�݆�p��~|w�z\��P��-ƣVύܝ�#H0D\�\9^���H0�"Mޫ����Ď��L�4��x :t�94��:q���[{(���\C0��)�p#ica���1���8?n�.�B~�A�'�xh���Tn�pJ�۟i��B�ӗ�B"N�U1"�6o��b�IdJ؍�i�v�k���2uN�em
h�	���\2T�p;ByWZj�����՝)�̵����y
 ���	����&E��@���~��hp�~�n���L�>�\G�/��:]dL�A����~�bd�T��M�6�7#Q�o�+��P��Hq���@^�N�2�'1�E]��YF�y���g|���v.��r���6��(^������Y�r,�Y��i6�uه�fó��w��r�K�?��o����?�W�_
>H��ҟ� ��?���1��+�/��8+�߉��_j�a�l���j�����y·�܎��a���D�Џ�B�~Ĩo'T�CR���8(�X\L$�H+�앙{��H�?�������J�gF�D���d�{'ZL��%p�k�9jXC"ԗ������ۻ|��,�{��c��"�s1����V���( ͽ���K���2��]�թ� �����&́�l���9�zKӔ3#gh�ˋ,�?�|^ o�Jf��rB�=<�!�|-�t��������L^��B>J$��O��� ׁ��C�(��3�f&$���	I4��������5�/����&�f,O`@�Ϲ)��3��%��j���Ur(q��C�����%���o`���?IRU�G)������������2P����_���=����1���?��x��e������?��W
���*����?�St��(Fxe���	p�d��CД�4�2��:F������8�^��w������(��*�*��\�÷{�`?�hR��Ñ�z���:�%���# �����2�^��Y��l�V0#&㆜4M��2��[��a=���j�K�9��n��vdA{0���m-��v���
��%H��,e{V�?��/��ό����K�G�����J���j��Z�������w��ό����|���H�O�������L���7s(<:��P�қ�]���O������.:6K}o������`p�{�i2����U�>2�2<�$�zo*ͭ��3A>���w���]����t�x�͆�f2o�z�D���D!P����]�p�r'�v�ó@�D�s�m�ȸ��IG�^p ?G��qڠy��)�8�9@z��%�i�V��ڹN�M�|��6Y��.,����μ����´gOM��@�$0A����^��Y��h1	�x�� ��i��=SZ������SMG��v"FR>�9K����Ё��yW 'Y1�������)~I�b�IW�_>D���S�)��������?�x��w�wv9��E�����%���_����(Q�)��������\����P�-��E
R����K��cl���u(�p�v};@�Y�s��q�%Pa�a� !}�Y���*���C�<��I������*vE~�Z������֘.�m��H�n�����'/H���?�@�N�ǝ:���А�Q����2�F�	�6v�3�J������nO@�C���V>����3�pN)9��ͪ��w����S�O?�����&���r��O|�)��X���������|�R�\�8AW��W�o?��.�?��T%�2��i;����Q������a�����?�j��|��gi�.�#s�&]ƦX
u1
�\�e1���F�u� p�`���m�a}�Z(*e����9��T��|>.X��"�?��%�a��bB��vK#�Ļ���Jw�4Q?_����Є/�u�]q��ϥ��
t��yԘ	��G�׌�8��C0�2�v;Dت�L�5Aut_$�=��z���n|��i;�;�?����R�;�(I<�����_���O���/��P&ʐ�+�J�O�	�~�����>�y���;b%�A�*�5��`�����������п?�c�ㆹ�T��bxT�޺��p#s���s�֣s������{4��i�M;�L(�|�#�S:E_̋W�m;��~�ILW���	�<�-b�Zt3����������P�YOԉ5�����j�s�ފ���{�A3Q�t�r֓��ex�L>2�{Ġ��Ām���N��-���x�����E�ք~ހNQe�6�xN�/ݩ�۝�ؐ�����^��.uF$��m�,O7|���0�v�X���M�i����o�)��足��Y�9ˌ������mo9�� ����N�ʹ��\��ފ��>�[Z��>\d��BiH�?/�#��K���a��xe�������������9�����[���j�?��I�Tu�{)x�������q`�~��[����NS!�����������䙡��7P���F���>���my�@M�wM��-���� �B$�vr��))�ci�J�hl�F�˶���[��SS�m�ߚ���&4�T6c��ij]�r�
��H��'}5i�v��@���q6��K����>@ k��#'P#�ڬ��]z�M��J̳F��K]��O�\;|�՞ق%w��Z�o�~�;�F�&����-T�}z�x�ϳ���#��K�A\n�#4U�������'��T�J�g��j����2�������V���Z�������j�����]��\l�cV��s9�\��[w�?F!t�Y
*������?�����z��S��[)���	��i;�N1E����>�Q$�8�N�8��(��S��庘�0^��[���b�������J����2%[N��95c����ͩ����-y#��E������Ds:n+� �Jx����^�����ط�ܱ
#Jj�9��uG� ?��]K'��@9���C�ި��Q��м���^x�;��b�GI����h������G������� ��_�~�Z�k�/�/��t;u��+T��6r��j������>�Ӆ��tl'��W��u�P7q�^#�ȕ�H&������2��s%��UM�.�7<�iv��]���^�᧧�8]g��������?�:�7����Z6�]�����Q;�w]�*R����t��^}��о/t�+���������jWN�������$��v坺`/6������KNu��ַ����ڞ.��fiGŨp훻ʠ����p;r���}eX��hluuA�E��!��:7�o�*]���!ק?/�>^�r_�fW�v��kE%��|��^�q������\;�BϾ��.:J�'ߺ��/��d�y�,�3�^����o���:b��"{�e�%o�� ��O[/��������i]��Wv7�~Z���<���ϫ��g￟��c��?m�\T{X����q:�.�o�~��q���8��8K]8��'�PY?�n��v��&>ф�D����8���S�n�>*������Gd��S7�X=��^��2)���7|�*��q$�C4dE��o��y\VGƷu��'�J1g�^WV�o��t���I��᭝��f	�-����D?���q[L������6�u����r9<.��r�˘�b���u�K��tݺ�t�ֽoJ�=]�n�֞v��5!&��4�o4B�@�D?)����A	$D�`����ж�z��휝����&�t��y���������y��Kz��t�<��|��J�4D�
�g�d��ERx6��v��F��L,u)���ønm��1�ѓ�5Y^�ޗ�t�[]�o���4+�cѥ� l�^ ��k@�>��g6�	9���	�B>�h���*K�����������pM4'�F��~� 4��23i�aX�����h�mf�f��xdɈ���麩k�v�X%�;��8�^=<�ߡ$A��Mf�#�m![H�)Z��O�KP/U�*ۑ���fqθ	G�胉�f��8���)��GBdV���q]�����7k��>���b�4d�:*�·*�%�C�n���h�,GS䃍��0�}��� mN�����L6��pz48���)�� ��w��#?��i>���:��b'�/*;T�Ӫ,��{0�����Tk5�.s�렖N�B�A7��SIG�x��~�����~�-�3z:��Ƌ��oFB�����]ѯ}��ߕ��^�
�qjM1�0��]� �,��>��k�㒻��e��1�3�t=l��3����E]䢹@٢F)�<(��v�f� �r�	�Z]�����L^�����smo_��먒�lAU8n�0��~�\��{�=8����'i�L~�I��2�1p^�c�N�qPo�4cosb�1��U~��k�\:>u�os�X����K���kQQ�or�v!�۵�9�eWg��ɩ|E���c�����G��+�G��|�M6���[u���Ǎ���~�A�����?�~���C��vb�����~��W;��T���H��wy\� �� `�m/�������<`��m_���G�WA<��<��=<� '�:{{��;�����n�f�{������.=���A�P�
�V����	�¡:���`7.�x�Ə΁���g�A�>=qn���O@jrƦ����=��0G`$�Sܼ^���9�EE.Ag�]���l��0&���su�0�O!|0�x緙��(,��]>Pm9"���aw,Qv���f���vs�BD��N��f���)˽\�~�J�tA=L���0�b�z����d3����3�mN6t��$�g���9
SJt��0Q��i:KG;��zL���Dx�,�g��fQe��A_�46SE�E&�R�S�g�=J�7JyQ��a9Um	1!����`!�m�TU�X6�^/��8���K!
�ri?r��)�	k3am&�*LX��v;d ,�/�6�����]��[j�p��=5WB֭j��	��E�5%q�A@y��+�d��v�l��z\��Z���M�	��<�
m��h�H()f�d���	�8��̰ä�t93-8�v$�b-���u����X����&L�~`���X%�ZVj�X+��ҟ�E�,VӼx-�%�(i��i�yϰ�U��D�No'�B.H����!�c"�n���+K���e��3ʲ��l�R ˥�o�S)~w���i&?�|�G�E?õ��|�C�Y�կ��a��j�M*X�S����|*WVU�ܦ�,8#�y�(Q:\HUEӴ��㙖��S�=�3�K�%�z��GӾ!Ih]>F�
��i�:������MZ�SY�j1�݉*h?��U*���\�)�{�j��%�>WU\xo�%�HY�������WP�(����[.�����!A�M�I�3Ԛ����J��[xa�a5�+Ѣ���k'��r��7��FbRM 9�>����dM�"�Ue$�&�Jg���)��٥�6a�Ї�-V��i��
0�d�^�_k,!�ل��!��- ��lHꎏH���ʵ	)��ꞡ�&E�A	�'Y�4����i�l��f�l��l�p#�9QpMA��yU�>�[�ڀ֠S��kWl����~��2y��� 9t�ۧ�Cg��_9]U�g+��j�.p]�ms�b�;m�F�p���jj�������研,ոtt#��8^i�4:�q'���Ҽ�Vk�WZ���zB?÷���(<��'5Y�-'��lM�6䡛��k`�ᇟC�>��úM��9g�3kWA`�{��%s�4(�yV�U̖C�@����Z�c�<��,��i��S\V��ypW�/F>sz2+f�z�@t�'ʪ��L���Y ��f$}�Q��Y����GnE^�^��Z����[��R`���R���C�h����� �"	���t�B��[��g+;��p�Z�H����Ƣ���h�0�%k8z�`�K{�8�NZLOc�YS��{��A$�D��)��M��/�^��F,�J�.�▖h��D+�DCH�C�^��B"(t���-��G�s���I�+���a�B�S�C#{0p ���-&��|���q�����xH7��51"�%j���A�!�no<�`UW��b4SˑL#�a0җ����}B�.P����������a҂]�+[�k�a��9��!�	�}��-Q�")D�#��u�LS &�Co9���>.մb/��}��i�m�q�Ǻv�����t��)�������i�����ݡ�:��z贕a��xX�=,��[�O���޿���,�I��D�VD2S��Q
W�H���\���1/;���@����3�<X��u��E��$&���
��"�͚����x[��3��0jSI`bJى�!2(��d
G�vJ�Ԗ+�0���������]&�xY�p#�QnO���0<�}Q8]JI���t0do,6�!
��<��.�	�[j���g��;(EyrHԕ(t��+}t���<@�^�,���G��U����I^�È�2	��g�~����%��;��&&�$ι �ɒ�V��r�n���]�z��]�ye�6�8�ߌ�Pޏ{6ⷒS�>�S6�c���J!��l��f�.Ķ�(�����i���Q�h���tÔ��8��W**�i������>�%~���%A�oAlB�Ne����;��J�r�\�h��<NB'�+,7�"��]�>��7�Z/��i�~�[/=������Ky��C����fW���|7;ͦ�Տ�����w��>����,	87�>���<Hw_z�������oz��7���'������'����Sq�8��[׮4�~�W&W�t��FӉjh:�F��W~�c�|��;���8=�x�7���=	�N��(���)j�N��Yj�6�Ӧv��N�&`�lj������H�i��iS;mj����>����yh��e�^8�r��%���,4�6y�m!t�����o=fb褏���!��<��5�E���n��3�?�ڟRm��m�q�g<�#p$���d��zmj��2O˞3cG[�93�� {Z�=g�6�8.Ü�#��=���13��q��Z[����G���y\�R�����v����d��m�/��q  