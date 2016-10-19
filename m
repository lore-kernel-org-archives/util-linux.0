Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45063 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941215AbcJSORp (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Oct 2016 10:17:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9JAckXG028748
        for <util-linux@vger.kernel.org>; Wed, 19 Oct 2016 06:40:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26640b934r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 19 Oct 2016 06:40:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 19 Oct 2016 11:40:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 860E41B08069
        for <util-linux@vger.kernel.org>; Wed, 19 Oct 2016 11:42:39 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u9JAeZod19726516
        for <util-linux@vger.kernel.org>; Wed, 19 Oct 2016 10:40:35 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u9JAeZWg017316
        for <util-linux@vger.kernel.org>; Wed, 19 Oct 2016 04:40:35 -0600
Date: Wed, 19 Oct 2016 12:40:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 3/4] chmem: new tool
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-4-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012120047.60732-4-heiko.carstens@de.ibm.com>
Message-Id: <20161019104033.GG4077@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 12, 2016 at 02:00:46PM +0200, Heiko Carstens wrote:
> Move the s390 specific chmem tool to util-linux.
> 
> The chmem tool was originally written in perl and is part of the
> s390-tools package which can be found here:
> https://www.ibm.com/developerworks/linux/linux390/s390-tools.html
> 
> Given that the tool is architecture independent, there is no reason to
> keep it in an s390 specific repository. It seems to be useful for
> other architectures as well.
> 
> This patch converts the tool to C and adds it to util-linux, while the
> command line options stay compatible. The only exception is the option
> "-v" which used to be the short form of "--version". That got changed
> to "-V" so it behaves like most other tools contained within
> util-linux.
> 
> The chmem tool can be used to set memory online or offline. This can
> be achieved by specifying a memory range:
> 
> Memory Block 19 (0x0000000130000000-0x000000013fffffff) disabled
> 
> or by specifying a size where chmem will automatically select memory
> blocks:
> 
> Memory Block 21 (0x0000000150000000-0x000000015fffffff) disable failed
> Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled
> Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
> Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
> Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled
> 
> or by specifying memory block numbers instead of address ranges:
> 
> Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled
> Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
> Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
> Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled
> 
> This is based on a patch from Clemens von Mann.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

I just realized that the above "examples" don't make sense, since the
commands that were used are missing. That happened because I started the
lines with "#", which apparently git assumed to be a comment and therefore
ignored the lines.

So the correct description, which contains the commands, should be:

> The chmem tool can be used to set memory online or offline. This can
> be achieved by specifying a memory range:
>
> $ chmem -v -d 0x0000000130000000-0x000000013fffffff
> Memory Block 19 (0x0000000130000000-0x000000013fffffff) disabled
>
> or by specifying a size where chmem will automatically select memory
> blocks:
>
> $ chmem -v -d  1g
> Memory Block 21 (0x0000000150000000-0x000000015fffffff) disable failed
> Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled
> Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
> Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
> Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled
>
> or by specifying memory block numbers instead of address ranges:
>
> $ chmem -v -d -b 15-18
> Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled
> Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
> Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
> Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled

