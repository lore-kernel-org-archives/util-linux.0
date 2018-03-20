Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbeCTRru (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Mar 2018 13:47:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2KHkl4D078705
        for <util-linux@vger.kernel.org>; Tue, 20 Mar 2018 13:47:50 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gu40c1kcd-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 20 Mar 2018 13:47:50 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 20 Mar 2018 17:47:48 -0000
Date: Tue, 20 Mar 2018 18:47:43 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: util-linux@vger.kernel.org
Cc: wild@linux.vnet.ibm.com, alkl@linux.vnet.ibm.com
Subject: Re: [PATCH] lsmem: fix total online/offline memory calculation
In-Reply-To: <20180320161738.49439-1-gerald.schaefer@de.ibm.com>
References: <20180320161738.49439-1-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20180320184743.09c3375a@thinkpad>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 20 Mar 2018 17:17:38 +0100
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> lsmem currently calculates the total online/offline memory by iterating
> over all lsmem->blocks. Depending on the lsmem options, there may be
> only one lsmem->block, because all sysfs memory blocks could be merged
> into one. In this case, the calculation is wrong, because the individual
> online/offline state of the sysfs memory blocks is not preserved, but
> rather lsmem->blocks[0].state is set to the state of the first sysfs
> memory block, typically MEMORY_STATE_ONLINE (at least on s390).
> 
> This means that "Total offline memory" will always be calculated as 0
> in such cases, e.g. when using "lsmem --summary", or any options that
> would merge the table output to one line, like "lsmem -o RANGE":
> 
> ~# lsmem --summary
> Memory block size:         1G
> Total online memory:      20G
> Total offline memory:      0B
> 
> Adding the "-a" option shows the real summary, since there is no block
> merging going on, and the calculation is therefore correct:
> 
> ~# lsmem -a --summary
> Memory block size:         1G
> Total online memory:      16G
> Total offline memory:      4G
> 
> Fix this by moving the online/offline calculation into the loop that
> is iterating over all sysfs memory blocks, instead of iterating over
> potentially merged lsmem->blocks.
> 
> Reported-by: Andre Wild <wild@linux.vnet.ibm.com>

Sorry, I mixed that up, this bug was
Reported-by: Alexander Klein <alkl@linux.vnet.ibm.com>

