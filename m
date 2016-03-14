Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:34514 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965422AbcCNPVL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 11:21:11 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <hegdevasant@linux.vnet.ibm.com>;
	Mon, 14 Mar 2016 20:51:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2EFKYi210486112
	for <util-linux@vger.kernel.org>; Mon, 14 Mar 2016 20:50:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2EKnkYw008869
	for <util-linux@vger.kernel.org>; Tue, 15 Mar 2016 02:19:47 +0530
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
To: Karel Zak <kzak@redhat.com>
References: <20160314144804.415.11481.stgit@hegdevasant>
 <20160314151925.xlfo6kdxq4lj5tu2@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Message-ID: <56E6D6CF.1010007@linux.vnet.ibm.com>
Date: Mon, 14 Mar 2016 20:50:47 +0530
MIME-Version: 1.0
In-Reply-To: <20160314151925.xlfo6kdxq4lj5tu2@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/14/2016 08:49 PM, Karel Zak wrote:
> On Mon, Mar 14, 2016 at 08:18:07PM +0530, Vasant Hegde wrote:
>>    Model:                 2.1 (pvr 004b 0201)
>>    Model name:            POWER8E (raw), altivec supported
>>    ...
>>    ...
>> ---
>>   sys-utils/lscpu.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>
> Seems better. Applied, thanks!

Karel,

Thanks for the quick response.

-Vasant

