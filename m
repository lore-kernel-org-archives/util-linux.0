Return-Path: util-linux-owner@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:36041 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbaDBRA4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Apr 2014 13:00:56 -0400
Received: from probook.fritz.box ([2001:a60:1088:9701:1ec1:deff:fe91:f51c])
	by smtp.strato.de (RZmta 32.31 AUTH)
	with ESMTPSA id J05b6dq32H0sUWD
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	for <util-linux@vger.kernel.org>;
	Wed, 2 Apr 2014 19:00:54 +0200 (CEST)
Date: Wed, 2 Apr 2014 19:00:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: util-linux@vger.kernel.org
Subject: Re: fdisk partition reorder fails
Message-ID: <20140402170054.GA14987@aepfle.de>
References: <20140402164925.GA13910@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140402164925.GA13910@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 02, Olaf Hering wrote:

> Looks like 2.24.1, included in Factory, is still broken.

The version included in 12.3 was appearently still good:

optiplex:~ # fdisk /dev/sda
Welcome to fdisk (util-linux 2.21.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk /dev/sda: 1500.3 GB, 1500301910016 bytes
255 heads, 63 sectors/track, 182401 cylinders, total 2930277168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0003bcd6

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2097151     1047552   83  Linux
/dev/sda2         2097152     4194303     1048576    7  HPFS/NTFS/exFAT
/dev/sda3         4194304    20971519     8388608   82  Linux swap / Solaris
/dev/sda4        20971520  2930276351  1454652416    f  W95 Ext'd (LBA)
/dev/sda5        20973568    73402367    26214400    7  HPFS/NTFS/exFAT
/dev/sda6        73404416   136318975    31457280    7  HPFS/NTFS/exFAT
/dev/sda7       136321024   199235583    31457280    7  HPFS/NTFS/exFAT
/dev/sda8       199237632   262152191    31457280    7  HPFS/NTFS/exFAT
/dev/sda9       262154240   325068799    31457280    7  HPFS/NTFS/exFAT
/dev/sda10      325070848   702558207   188743680    7  HPFS/NTFS/exFAT
/dev/sda11      899624960  1048561663    74468352   83  Linux
/dev/sda12     1048576000  1258289151   104856576   83  Linux
/dev/sda13     1258291200  1853884415   297796608   83  Linux
/dev/sda14     1853886464  2930276351   538194944   83  Linux
/dev/sda15      702558209   723529472    10485632   83  Linux
/dev/sda16      723529728   744501247    10485760   83  Linux
/dev/sda17      744501249   765471888    10485320   83  Linux
/dev/sda18      765472768   786442239    10484736   83  Linux
/dev/sda19      786442241   807414304    10486032   83  Linux
/dev/sda20      807414306   828385512    10485603+  83  Linux
/dev/sda21      828385514   849356720    10485603+  83  Linux
/dev/sda22      849356800   870328319    10485760   83  Linux

Partition table entries are not in disk order

Command (m for help): x

Expert command (m for help): p

Disk /dev/sda: 255 heads, 63 sectors, 182401 cylinders

Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID
 1 80 117   1    1 138   8 1023       2048    2095104 83
 2 00 138   8 1023 138   8 1023    2097152    2097152 07
 3 00  21  17  261 254  63 1023    4194304   16777216 82
 4 00 254  63 1023 254  63 1023   20971520 2909304832 0f
 5 00 138   8 1023 138   8 1023       2048   52428800 07
 6 00 138   8 1023 138   8 1023        184   62914560 07
 7 00 138   8 1023 138   8 1023        944   62914560 07
 8 00 138   8 1023 138   8 1023        592   62914560 07
 9 00 138   8 1023 138   8 1023        240   62914560 07
10 00 138   8 1023 138   8 1023       1000  377487360 07
11 00 138   8 1023 138   8 1023        280  148936704 83
12 00 138   8 1023 138   8 1023         32  209713152 83
13 00 138   8 1023 138   8 1023        928  595593216 83
14 00 138   8 1023 138   8 1023         96 1076389888 83
15 00 138   8 1023 138   8 1023          1   20971264 83
16 00 138   8 1023 138   8 1023        255   20971520 83
17 00 138   8 1023 138   8 1023          1   20970640 83
18 00 138   8 1023 138   8 1023        879   20969472 83
19 00 138   8 1023 138   8 1023          1   20972064 83
20 00 138   8 1023 138   8 1023          1   20971207 83
21 00 138   8 1023 138   8 1023          1   20971207 83
22 00 138   8 1023 138   8 1023         79   20971520 83

Expert command (m for help): f
Done.

Expert command (m for help): p

Disk /dev/sda: 255 heads, 63 sectors, 182401 cylinders

Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID
 1 80 117   1    1 138   8 1023       2048    2095104 83
 2 00 138   8 1023 138   8 1023    2097152    2097152 07
 3 00  21  17  261 254  63 1023    4194304   16777216 82
 4 00 254  63 1023 254  63 1023   20971520 2909304832 0f
 5 00 138   8 1023 138   8 1023       2048   52428800 07
 6 00 138   8 1023 138   8 1023        184   62914560 07
 7 00 138   8 1023 138   8 1023        944   62914560 07
 8 00 138   8 1023 138   8 1023        592   62914560 07
 9 00 138   8 1023 138   8 1023        240   62914560 07
10 00 138   8 1023 138   8 1023       1000  377487360 07
11 00 138   8 1023 138   8 1023          1   20971264 83
12 00 138   8 1023 138   8 1023        255   20971520 83
13 00 138   8 1023 138   8 1023          1   20970640 83
14 00 138   8 1023 138   8 1023        879   20969472 83
15 00 138   8 1023 138   8 1023          1   20972064 83
16 00 138   8 1023 138   8 1023          1   20971207 83
17 00 138   8 1023 138   8 1023          1   20971207 83
18 00 138   8 1023 138   8 1023         79   20971520 83
19 00 138   8 1023 138   8 1023        280  148936704 83
20 00 138   8 1023 138   8 1023         32  209713152 83
21 00 138   8 1023 138   8 1023        928  595593216 83
22 00 138   8 1023 138   8 1023         96 1076389888 83

Expert command (m for help): r

Command (m for help): p

Disk /dev/sda: 1500.3 GB, 1500301910016 bytes
255 heads, 63 sectors/track, 182401 cylinders, total 2930277168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0003bcd6

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2097151     1047552   83  Linux
/dev/sda2         2097152     4194303     1048576    7  HPFS/NTFS/exFAT
/dev/sda3         4194304    20971519     8388608   82  Linux swap / Solaris
/dev/sda4        20971520  2930276351  1454652416    f  W95 Ext'd (LBA)
/dev/sda5        20973568    73402367    26214400    7  HPFS/NTFS/exFAT
/dev/sda6        73404416   136318975    31457280    7  HPFS/NTFS/exFAT
/dev/sda7       136321024   199235583    31457280    7  HPFS/NTFS/exFAT
/dev/sda8       199237632   262152191    31457280    7  HPFS/NTFS/exFAT
/dev/sda9       262154240   325068799    31457280    7  HPFS/NTFS/exFAT
/dev/sda10      325070848   702558207   188743680    7  HPFS/NTFS/exFAT
/dev/sda11      702558209   723529472    10485632   83  Linux
/dev/sda12      723529728   744501247    10485760   83  Linux
/dev/sda13      744501249   765471888    10485320   83  Linux
/dev/sda14      765472768   786442239    10484736   83  Linux
/dev/sda15      786442241   807414304    10486032   83  Linux
/dev/sda16      807414306   828385512    10485603+  83  Linux
/dev/sda17      828385514   849356720    10485603+  83  Linux
/dev/sda18      849356800   870328319    10485760   83  Linux
/dev/sda19      899624960  1048561663    74468352   83  Linux
/dev/sda20     1048576000  1258289151   104856576   83  Linux
/dev/sda21     1258291200  1853884415   297796608   83  Linux
/dev/sda22     1853886464  2930276351   538194944   83  Linux

Command (m for help): q

optiplex:~ # 


Olaf
