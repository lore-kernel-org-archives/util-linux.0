Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:37348 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759092Ab1IJKZH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 10 Sep 2011 06:25:07 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8AAP5R1030661
	for <util-linux@vger.kernel.org>; Sat, 10 Sep 2011 10:25:05 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p8AAP5rF2531424
	for <util-linux@vger.kernel.org>; Sat, 10 Sep 2011 11:25:05 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p8AAP4it023766
	for <util-linux@vger.kernel.org>; Sat, 10 Sep 2011 04:25:05 -0600
Date: Sat, 10 Sep 2011 12:25:04 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] various lscpu changes
Message-ID: <20110910102504.GA2598@osiris.boeblingen.de.ibm.com>
References: <20110906005251.497675140@de.ibm.com>
 <20110909220757.GD4204@nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110909220757.GD4204@nb>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 10, 2011 at 12:07:57AM +0200, Karel Zak wrote:
> On Tue, Sep 06, 2011 at 02:52:51AM +0200, Heiko Carstens wrote:
> > another set of patches against lscpu. Since you didn't have chance to push
> > out your local tree to kernel.org yet, I simply based them on my old lscpu
> > branch which you applied on your local tree:
> 
>  Merged (available on github) with some minor changes. I have also
>  added --online to disable by default enabled --all for -e.

I wouldn't say that were minor changes :) But the result looks much better
than my code. Thanks!

However I'd like to see one change if you don't object: printing just "N" or
"Y" instead of "No" and "Yes" in the human readable output looks a bit ugly
to me:

[root@r35lp37 sys-utils]# ./lscpu -e
CPU BOOK SOCKET CORE ONLINE CONFIGURED POLARIZATION ADDRESS
0   0    0      0    Y      Y          horizontal   0
1   -    -      -    N      N          -            1
2   0    0      2    Y      Y          horizontal   2
3   0    1      3    Y      Y          horizontal   3
4   0    1      4    Y      Y          horizontal   4
5   0    1      5    Y      Y          horizontal   5
6   0    1      6    Y      Y          horizontal   6
7   0    2      7    Y      Y          horizontal   7
8   0    2      8    Y      Y          horizontal   8
9   0    2      9    Y      Y          horizontal   9
10  0    3      10   Y      Y          horizontal   10
11  0    3      11   Y      Y          horizontal   11
12  0    3      12   Y      Y          horizontal   12
13  0    4      13   Y      Y          horizontal   13
14  0    4      14   Y      Y          horizontal   14
15  0    5      15   Y      Y          horizontal   15
16  1    6      16   Y      Y          horizontal   16
17  1    7      17   Y      Y          horizontal   17
18  1    7      18   Y      Y          horizontal   18
19  1    7      19   Y      Y          horizontal   19

Comparing that to the long form:

CPU BOOK SOCKET CORE ONLINE CONFIGURED POLARIZATION ADDRESS
0   0    0      0    Yes    Yes        horizontal   0
1   -    -      -    No     No         -            1
2   0    0      1    Yes    Yes        horizontal   2
3   0    1      2    Yes    Yes        horizontal   3
4   0    1      3    Yes    Yes        horizontal   4
5   0    1      4    Yes    Yes        horizontal   5
6   0    1      5    Yes    Yes        horizontal   6
7   0    2      6    Yes    Yes        horizontal   7
8   0    2      7    Yes    Yes        horizontal   8
9   0    2      8    Yes    Yes        horizontal   9
10  0    3      9    Yes    Yes        horizontal   10
11  0    3      10   Yes    Yes        horizontal   11
12  0    3      11   Yes    Yes        horizontal   12
13  0    4      12   Yes    Yes        horizontal   13
14  0    4      13   Yes    Yes        horizontal   14
15  0    5      14   Yes    Yes        horizontal   15
16  1    6      15   Yes    Yes        horizontal   16
17  1    7      16   Yes    Yes        horizontal   17
18  1    7      17   Yes    Yes        horizontal   18
19  1    7      18   Yes    Yes        horizontal   19

I'd prefer the long form. What do you think?

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 601c872..6a37bb3 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -995,13 +995,24 @@ get_cell_data(struct lscpu_desc *desc, int cpu, int col,
 			snprintf(buf, bufsz, "%d", desc->addresses[cpu]);
 		break;
 	case COL_CONFIGURED:
-		if (desc->configured)
+		if (!desc->configured)
+			break;
+		if (mod->mode == OUTPUT_PARSABLE)
 			snprintf(buf, bufsz,
 				 desc->configured[cpu] ? _("Y") : _("N"));
+		else
+			snprintf(buf, bufsz,
+				 desc->configured[cpu] ? _("Yes") : _("No"));
 		break;
 	case COL_ONLINE:
-		if (desc->online)
-			snprintf(buf, bufsz, is_cpu_online(desc, cpu) ? _("Y") : _("N"));
+		if (!desc->online)
+			break;
+		if (mod->mode == OUTPUT_PARSABLE)
+			snprintf(buf, bufsz,
+				 is_cpu_online(desc, cpu) ? _("Y") : _("N"));
+		else
+			snprintf(buf, bufsz,
+				 is_cpu_online(desc, cpu) ? _("Yes") : _("No"));
 		break;
 	}
 	return buf;
