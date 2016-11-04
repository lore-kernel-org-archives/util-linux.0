Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754822AbcKDMKO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 4 Nov 2016 08:10:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA4C8msE026307
        for <util-linux@vger.kernel.org>; Fri, 4 Nov 2016 08:10:14 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26gn98srkk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Fri, 04 Nov 2016 08:10:13 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 4 Nov 2016 12:10:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1E61917D8056
        for <util-linux@vger.kernel.org>; Fri,  4 Nov 2016 12:12:27 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uA4CA8b940828972
        for <util-linux@vger.kernel.org>; Fri, 4 Nov 2016 12:10:08 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uA4CA7sa007887
        for <util-linux@vger.kernel.org>; Fri, 4 Nov 2016 08:10:08 -0400
Date: Fri, 4 Nov 2016 13:10:06 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 2/4] lsmem: new tool
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-3-heiko.carstens@de.ibm.com>
 <20161103120059.75nflzf5wvepafzu@ws.net.home>
 <20161103161948.GA12234@osiris>
 <20161104103931.dvhnyuyjhb4ykyw7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161104103931.dvhnyuyjhb4ykyw7@ws.net.home>
Message-Id: <20161104121006.GA4088@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 04, 2016 at 11:39:31AM +0100, Karel Zak wrote:
> > However it's of course fine with me to make the summary lines optional.
> 
> I have added --summary[=never,always,only]
> 
>     never  - disable summary lines at all (forced for parsable  outputs)
>     always - default for standard output
>     only   - prints only summary, no table with blocks, default when
>              --summary specified without argument
> 
> > Also fine with me :) Thank you for taking care of this!
> 
>     https://github.com/karelzak/util-linux/tree/mem-tools
> 
> This branch contains the new lsmem; the next week I'll cleanup chmem 
> and merge it to the master branch (after v2.29 release, probably
> Monday).

Looks all good to me. Just two comments:

- you changed the alignment of nearly all columns from left to right,
except for STATE and RANGE. For RANGE it does make sense to keep it aligned
to the left, however for STATE it looks a bit inconsistent. Not sure if you
missed to make it also align to the right?

- the updated man page now says that the default output is subject to
change; but it should not change in order to be compatible with the old
lsmem tool within s390-tools.

Also you might consider applying the simple patch below ;)

>From 270714b84caae0977e12afd7f59f88e051463e66 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 4 Nov 2016 12:56:08 +0100
Subject: [PATCH] lsmem: improve node lookup

Break the loop as soon as we found the node a memory block belongs to,
it doesn't make sense to continue scanning.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lsmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 1dcf8a8e405d..10afc3cb6c8c 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -265,6 +265,7 @@ static int memory_block_get_node(char *name)
 		if (!isdigit_string(de->d_name + 4))
 			continue;
 		node = strtol(de->d_name + 4, NULL, 10);
+		break;
 	}
 	closedir(dir);
 	return node;
-- 
2.8.4

