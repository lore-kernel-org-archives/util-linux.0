Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:63590 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870Ab1KPOKt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2011 09:10:49 -0500
Message-ID: <4EC3C464.1070401@bernhard-voelker.de>
Date: Wed, 16 Nov 2011 15:10:44 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/15] prlimit: avoid segfault due to	array-out-of-bounds
 error
References: <4EC07379.8090102@bernhard-voelker.de> <20111116125655.GI7916@nb.net.home>
In-Reply-To: <20111116125655.GI7916@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/16/2011 01:56 PM, Karel Zak wrote:
>> Example:
>> >  $ prlimit -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l
>> >  RESOURCE DESCRIPTION                         SOFT   HARD UNITS
>> >  MEMLOCK  max locked-in-memory address space 65536 262144 bytes
>> >  MEMLOCK  max locked-in-memory address space 65536 262144 bytes
>> >  ...
>> >  Segmentation fault
>   Ah.. stupid bug.
>
>> >  Use the lims array in a more direct way, i.e. the index is limit id.
>> >  Initialize lims array and adapt option parsing in main() accordingly.
>> >  do_prlimits() and show_limits(): loop over all MAX_RESOURCES in the
>> >  lims array.
>   It means that users cannot control order of the printed and modified
>   resources. We prefer in all our new utils that output is fully
>   controlled by users -- only this is a way how you can create stable
>   and robust scripts.
>
>   I have replaced the array with list (see include/list.h). This
>   solution makes the code more readable and robust.
>
>   # ./prlimit --data --nofile
>   RESOURCE DESCRIPTION                   SOFT      HARD UNITS
>   DATA     max data size            unlimited unlimited bytes
>   NOFILE   max amount of open files      1001      3000

thanks, using a list is even cooler!

With my solution, you couldn't display a limit before and after
changing it in the same call like it is possible now:

prlimit -n -n1000: -n -n:1000 -n
RESOURCE DESCRIPTION              SOFT HARD UNITS
NOFILE   max amount of open files 1024 8192
NOFILE   max amount of open files 1000 8192
NOFILE   max amount of open files 1000 1000

Have a nice day,
Berny

