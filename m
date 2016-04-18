Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34376 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcDRNFc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Apr 2016 09:05:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id e190so26201985lfe.1
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 06:05:31 -0700 (PDT)
Received: from ?IPv6:2a00:1370:8100:7954:8d40:7fbd:78e7:2a62? ([2a00:1370:8100:7954:8d40:7fbd:78e7:2a62])
        by smtp.googlemail.com with ESMTPSA id k137sm10410247lfg.16.2016.04.18.06.05.29
        for <util-linux@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2016 06:05:30 -0700 (PDT)
Subject: Re: unshare -m and mount propagation
References: <m3oaacfrn2.fsf@gmail.com>
 <20160418111628.cj5bscuuxee2xfcg@ws.net.home> <m3inzfkud2.fsf@gmail.com>
 <20160418122238.o645avvzj2tzzwsd@ws.net.home>
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
To: util-linux@vger.kernel.org
Message-ID: <5714DB99.50806@gmail.com>
Date: Mon, 18 Apr 2016 16:05:29 +0300
MIME-Version: 1.0
In-Reply-To: <20160418122238.o645avvzj2tzzwsd@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18.04.2016 15:22, Karel Zak wrote:
> On Mon, Apr 18, 2016 at 02:51:37PM +0300, Yuriy M. Kaminskiy wrote:
>> Karel Zak <kzak@redhat.com> writes:
>>
>>> On Fri, Mar 18, 2016 at 05:26:25AM +0300, Yuriy M. Kaminskiy wrote:
>>>> I think this issue should be at least documented. And, maybe, default
>>>> `--propagation` should be changed to `slave`.
>>>
>>> The reason why we use 'private' is that it's the kernel default for
>>> years and it's what has been expected by users for long time before we
>>> introduced --propagation and any unshare(1) default.
>>>
>>> The current --propagation default unifies things and makes unshare(1)
>>> portable to distributions where root fs is mounted as 'shared' (e.g.
>>> systemd distros) and all this in backwardly compatible way for users

Opposite. It does not change anything for older systems, but breaks 
things for new systems.

>>> who have no clue about --propagation.

And it is *especially* harmful for users that are not aware about 
--propagation. As private (new 2.27+ default) break umount propagation, 
and results in nasty surprises (up to data loss).

>>> So, I don't think we want to change any default to corrupt scripts where
>>> is no explicitly specified --propagation.
>>
>> By you already broke scripts that expected old a-la '--propagation
>> unchanged' behavior.
>
> Only if your system uses something else that kernel default 'private'
> and you depend on this non-default setting. (IMHO relatively small
> groups of users)

All systemd systems use shared. Which is not "small group of users".

> The old "--propagation unchanged" makes unshare useless on some
> mainstream distros where default is 'shared'.

No, it is not. --propagation does not do *anything* that cannot be done 
without it. On pre-2.27 util-linux,

   unshare -m sh -c 'mount --make-rprivate /; ...'

does exactly same as `unshare -m [--propagation=private] ...` in 2.27+.

Reverse is not true! With 2.27 you *must* use new 
[backward-incompatible] options to revert to sane behavior [which is 
*slave*, not *private*].

> Anyway, we will not change any default now.
