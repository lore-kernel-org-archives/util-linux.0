Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37089 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759960AbdEOQtd (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 May 2017 12:49:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4FGi43Q063518
        for <util-linux@vger.kernel.org>; Mon, 15 May 2017 12:49:32 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2affgyhwk8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Mon, 15 May 2017 12:49:31 -0400
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Tue, 16 May 2017 02:49:29 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v4FGnJVw51314888
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 02:49:27 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v4FGmtrX001917
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 02:48:55 +1000
Subject: Re: [PATCH V2]lscpu: Read available CPUs max and min frequencies
To: Karel Zak <kzak@redhat.com>
References: <149328816596.3522.18183659350666784285.stgit@localhost.localdomain>
 <20170509102435.wac7mskawbw7w66i@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 22:18:37 +0530
MIME-Version: 1.0
In-Reply-To: <20170509102435.wac7mskawbw7w66i@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6fa27ad8-55e4-2289-8834-617579d8c2fd@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 05/09/2017 03:54 PM, Karel Zak wrote:
> On Thu, Apr 27, 2017 at 03:52:59PM +0530, Mamatha Inamdar wrote:
>>   sys-utils/lscpu.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 40 insertions(+), 5 deletions(-)
> Applied, thanks with some changes.

Hi Karel Zak,

I was on vacation, good to know you have made changes and applied the 
patch...
thanks for your support.

Regards
Mamatha Inamdar
>

