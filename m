Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:60021 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbcCILDd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Mar 2016 06:03:33 -0500
Subject: Re: [PATCH 2/3] mount: further improve formatting of the man page
To: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
References: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
 <1457520901-4133-2-git-send-email-bensberg@justemail.net>
 <1457521100.3212166.544009746.0578A459@webmail.messagingengine.com>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <56E002FF.5080502@bernhard-voelker.de>
Date: Wed, 9 Mar 2016 12:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <1457521100.3212166.544009746.0578A459@webmail.messagingengine.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/09/2016 11:58 AM, Benno Schulenberg wrote:
>> -Checking files on NFS filesystem referenced by file descriptors (i.e.\& the
>> +Checking files on NFS filesystems referenced by file descriptors (i.e.\& the
>>   .B fcntl
>>   and
>>   .B ioctl
>> -families of functions) may lead to inconsistent result due to the lack of
>> -consistency check in kernel even if noac is used.
>> +families of functions) may lead to inconsistent results due to the lack of
>> +a consistency check in the kernel even if noac is used.
>> +.\"  What is "noac"?
>
> I can't figure out what noac is supposed to mean.
>
> Direct current?  :)

"no attribute caching" (on client side)
man 5 nfs

Have a nice day,
Berny

