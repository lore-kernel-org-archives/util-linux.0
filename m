Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S939034AbdD0Ksr (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 Apr 2017 06:48:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3RAgaUF134395
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 06:48:47 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2a3f4p06vw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 06:48:47 -0400
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Thu, 27 Apr 2017 20:48:43 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3RAmWMb2097588
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 20:48:40 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v3RAm72j018026
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 20:48:07 +1000
Subject: Re: [PATCH]lscpu: Read available CPUs max and min frequencies
To: Karel Zak <kzak@redhat.com>,
        =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
References: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
 <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
 <20170418103138.p7zqetpaq4wkym3h@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 16:17:50 +0530
MIME-Version: 1.0
In-Reply-To: <20170418103138.p7zqetpaq4wkym3h@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b94f2794-7d0f-2ae5-416e-0b42cd3dfb20@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Thanks for your review comments...

On 04/18/2017 04:01 PM, Karel Zak wrote:
> On Mon, Apr 17, 2017 at 11:00:50AM +0200, Rüdiger Meier wrote:
>> On 04/17/2017 10:30 AM, Mamatha Inamdar wrote:
>>> Problem: On power syatems "lscpu frequency-info" command was always
>>> reading CPU0 max and min frequencies. If CPU0 is guarded or offline
>>> then it used to display max and min frequencies as NULL.
>>>
>>> Solution: This patch will check for the available/online CPUs
>>> and read the max/min frequencies of that CPU
>> Maybe we could do it even more generically, not letting the first lookup win
>> but really using the minimum/maximum over *all* CPUs. Who knows, maybe
>> different cores could have different min/max.
> Good point.
>
> We already have this information for all CPUs in the desc->maxmhz[]
> and desc->minmhz[].  So all we need is function that will return
> max/min from the arrays.
>
>      Karel

I have worked on your comments and sent new version of patch, please 
review and let me
know your comments.


