#! /bin/bash

TMP=/tmp/rubfonts
USERTEXMF=`kpsewhich -var-value TEXMFVAR`
FONTFOLDER=

echo "Erzeuge Verzeichnis ${USERTEXMF}"
mkdir ${USERTEXMF}

usage()
{
cat << EOF
usage: $0 options

Dieses Skript macht die TrueType-Dateien \n der Schriften Rub Scala und Rub Flama \n unter LaTeX verfügbar.
Die Schriften werden unter ${USERTEXMF} installiert.

OPTIONS:
   -h      Show this message
   -f      Ordner mit den Schriftdateien
EOF
}

files_rename()
{
    mkdir /tmp/rubfonts
    for file in "$FONTFOLDER"/*.ttf
    do
       ttf=`basename "${file}"`
       echo "Benenne Datei ${ttf} um."
       cp -T "${file}" "${TMP}"/"${ttf// /_}"       
    done
}

make_maps()
{
echo "Erstelle map Dateien."
cd "$TMP"
## Rub Skala
# Oldstyle Numbers 
otftotfm -a  --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"  -fkern -fliga   --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ_Bold.ttf"  "frsmb8t"
otftotfm   --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"  -fkern -fliga --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ.ttf"  "frsmr8t"
 
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"   -fkern -fliga --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ_Bold_Italic.ttf"  "frsmbi8t"
otftotfm   --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"  -fkern -fliga --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ_Italic.ttf"  "frsmri8t"
 
#small caps
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"  -fkern -fliga -fsmcp  --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ.ttf"  "frsmrsc8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalamz"  -fkern -fliga -fsmcp   --encoding="texnansx"  --map-file="rubscalamz.map" "RUB_Scala_MZ_Bold.ttf"  "frsmbsc8t"
 
# Newstyle Numbers
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"     -fkern -fliga  --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ_Bold.ttf"  "frstb8t"
otftotfm   --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"     -fkern -fliga  --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ.ttf"  "frstr8t"

otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"     -fkern -fliga -fsmcp   --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ_Bold.ttf"  "frstbsc8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"     -fkern -fliga -fsmcp    --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ.ttf"  "frstrsc8t"

otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"   -fkern -fliga  --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ_Bold_Italic.ttf"  "frstbi8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubscalatz"     -fkern -fliga  --encoding="texnansx"  --map-file="rubscalatz.map" "RUB_Scala_TZ_Italic.ttf"  "frstri8t"

## RubFlama
otftotfm -a  --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"   -fkern -fliga --encoding="texnansx"  --map-file="rubflama.map" "RubFlama-Bold.ttf"  "frfb8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"   -fkern  -fliga  --encoding="texnansx"  --map-file="rubflama.map" "RubFlama-BoldItalic.ttf"  "frfbi8t"
otftotfm -a  --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"    -fkern  -fliga --encoding="texnansx"  --map-file="rubflama.map" "RubFlama-Italic.ttf"  "frfri8t"
otftotfm -a  --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"   -fkern  -fliga --encoding="texnansx"  --map-file="rubflama.map" "RubFlama-Regular.ttf"  "frfr8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"   -fkern  -fliga --encoding="texnansx"  --map-file="rubflama.map" "RubFlamaLight-Italic.ttf"  "frfli8t"
otftotfm  -a --no-type1 --no-updmap --vendor="RUB" --typeface="rubflama"   -fkern  -fliga --encoding="texnansx"  --map-file="rubflama.map" "RubFlamaLight-Regular.ttf"  "frfl8t"

echo "Kopiere Map-Dateien nach ${USERTEXMF}"
mkdir -p ${USERTEXMF}/fonts/map/dvips/rub/
cp *.map ${USERTEXMF}/fonts/map/dvips/rub/
}

do_udpmap()
{
    texhash ${USERTEXMF}
    updmap
    updmap --enable Map=rubscalatz.map
    updmap --enable Map=rubscalamz.map
    updmap --enable Map=rubflama.map
}

get_sty() 
{
    mkdir -p ${USERTEXMF}/tex/latex/rub-fonts
    wget https://raw.github.com/sjewo/rub-fonts/master/tex/ly1frf.fd -O ${USERTEXMF}/tex/latex/rub-fonts/ly1frf.fd
    wget https://raw.github.com/sjewo/rub-fonts/master/tex/ly1frsm.fd -O ${USERTEXMF}/tex/latex/rub-fonts/ly1frsm.fd
    wget https://raw.github.com/sjewo/rub-fonts/master/tex/ly1frst.fd -O ${USERTEXMF}/tex/latex/rub-fonts/ly1frst.fd
    wget https://raw.github.com/sjewo/rub-fonts/master/tex/rubflama.sty -O ${USERTEXMF}/tex/latex/rub-fonts/rubflama.sty
    wget https://raw.github.com/sjewo/rub-fonts/master/tex/rubscala.sty -O ${USERTEXMF}/tex/latex/rub-fonts/rubscala.sty
}


while getopts “hf:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         f)
             FONTFOLDER=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $FONTFOLDER ]]
then
     usage
     exit 1
fi

# Schriftdateien suchen
if  [  -e "$FONTFOLDER/RubFlama-BoldItalic.ttf" ] && 
    [ -e "$FONTFOLDER/RubFlama-Bold.ttf" ] &&
    [ -e "$FONTFOLDER/RubFlama-Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RubFlamaLight-Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RubFlamaLight-Regular.ttf" ] &&
    [ -e "$FONTFOLDER/RubFlama-Regular.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala MZ Bold Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala MZ Bold.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala MZ Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala MZ.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala TZ Bold Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala TZ Bold.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala TZ Italic.ttf" ] &&
    [ -e "$FONTFOLDER/RUB Scala TZ.ttf" ]
then 
    echo "Schriftinstallation startet."
    files_rename
    make_maps
    get_sty
    texhash ${USERTEXMF}
    do_udpmap
    exit 1
else
    echo "Es wurden nicht alle Schriftdateien gefunden."
    exit 0
fi
