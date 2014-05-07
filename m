Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51369 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752AbaEGOb4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 May 2014 10:31:56 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MV5hN-1WLDTr2J13-00YRP1 for
 <util-linux@vger.kernel.org>; Wed, 07 May 2014 16:31:54 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: last: please review -F and --time-format
Date: Wed, 7 May 2014 16:31:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405071631.53729.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

IMO -F and --time-format=xxx need some review/cleanup regarding
logout times "still running" and "gone - no logout".

Is there any reason why -F and --time-format=full
look different? --time-format=notime looks ugly too.

See the all the cases here: 
------------
for opt in -F --time-format=full --time-format=iso --time-format=short --time-format=notime; do
    echo "### $opt ###"
    ./last  -f ../tests/ts/last/wtmp.LE  $opt  | grep "running\| no logout"
done

### -F ###
torvalds linux        hobby            Mon Aug 26 02:57:08 1991   gone - no logout
reboot   system boot  system-name      Wed Aug 28 20:00:00 2013   still running
### --time-format=full ###
torvalds linux        hobby            Mon Aug 26 02:57:08 1991    gone                    - no logout
reboot   system boot  system-name      Wed Aug 28 20:00:00 2013   still                    running
### --time-format=iso ###
torvalds linux        hobby            1991-08-26T02:57:08+0200   gone - no logout
reboot   system boot  system-name      2013-08-28T20:00:00+0200   still running
### --time-format=short ###
torvalds linux        hobby            Mon Aug 26 02:57    gone - no logout
reboot   system boot  system-name      Wed Aug 28 20:00   still running
### --time-format=notime ###
torvalds linux        hobby              - no logout
reboot   system boot  system-name        running
------------


cu,
Rudi
