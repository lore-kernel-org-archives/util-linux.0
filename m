Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51375 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758723AbcKCQTz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Nov 2016 12:19:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA3GJQAh063185
        for <util-linux@vger.kernel.org>; Thu, 3 Nov 2016 12:19:54 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26g6crhak3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Thu, 03 Nov 2016 12:19:54 -0400
Received: from localhost
        by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 3 Nov 2016 16:19:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D4425219005F
        for <util-linux@vger.kernel.org>; Thu,  3 Nov 2016 16:19:05 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uA3GJojl41615532
        for <util-linux@vger.kernel.org>; Thu, 3 Nov 2016 16:19:50 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uA3GJoIG027763
        for <util-linux@vger.kernel.org>; Thu, 3 Nov 2016 10:19:50 -0600
Date: Thu, 3 Nov 2016 17:19:48 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 2/4] lsmem: new tool
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-3-heiko.carstens@de.ibm.com>
 <20161103120059.75nflzf5wvepafzu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103120059.75nflzf5wvepafzu@ws.net.home>
Message-Id: <20161103161948.GA12234@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 03, 2016 at 01:00:59PM +0100, Karel Zak wrote:
> On Wed, Oct 12, 2016 at 02:00:45PM +0200, Heiko Carstens wrote:
> > RANGE                                 SIZE STATE   REMOVABLE BLOCK
> > 0x0000000000000000-0x000000005fffffff 1,5G online  yes       0-5
> > 0x0000000060000000-0x000000007fffffff 512M online  no        6-7
> > 0x0000000080000000-0x000000013fffffff   3G online  yes       8-19
> > 0x0000000140000000-0x000000014fffffff 256M offline -         20
> > 0x0000000150000000-0x000000017fffffff 768M online  no        21-23
> > 
> > Memory block size   :     256M
> > Total online memory :     5,8G
> > Total offline memory:     256M
> 
> It seems that for backward compatibility we need the summary lines at
> the end. Maybe we can add --no-summary and --summary-only for people
> who want to use it in the scripts.

Scripts should use the --parsable option (or one of the new options you
mentioned below), no?
However it's of course fine with me to make the summary lines optional.

> > The lsmem tool also has "--extendend" and "--parsable" option which
> > can be used to customize the output, e.g.  limit the output to
> > specified columns. This is quite similar to what the lscpu tool does.
> 
> Frankly, I don't like these lscpu options :-) For new tools we have
> --pairs/export (NAME=value), --raw, --json and --output=<list>. 
> 
> You do not need to re-submit the patches, I'll cleanup the stuff.

Also fine with me :) Thank you for taking care of this!

