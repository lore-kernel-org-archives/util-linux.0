Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:49755 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab2DQOOR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Apr 2012 10:14:17 -0400
Message-ID: <4F8D7AB3.1010406@bernhard-voelker.de>
Date: Tue, 17 Apr 2012 16:14:11 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
References: <4F8D2D12.8070206@bernhard-voelker.de> <4F8D76AB.2090806@draigBrady.com>
In-Reply-To: <4F8D76AB.2090806@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/17/2012 03:56 PM, Pádraig Brady wrote:
> On 04/17/2012 09:42 AM, Bernhard Voelker wrote:
>> Karel Zak wrote:
>>
>>> On Mon, Apr 16, 2012 at 12:22:12PM +0200, Voelker, Bernhard wrote:
>>>> Maybe this is better?
>>>>
>>>> -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
>>>> +	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"
> 
> Blocks are 1024 bytes in this mode, as confirmed with:
> sfdisk -uM -l /dev/sda

I don't understand. What's wrong?

$ wc -c </dev/sda1
12582912000

$ echo '12582912000 / (1024*1024)' | bc
12000

$ ./sfdisk -uM -l /dev/sda | egrep 'sda1|MiB'
Units = 1MiB, blocks of 1024*1024 bytes, counting from 0
   Device Boot Start   End    MiB    #blocks   Id  System
/dev/sda1   *     1  12000  12000   12288000   83  Linux

Have a nice day,
Berny
