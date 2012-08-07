Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:45558 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2HGFan (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Aug 2012 01:30:43 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Tue, 7 Aug 2012 11:00:39 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q775UZL313566152
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 11:00:36 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q77B09lE028763
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 16:30:09 +0530
Message-ID: <5020A7F8.9070402@linux.vnet.ibm.com>
Date: Tue, 07 Aug 2012 11:00:32 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
References: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com> <20120806114906.GA3432@osiris.de.ibm.com>
In-Reply-To: <20120806114906.GA3432@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 06 August 2012 05:20 PM, Heiko Carstens wrote:
> On Sun, Aug 05, 2012 at 10:10:52PM -0700, Faizan husain wrote:
>> From: faizan husain <faizanh@linux.vnet.ibm.com>
>>
>> Options for lscpu command are giving incorrect output.
>> As per the man page or help, '-b' option should limit the output to online CPUs
>> and '-c' option should limit the output to offline CPUs.
>> But we could see the output is same for '-a','-b' and '-c' options.
>>
>> Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>
> The -a, -b and -c options were meant to influence the output for the
> extended (-e) and parsable (-p) output options.
> I'm not sure it makes sense to change the default output with these
> options. I'd prefer an update of the man page.
>
> Hm?
This fix is not going to influence the default output with these options 
(-e and -p),
and it does not make any sense if -a, -b and -c option print same output.

Thanks
Faizan

