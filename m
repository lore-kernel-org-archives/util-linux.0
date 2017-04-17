Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55501 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752305AbdDQJ4O (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Apr 2017 05:56:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3H9s5FK085941
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 05:56:13 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29ug1c3wjs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 05:56:13 -0400
Received: from localhost
        by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Mon, 17 Apr 2017 15:26:10 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
        by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3H9u7Yq20774936
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 15:26:07 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v3H9u6dR012358
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 15:26:06 +0530
Subject: Re: [PATCH]lscpu: Read available CPUs max and min frequencies
To: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux@vger.kernel.org
References: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
 <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 15:26:06 +0530
MIME-Version: 1.0
In-Reply-To: <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <06935f48-f6f1-d010-a86c-7b530743087c@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for reviewing,


On 04/17/2017 02:30 PM, Rüdiger Meier wrote:
> On 04/17/2017 10:30 AM, Mamatha Inamdar wrote:
>> Problem: On power syatems "lscpu frequency-info" command was always
>> reading CPU0 max and min frequencies. If CPU0 is guarded or offline
>> then it used to display max and min frequencies as NULL.
>>
>> Solution: This patch will check for the available/online CPUs
>> and read the max/min frequencies of that CPU
>
> Maybe we could do it even more generically, not letting the first 
> lookup win but really using the minimum/maximum over *all* CPUs. Who 
> knows, maybe different cores could have different min/max.

ok..sure..let me check on this.

>
> cu,
> Rudi
>

