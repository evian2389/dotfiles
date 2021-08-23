set -x

ARG1=\'s
ARG2=g\'

find -name "*.$1" -exec sed -i -e "${ARG1}/${2}/${3}/${ARG2}" {} +

