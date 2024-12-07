git clone https://github.com/robin113x/Burp-Suite.git
cd Burp-Suite
curr_path=$(pwd)
curl -s https://portswigger.net/burp/releases#professional > Version.txt
cat Version.txt | grep  'professional-community' | head -n 1 > latest_version.txt
LATEST_VERSION=$(cat latest_version.txt | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{1,2\}')

echo "Downloading Burp Suite Pro version $LATEST_VERSION..."
curl -L -o curr_path/burp-suite-$LATEST_VERSION.jar "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$LATEST_VERSION&type=Jar"

echo "Download complete: burp-suite-$LATEST_VERSION.jar"

java -jar  keygen.jar > /dev/null



#Install latest java version if not prent 
if [ java --version !=21.a.c ]
then 
	curl https://builds.openlogic.com/downloadJDK/openlogic-openjdk/22.0.2+9/openlogic-openjdk-22.0.2+9-linux-x64-deb.deb -o openjdk.deb
	sudo dpkg -i openjdk.deb
else
	echo "Good to go"
fi 
#run in new ternmianl
"/usr/lib/jvm/java-21-openjdk-amd64/bin/java" "--add-opens=java.desktop/javax.swing=ALL-UNNAMED" "--add-opens=java.base/java.lang=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED" "-javaagent:burploader.jar" "-noverify" "-jar" "curr_path/burp-suite-$LATEST_VERSION.jar"& > /dev/null