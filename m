Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:55113 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab3ASAJq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:46 -0500
Received: by mail-we0-f175.google.com with SMTP id z53so1153293wey.34
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/22] tests: add dmesg(1) check
Date: Sat, 19 Jan 2013 00:09:01 +0000
Message-Id: <1358554151-25985-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                   |   1 +
 tests/expected/dmesg/console-levels | 104 +++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/decode         | 105 ++++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/delta          | 105 ++++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/facilities     |  96 +++++++++++++++++++++++++++++++++
 tests/ts/dmesg/console-levels       |  25 +++++++++
 tests/ts/dmesg/decode               |  23 ++++++++
 tests/ts/dmesg/delta                |  23 ++++++++
 tests/ts/dmesg/facilities           |  25 +++++++++
 tests/ts/dmesg/input                | 105 ++++++++++++++++++++++++++++++++++++
 10 files changed, 612 insertions(+)
 create mode 100644 tests/expected/dmesg/console-levels
 create mode 100644 tests/expected/dmesg/decode
 create mode 100644 tests/expected/dmesg/delta
 create mode 100644 tests/expected/dmesg/facilities
 create mode 100755 tests/ts/dmesg/console-levels
 create mode 100755 tests/ts/dmesg/decode
 create mode 100755 tests/ts/dmesg/delta
 create mode 100755 tests/ts/dmesg/facilities
 create mode 100644 tests/ts/dmesg/input

diff --git a/tests/commands.sh b/tests/commands.sh
index f1e20ed..d4f30a3 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -73,3 +73,4 @@ TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
 TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
 TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
+TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
diff --git a/tests/expected/dmesg/console-levels b/tests/expected/dmesg/console-levels
new file mode 100644
index 0000000..48b0a1d
--- /dev/null
+++ b/tests/expected/dmesg/console-levels
@@ -0,0 +1,104 @@
+[    0.000000] example[0]
+[  512.000000] example[8]
+[ 4096.000000] example[16]
+[13824.000000] example[24]
+[32768.000000] example[32]
+[64000.000000] example[40]
+[110592.000000] example[48]
+[175616.000000] example[56]
+[262144.000000] example[64]
+[373248.000000] example[72]
+[512000.000000] example[80]
+[681472.000000] example[88]
+[884736.000000] example[96]
+[    1.000000] example[1]
+[  729.000000] example[9]
+[ 4913.000000] example[17]
+[15625.000000] example[25]
+[35937.000000] example[33]
+[68921.000000] example[41]
+[117649.000000] example[49]
+[185193.000000] example[57]
+[274625.000000] example[65]
+[389017.000000] example[73]
+[531441.000000] example[81]
+[704969.000000] example[89]
+[912673.000000] example[97]
+[    8.000000] example[2]
+[ 1000.000000] example[10]
+[ 5832.000000] example[18]
+[17576.000000] example[26]
+[39304.000000] example[34]
+[74088.000000] example[42]
+[125000.000000] example[50]
+[195112.000000] example[58]
+[287496.000000] example[66]
+[405224.000000] example[74]
+[551368.000000] example[82]
+[729000.000000] example[90]
+[941192.000000] example[98]
+[   27.000000] example[3]
+[ 1331.000000] example[11]
+[ 6859.000000] example[19]
+[19683.000000] example[27]
+[42875.000000] example[35]
+[79507.000000] example[43]
+[132651.000000] example[51]
+[205379.000000] example[59]
+[300763.000000] example[67]
+[421875.000000] example[75]
+[571787.000000] example[83]
+[753571.000000] example[91]
+[970299.000000] example[99]
+[   64.000000] example[4]
+[ 1728.000000] example[12]
+[ 8000.000000] example[20]
+[21952.000000] example[28]
+[46656.000000] example[36]
+[85184.000000] example[44]
+[140608.000000] example[52]
+[216000.000000] example[60]
+[314432.000000] example[68]
+[438976.000000] example[76]
+[592704.000000] example[84]
+[778688.000000] example[92]
+[1000000.000000] example[100]
+[  125.000000] example[5]
+[ 2197.000000] example[13]
+[ 9261.000000] example[21]
+[24389.000000] example[29]
+[50653.000000] example[37]
+[91125.000000] example[45]
+[148877.000000] example[53]
+[226981.000000] example[61]
+[328509.000000] example[69]
+[456533.000000] example[77]
+[614125.000000] example[85]
+[804357.000000] example[93]
+[1030301.000000] example[101]
+[  216.000000] example[6]
+[ 2744.000000] example[14]
+[10648.000000] example[22]
+[27000.000000] example[30]
+[54872.000000] example[38]
+[97336.000000] example[46]
+[157464.000000] example[54]
+[238328.000000] example[62]
+[343000.000000] example[70]
+[474552.000000] example[78]
+[636056.000000] example[86]
+[830584.000000] example[94]
+[1061208.000000] example[102]
+[  343.000000] example[7]
+[ 3375.000000] example[15]
+[12167.000000] example[23]
+[29791.000000] example[31]
+[59319.000000] example[39]
+[103823.000000] example[47]
+[166375.000000] example[55]
+[250047.000000] example[63]
+[357911.000000] example[71]
+[493039.000000] example[79]
+[658503.000000] example[87]
+[857375.000000] example[95]
+[1092727.000000] example[103]
diff --git a/tests/expected/dmesg/decode b/tests/expected/dmesg/decode
new file mode 100644
index 0000000..f3541a6
--- /dev/null
+++ b/tests/expected/dmesg/decode
@@ -0,0 +1,105 @@
+kern  :emerg : [    0.000000] example[0]
+kern  :alert : [    1.000000] example[1]
+kern  :crit  : [    8.000000] example[2]
+kern  :err   : [   27.000000] example[3]
+kern  :warn  : [   64.000000] example[4]
+kern  :notice: [  125.000000] example[5]
+kern  :info  : [  216.000000] example[6]
+kern  :debug : [  343.000000] example[7]
+user  :emerg : [  512.000000] example[8]
+user  :alert : [  729.000000] example[9]
+user  :crit  : [ 1000.000000] example[10]
+user  :err   : [ 1331.000000] example[11]
+user  :warn  : [ 1728.000000] example[12]
+user  :notice: [ 2197.000000] example[13]
+user  :info  : [ 2744.000000] example[14]
+user  :debug : [ 3375.000000] example[15]
+mail  :emerg : [ 4096.000000] example[16]
+mail  :alert : [ 4913.000000] example[17]
+mail  :crit  : [ 5832.000000] example[18]
+mail  :err   : [ 6859.000000] example[19]
+mail  :warn  : [ 8000.000000] example[20]
+mail  :notice: [ 9261.000000] example[21]
+mail  :info  : [10648.000000] example[22]
+mail  :debug : [12167.000000] example[23]
+daemon:emerg : [13824.000000] example[24]
+daemon:alert : [15625.000000] example[25]
+daemon:crit  : [17576.000000] example[26]
+daemon:err   : [19683.000000] example[27]
+daemon:warn  : [21952.000000] example[28]
+daemon:notice: [24389.000000] example[29]
+daemon:info  : [27000.000000] example[30]
+daemon:debug : [29791.000000] example[31]
+auth  :emerg : [32768.000000] example[32]
+auth  :alert : [35937.000000] example[33]
+auth  :crit  : [39304.000000] example[34]
+auth  :err   : [42875.000000] example[35]
+auth  :warn  : [46656.000000] example[36]
+auth  :notice: [50653.000000] example[37]
+auth  :info  : [54872.000000] example[38]
+auth  :debug : [59319.000000] example[39]
+syslog:emerg : [64000.000000] example[40]
+syslog:alert : [68921.000000] example[41]
+syslog:crit  : [74088.000000] example[42]
+syslog:err   : [79507.000000] example[43]
+syslog:warn  : [85184.000000] example[44]
+syslog:notice: [91125.000000] example[45]
+syslog:info  : [97336.000000] example[46]
+syslog:debug : [103823.000000] example[47]
+lpr   :emerg : [110592.000000] example[48]
+lpr   :alert : [117649.000000] example[49]
+lpr   :crit  : [125000.000000] example[50]
+lpr   :err   : [132651.000000] example[51]
+lpr   :warn  : [140608.000000] example[52]
+lpr   :notice: [148877.000000] example[53]
+lpr   :info  : [157464.000000] example[54]
+lpr   :debug : [166375.000000] example[55]
+news  :emerg : [175616.000000] example[56]
+news  :alert : [185193.000000] example[57]
+news  :crit  : [195112.000000] example[58]
+news  :err   : [205379.000000] example[59]
+news  :warn  : [216000.000000] example[60]
+news  :notice: [226981.000000] example[61]
+news  :info  : [238328.000000] example[62]
+news  :debug : [250047.000000] example[63]
+uucp  :emerg : [262144.000000] example[64]
+uucp  :alert : [274625.000000] example[65]
+uucp  :crit  : [287496.000000] example[66]
+uucp  :err   : [300763.000000] example[67]
+uucp  :warn  : [314432.000000] example[68]
+uucp  :notice: [328509.000000] example[69]
+uucp  :info  : [343000.000000] example[70]
+uucp  :debug : [357911.000000] example[71]
+cron  :emerg : [373248.000000] example[72]
+cron  :alert : [389017.000000] example[73]
+cron  :crit  : [405224.000000] example[74]
+cron  :err   : [421875.000000] example[75]
+cron  :warn  : [438976.000000] example[76]
+cron  :notice: [456533.000000] example[77]
+cron  :info  : [474552.000000] example[78]
+cron  :debug : [493039.000000] example[79]
+authpriv:emerg : [512000.000000] example[80]
+authpriv:alert : [531441.000000] example[81]
+authpriv:crit  : [551368.000000] example[82]
+authpriv:err   : [571787.000000] example[83]
+authpriv:warn  : [592704.000000] example[84]
+authpriv:notice: [614125.000000] example[85]
+authpriv:info  : [636056.000000] example[86]
+authpriv:debug : [658503.000000] example[87]
+ftp   :emerg : [681472.000000] example[88]
+ftp   :alert : [704969.000000] example[89]
+ftp   :crit  : [729000.000000] example[90]
+ftp   :err   : [753571.000000] example[91]
+ftp   :warn  : [778688.000000] example[92]
+ftp   :notice: [804357.000000] example[93]
+ftp   :info  : [830584.000000] example[94]
+ftp   :debug : [857375.000000] example[95]
+[884736.000000] example[96]
+[912673.000000] example[97]
+[941192.000000] example[98]
+[970299.000000] example[99]
+[1000000.000000] example[100]
+[1030301.000000] example[101]
+[1061208.000000] example[102]
+[1092727.000000] example[103]
+[1124864.000000] example[104]
diff --git a/tests/expected/dmesg/delta b/tests/expected/dmesg/delta
new file mode 100644
index 0000000..01dfec3
--- /dev/null
+++ b/tests/expected/dmesg/delta
@@ -0,0 +1,105 @@
+[    0.000000 <    0.000000>] example[0]
+[    1.000000 <    0.000000>] example[1]
+[    8.000000 <    7.000000>] example[2]
+[   27.000000 <   19.000000>] example[3]
+[   64.000000 <   37.000000>] example[4]
+[  125.000000 <   61.000000>] example[5]
+[  216.000000 <   91.000000>] example[6]
+[  343.000000 <  127.000000>] example[7]
+[  512.000000 <  169.000000>] example[8]
+[  729.000000 <  217.000000>] example[9]
+[ 1000.000000 <  271.000000>] example[10]
+[ 1331.000000 <  331.000000>] example[11]
+[ 1728.000000 <  397.000000>] example[12]
+[ 2197.000000 <  469.000000>] example[13]
+[ 2744.000000 <  547.000000>] example[14]
+[ 3375.000000 <  631.000000>] example[15]
+[ 4096.000000 <  721.000000>] example[16]
+[ 4913.000000 <  817.000000>] example[17]
+[ 5832.000000 <  919.000000>] example[18]
+[ 6859.000000 < 1027.000000>] example[19]
+[ 8000.000000 < 1141.000000>] example[20]
+[ 9261.000000 < 1261.000000>] example[21]
+[10648.000000 < 1387.000000>] example[22]
+[12167.000000 < 1519.000000>] example[23]
+[13824.000000 < 1657.000000>] example[24]
+[15625.000000 < 1801.000000>] example[25]
+[17576.000000 < 1951.000000>] example[26]
+[19683.000000 < 2107.000000>] example[27]
+[21952.000000 < 2269.000000>] example[28]
+[24389.000000 < 2437.000000>] example[29]
+[27000.000000 < 2611.000000>] example[30]
+[29791.000000 < 2791.000000>] example[31]
+[32768.000000 < 2977.000000>] example[32]
+[35937.000000 < 3169.000000>] example[33]
+[39304.000000 < 3367.000000>] example[34]
+[42875.000000 < 3571.000000>] example[35]
+[46656.000000 < 3781.000000>] example[36]
+[50653.000000 < 3997.000000>] example[37]
+[54872.000000 < 4219.000000>] example[38]
+[59319.000000 < 4447.000000>] example[39]
+[64000.000000 < 4681.000000>] example[40]
+[68921.000000 < 4921.000000>] example[41]
+[74088.000000 < 5167.000000>] example[42]
+[79507.000000 < 5419.000000>] example[43]
+[85184.000000 < 5677.000000>] example[44]
+[91125.000000 < 5941.000000>] example[45]
+[97336.000000 < 6211.000000>] example[46]
+[103823.000000 < 6487.000000>] example[47]
+[110592.000000 < 6769.000000>] example[48]
+[117649.000000 < 7057.000000>] example[49]
+[125000.000000 < 7351.000000>] example[50]
+[132651.000000 < 7651.000000>] example[51]
+[140608.000000 < 7957.000000>] example[52]
+[148877.000000 < 8269.000000>] example[53]
+[157464.000000 < 8587.000000>] example[54]
+[166375.000000 < 8911.000000>] example[55]
+[175616.000000 < 9241.000000>] example[56]
+[185193.000000 < 9577.000000>] example[57]
+[195112.000000 < 9919.000000>] example[58]
+[205379.000000 <10267.000000>] example[59]
+[216000.000000 <10621.000000>] example[60]
+[226981.000000 <10981.000000>] example[61]
+[238328.000000 <11347.000000>] example[62]
+[250047.000000 <11719.000000>] example[63]
+[262144.000000 <12097.000000>] example[64]
+[274625.000000 <12481.000000>] example[65]
+[287496.000000 <12871.000000>] example[66]
+[300763.000000 <13267.000000>] example[67]
+[314432.000000 <13669.000000>] example[68]
+[328509.000000 <14077.000000>] example[69]
+[343000.000000 <14491.000000>] example[70]
+[357911.000000 <14911.000000>] example[71]
+[373248.000000 <15337.000000>] example[72]
+[389017.000000 <15769.000000>] example[73]
+[405224.000000 <16207.000000>] example[74]
+[421875.000000 <16651.000000>] example[75]
+[438976.000000 <17101.000000>] example[76]
+[456533.000000 <17557.000000>] example[77]
+[474552.000000 <18019.000000>] example[78]
+[493039.000000 <18487.000000>] example[79]
+[512000.000000 <18961.000000>] example[80]
+[531441.000000 <19441.000000>] example[81]
+[551368.000000 <19927.000000>] example[82]
+[571787.000000 <20419.000000>] example[83]
+[592704.000000 <20917.000000>] example[84]
+[614125.000000 <21421.000000>] example[85]
+[636056.000000 <21931.000000>] example[86]
+[658503.000000 <22447.000000>] example[87]
+[681472.000000 <22969.000000>] example[88]
+[704969.000000 <23497.000000>] example[89]
+[729000.000000 <24031.000000>] example[90]
+[753571.000000 <24571.000000>] example[91]
+[778688.000000 <25117.000000>] example[92]
+[804357.000000 <25669.000000>] example[93]
+[830584.000000 <26227.000000>] example[94]
+[857375.000000 <26791.000000>] example[95]
+[884736.000000 <27361.000000>] example[96]
+[912673.000000 <27937.000000>] example[97]
+[941192.000000 <28519.000000>] example[98]
+[970299.000000 <29107.000000>] example[99]
+[1000000.000000 <29701.000000>] example[100]
+[1030301.000000 <30301.000000>] example[101]
+[1061208.000000 <30907.000000>] example[102]
+[1092727.000000 <31519.000000>] example[103]
+[1124864.000000 <32137.000000>] example[104]
diff --git a/tests/expected/dmesg/facilities b/tests/expected/dmesg/facilities
new file mode 100644
index 0000000..9733e56
--- /dev/null
+++ b/tests/expected/dmesg/facilities
@@ -0,0 +1,96 @@
+[    0.000000] example[0]
+[    1.000000] example[1]
+[    8.000000] example[2]
+[   27.000000] example[3]
+[   64.000000] example[4]
+[  125.000000] example[5]
+[  216.000000] example[6]
+[  343.000000] example[7]
+[  512.000000] example[8]
+[  729.000000] example[9]
+[ 1000.000000] example[10]
+[ 1331.000000] example[11]
+[ 1728.000000] example[12]
+[ 2197.000000] example[13]
+[ 2744.000000] example[14]
+[ 3375.000000] example[15]
+[ 4096.000000] example[16]
+[ 4913.000000] example[17]
+[ 5832.000000] example[18]
+[ 6859.000000] example[19]
+[ 8000.000000] example[20]
+[ 9261.000000] example[21]
+[10648.000000] example[22]
+[12167.000000] example[23]
+[13824.000000] example[24]
+[15625.000000] example[25]
+[17576.000000] example[26]
+[19683.000000] example[27]
+[21952.000000] example[28]
+[24389.000000] example[29]
+[27000.000000] example[30]
+[29791.000000] example[31]
+[32768.000000] example[32]
+[35937.000000] example[33]
+[39304.000000] example[34]
+[42875.000000] example[35]
+[46656.000000] example[36]
+[50653.000000] example[37]
+[54872.000000] example[38]
+[59319.000000] example[39]
+[64000.000000] example[40]
+[68921.000000] example[41]
+[74088.000000] example[42]
+[79507.000000] example[43]
+[85184.000000] example[44]
+[91125.000000] example[45]
+[97336.000000] example[46]
+[103823.000000] example[47]
+[110592.000000] example[48]
+[117649.000000] example[49]
+[125000.000000] example[50]
+[132651.000000] example[51]
+[140608.000000] example[52]
+[148877.000000] example[53]
+[157464.000000] example[54]
+[166375.000000] example[55]
+[175616.000000] example[56]
+[185193.000000] example[57]
+[195112.000000] example[58]
+[205379.000000] example[59]
+[216000.000000] example[60]
+[226981.000000] example[61]
+[238328.000000] example[62]
+[250047.000000] example[63]
+[262144.000000] example[64]
+[274625.000000] example[65]
+[287496.000000] example[66]
+[300763.000000] example[67]
+[314432.000000] example[68]
+[328509.000000] example[69]
+[343000.000000] example[70]
+[357911.000000] example[71]
+[373248.000000] example[72]
+[389017.000000] example[73]
+[405224.000000] example[74]
+[421875.000000] example[75]
+[438976.000000] example[76]
+[456533.000000] example[77]
+[474552.000000] example[78]
+[493039.000000] example[79]
+[512000.000000] example[80]
+[531441.000000] example[81]
+[551368.000000] example[82]
+[571787.000000] example[83]
+[592704.000000] example[84]
+[614125.000000] example[85]
+[636056.000000] example[86]
+[658503.000000] example[87]
+[681472.000000] example[88]
+[704969.000000] example[89]
+[729000.000000] example[90]
+[753571.000000] example[91]
+[778688.000000] example[92]
+[804357.000000] example[93]
+[830584.000000] example[94]
+[857375.000000] example[95]
diff --git a/tests/ts/dmesg/console-levels b/tests/ts/dmesg/console-levels
new file mode 100755
index 0000000..b87d3fd
--- /dev/null
+++ b/tests/ts/dmesg/console-levels
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="levels"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+for I in {-1..8}; do
+	$TS_CMD_DMESG -F $TS_SELF/input -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/decode b/tests/ts/dmesg/decode
new file mode 100755
index 0000000..a1afa6f
--- /dev/null
+++ b/tests/ts/dmesg/decode
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="decode"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_DMESG -x -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/delta b/tests/ts/dmesg/delta
new file mode 100755
index 0000000..774ffb1
--- /dev/null
+++ b/tests/ts/dmesg/delta
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="delta"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_DMESG -d -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/facilities b/tests/ts/dmesg/facilities
new file mode 100755
index 0000000..1b7b0d4
--- /dev/null
+++ b/tests/ts/dmesg/facilities
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="facilities"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+for I in {-1..12}; do
+	$TS_CMD_DMESG -F $TS_SELF/input -f $I >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/input b/tests/ts/dmesg/input
new file mode 100644
index 0000000..98307df
--- /dev/null
+++ b/tests/ts/dmesg/input
@@ -0,0 +1,105 @@
+<0>[    0.000000] example[0]
+<1>[    1.000000] example[1]
+<2>[    8.000000] example[2]
+<3>[   27.000000] example[3]
+<4>[   64.000000] example[4]
+<5>[  125.000000] example[5]
+<6>[  216.000000] example[6]
+<7>[  343.000000] example[7]
+<8>[  512.000000] example[8]
+<9>[  729.000000] example[9]
+<10>[ 1000.000000] example[10]
+<11>[ 1331.000000] example[11]
+<12>[ 1728.000000] example[12]
+<13>[ 2197.000000] example[13]
+<14>[ 2744.000000] example[14]
+<15>[ 3375.000000] example[15]
+<16>[ 4096.000000] example[16]
+<17>[ 4913.000000] example[17]
+<18>[ 5832.000000] example[18]
+<19>[ 6859.000000] example[19]
+<20>[ 8000.000000] example[20]
+<21>[ 9261.000000] example[21]
+<22>[10648.000000] example[22]
+<23>[12167.000000] example[23]
+<24>[13824.000000] example[24]
+<25>[15625.000000] example[25]
+<26>[17576.000000] example[26]
+<27>[19683.000000] example[27]
+<28>[21952.000000] example[28]
+<29>[24389.000000] example[29]
+<30>[27000.000000] example[30]
+<31>[29791.000000] example[31]
+<32>[32768.000000] example[32]
+<33>[35937.000000] example[33]
+<34>[39304.000000] example[34]
+<35>[42875.000000] example[35]
+<36>[46656.000000] example[36]
+<37>[50653.000000] example[37]
+<38>[54872.000000] example[38]
+<39>[59319.000000] example[39]
+<40>[64000.000000] example[40]
+<41>[68921.000000] example[41]
+<42>[74088.000000] example[42]
+<43>[79507.000000] example[43]
+<44>[85184.000000] example[44]
+<45>[91125.000000] example[45]
+<46>[97336.000000] example[46]
+<47>[103823.000000] example[47]
+<48>[110592.000000] example[48]
+<49>[117649.000000] example[49]
+<50>[125000.000000] example[50]
+<51>[132651.000000] example[51]
+<52>[140608.000000] example[52]
+<53>[148877.000000] example[53]
+<54>[157464.000000] example[54]
+<55>[166375.000000] example[55]
+<56>[175616.000000] example[56]
+<57>[185193.000000] example[57]
+<58>[195112.000000] example[58]
+<59>[205379.000000] example[59]
+<60>[216000.000000] example[60]
+<61>[226981.000000] example[61]
+<62>[238328.000000] example[62]
+<63>[250047.000000] example[63]
+<64>[262144.000000] example[64]
+<65>[274625.000000] example[65]
+<66>[287496.000000] example[66]
+<67>[300763.000000] example[67]
+<68>[314432.000000] example[68]
+<69>[328509.000000] example[69]
+<70>[343000.000000] example[70]
+<71>[357911.000000] example[71]
+<72>[373248.000000] example[72]
+<73>[389017.000000] example[73]
+<74>[405224.000000] example[74]
+<75>[421875.000000] example[75]
+<76>[438976.000000] example[76]
+<77>[456533.000000] example[77]
+<78>[474552.000000] example[78]
+<79>[493039.000000] example[79]
+<80>[512000.000000] example[80]
+<81>[531441.000000] example[81]
+<82>[551368.000000] example[82]
+<83>[571787.000000] example[83]
+<84>[592704.000000] example[84]
+<85>[614125.000000] example[85]
+<86>[636056.000000] example[86]
+<87>[658503.000000] example[87]
+<88>[681472.000000] example[88]
+<89>[704969.000000] example[89]
+<90>[729000.000000] example[90]
+<91>[753571.000000] example[91]
+<92>[778688.000000] example[92]
+<93>[804357.000000] example[93]
+<94>[830584.000000] example[94]
+<95>[857375.000000] example[95]
+<96>[884736.000000] example[96]
+<97>[912673.000000] example[97]
+<98>[941192.000000] example[98]
+<99>[970299.000000] example[99]
+<100>[1000000.000000] example[100]
+<101>[1030301.000000] example[101]
+<102>[1061208.000000] example[102]
+<103>[1092727.000000] example[103]
+<104>[1124864.000000] example[104]
-- 
1.8.1.1

