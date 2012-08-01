Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab2HAL6q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 07:58:46 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q71BwkRG001561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 07:58:46 -0400
Message-ID: <501919F4.3040403@redhat.com>
Date: Wed, 01 Aug 2012 13:58:44 +0200
From: Niels de Vos <ndevos@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on
 the commandline
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com> <20120801094833.GC1019@x2.net.home> <20120801100316.GD1019@x2.net.home> <5019017E.4050704@redhat.com> <20120801103248.GA7670@x2.net.home>
In-Reply-To: <20120801103248.GA7670@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/01/2012 12:32 PM, Karel Zak wrote:
> On Wed, Aug 01, 2012 at 12:14:22PM +0200, Niels de Vos wrote:
>> On 08/01/2012 12:03 PM, Karel Zak wrote:
>>> On Wed, Aug 01, 2012 at 11:48:33AM +0200, Karel Zak wrote:
>>>>> Some options are not allowed to be
>>>>> passed multiple times (like the SElinux context options) and mounting will fail
>>>>> if options are present in both /etc/fstab and on the commandline.
>>>>
>>>> This is stupid SELinux disadvantage and SELinux should be fixed.
>>>
>>> Note that mount(8) and libmount removes all selinux context options on
>>> remount for kernels<   2.6.39 because SELinux context remount was
>>> unsupported, so this SELinux disadvantage should be hidden for usual
>>> use case.
>>>
>>> Maybe we can also add another exception for SELinux to de-duplicate
>>> the SELinux context options in the options string. It's not perfect,
>>> but probably acceptable for SELinux -- I can do this for 2.22-rc2.
>>
>> That would be great. What is your opinion on getting the SElinux options
>> handled differently in the kernel instead or in addition?
>
> SELinux is no filesystem and we already have (must have) SELinux
> specific code in mount(8) (and many others utils;-).

Okay, so as it's not a filesystem, it warrants the de-dup handling. I'd 
appreciate it if this makes it in 2.22-rc2. Please let me know if you want me to 
provide patches and/or test the results.

Many thanks,
Niels
