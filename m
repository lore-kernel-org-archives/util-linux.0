Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34810 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbIGS3k (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Sep 2015 14:29:40 -0400
Received: by wicfx3 with SMTP id fx3so96428778wic.1
        for <util-linux@vger.kernel.org>; Mon, 07 Sep 2015 11:29:39 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:58:84f1:c9aa:1590:4fd6:5b1f? ([2a01:5c0:58:84f1:c9aa:1590:4fd6:5b1f])
        by smtp.googlemail.com with ESMTPSA id v6sm701148wjf.13.2015.09.07.11.29.37
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 11:29:38 -0700 (PDT)
To: util-linux@vger.kernel.org
From: Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: [Regression] util-linux-2.27: zramctl lists same info for all devices
 (DATA COMPR TOTAL)
Message-ID: <55EDD791.30606@googlemail.com>
Date: Mon, 7 Sep 2015 20:29:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear util-linux developers, 

after updating to util-linux 2.7, zramctl output is broken if one just lists all devices: 

# zramctl 
NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lz4             2G   4K   64B    4K       4 [SWAP]
/dev/zram1 lz4            12G   4K   64B    4K       4 /var/tmp/portage
/dev/zram2 lz4            12G   4K   64B    4K       4 /var/tmp/olifre

Compare this to:
# zramctl /dev/zram0
NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lz4             2G   4K   64B    4K       4 [SWAP]

# zramctl /dev/zram1
NAME       ALGORITHM DISKSIZE  DATA  COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram1 lz4            12G  4,6M 202,5K  476K       4 /var/tmp/portage

i.e. it seems that in "listing" mode (no device given) it always shows the same information in DATA, COMPR and TOTAL columns for all devices. 
This is with kernel 4.2, /sys/block/zram1/mm_stat etc. behave correctly. 

I guess it is related to commit 5388c862607ec4f25f3e7ad23ab858b696bde1a1 . 
It parses mmstat and fills in z->mm_stat and z->mm_stat_probed only the first time get_mm_stat is called. Since the codes reuses the very same zram-struct "z" afterwards and z->mm_stat is never freed (and z->mm_stat_probed is never reset), only the first device is every queried. 

This was working fine with util-linux 2.6 which did not use this function yet. 

Cheers, 
Oliver

PS: I am not subscribed to util-linux, so please include me in replies. 
