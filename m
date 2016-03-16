Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:38763 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbcCPFgx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Mar 2016 01:36:53 -0400
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <hegdevasant@linux.vnet.ibm.com>;
	Wed, 16 Mar 2016 11:06:48 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2G5aiJ164684184
	for <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 11:06:46 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2G5aeXR021201
	for <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 11:06:41 +0530
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
References: <20160314144804.415.11481.stgit@hegdevasant>
 <201603150933.31562.sweet_f_a@gmx.de>
 <20160315134941.atrpxt45iua6bq7b@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Message-ID: <56E8F0DE.2040001@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 11:06:30 +0530
MIME-Version: 1.0
In-Reply-To: <20160315134941.atrpxt45iua6bq7b@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/15/2016 07:19 PM, Karel Zak wrote:
> On Tue, Mar 15, 2016 at 09:33:31AM +0100, Ruediger Meier wrote:
>>> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
>>> index fc32762..423bc56 100644
>>> --- a/sys-utils/lscpu.c
>>> +++ b/sys-utils/lscpu.c
>>> @@ -465,8 +465,13 @@ read_basicinfo(struct lscpu_desc *desc, struct
>>> lscpu_modifier *mod) else if (lookup(buf, "vendor_id",
>>> &desc->vendor)) ;
>>>   		else if (lookup(buf, "family", &desc->family)) ;
>>>   		else if (lookup(buf, "cpu family", &desc->family)) ;
>>> +#if defined(__powerpc__) || defined(__powerpc64__)
>>> +		else if (lookup(buf, "revision", &desc->model)) ;
>>> +		else if (lookup(buf, "cpu", &desc->modelname)) ;
>>> +#else
>>>   		else if (lookup(buf, "model", &desc->model)) ;
>>>   		else if (lookup(buf, "model name", &desc->modelname)) ;
>>> +#endif
>>>   		else if (lookup(buf, "stepping", &desc->stepping)) ;
>>>   		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
>>>   		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
>>
>> Would it be possible to decide on runtime what to do, ideally looking
>> into /proc or /sys to see whether it's a powerpc? This ifdef does not
>> work with lscpu --sysroot.
>
>   I have reverted the patch for --sysroot, so the #ifdef is applied to
>   live systems only (please, test it). Not elegant, but better than
>   nothing.

Karel,

I've gone through this patch.. Looks good. But I think Ruediger's patch is 
better one.

-Vasant

