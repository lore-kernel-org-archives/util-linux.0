Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f50.google.com ([209.85.218.50]:44404 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaKYPgd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Nov 2014 10:36:33 -0500
Received: by mail-oi0-f50.google.com with SMTP id a141so562230oig.23
        for <util-linux@vger.kernel.org>; Tue, 25 Nov 2014 07:36:32 -0800 (PST)
Received: from [192.168.0.75] (cpe-70-123-211-202.satx.res.rr.com. [70.123.211.202])
        by mx.google.com with ESMTPSA id d6sm575663obq.4.2014.11.25.07.36.30
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 07:36:31 -0800 (PST)
Message-ID: <5474A1FD.1060607@gmail.com>
Date: Tue, 25 Nov 2014 09:36:29 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <20141124113733.GC926@x2.net.home> <547343EA.6090606@ubuntu.com> <20141124154604.GA2610@x2.net.home> <54738D83.9010108@gmail.com> <20141125112615.GC2610@x2.net.home>
In-Reply-To: <20141125112615.GC2610@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Nov 24, 2014 at 01:56:51PM -0600, Bruce Dubbs wrote:
>> Karel Zak wrote:
>>> On Mon, Nov 24, 2014 at 09:42:50AM -0500, Phillip Susi wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> On 11/24/2014 6:37 AM, Karel Zak wrote:
>>>>> The current trend is to use partition type to define for what
>>>>> purpose we want to use the partition (for example "this is /home")
>>>>> independently on partition format.
>>>>
>>>> I wouldn't call this bone headed idea of redhat's a trend.  Using
>>>> partition table type codes to decide to auto mount in particular parts
>>>> of the filesystem is such a brain damaged idea, those who thought it
>>>> up need beaten with a clue-by-four and its use needs to be *strongly*
>>>> discouraged.
>>>
>>>   well, it's designed for auto-generated fstab-less systems like
>>>   containers/virt images, etc. I'm not big fan of this feature, but for
>>>   some use cases it makes sense. (And it's systemd upstream decision.)
>>>
>>>   Anyway, use partition type for "usage" makes more sense than for "fs-type".
>>
>> Since when is systemd upstream of util-linux?
>
>   Ah.. freedesktop guys introduced some new GUID and util-linux project
>   has accepted these identifiers (rather than interpret these IDs as
>   "unknown") ...  as well as we accepted partition IDs for Apple stuff,
>   as well as we accepted Hurd patches, ports to freebsd, uClibc,
>   not-perfect zram stuff from kernel, stuff from SysVinit, and many
>   many many other things.
>
>   I don't plan to be censor for another projects and apply any
>   emotional criteria. The reason why this project still alive is that
>   we are very friendly to arbitrary distributions and another projects.

I have not problem with that.  I just don't want to see a hard 
dependency on systemd like other projects have done.  There are a lot of 
projects that are mutually dependent, but the term upstream sounded some 
alarm bells for me.

I do think util-linux is managed in an excellent way.

   -- Bruce


