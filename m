Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:35470 "EHLO Ishtar.hs"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754460Ab3DXAjm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Apr 2013 20:39:42 -0400
Message-ID: <517729C7.2030806@tlinx.org>
Date: Tue, 23 Apr 2013 17:39:35 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: mount --no-canonical seems broken.
References: <5175BA15.9060803@tlinx.org> <20130423123648.GB24501@x2.net.home>
In-Reply-To: <20130423123648.GB24501@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>





Karel Zak wrote:
> On Mon, Apr 22, 2013 at 03:30:45PM -0700, Linda Walsh wrote:
>   
>> I would use mount --no-canonical to rewrite mtab to match fstab so
>>
>> my utils could find volumes in /etc/fstab -- but recently in
>> util-linux-2.21.2
>> this has no longer worked.
>>
>> I made sure to have /etc/mtab NOT be a symlink to /proc/self/mounts so
>> mount could write to it.  It DOES write to it, but it doesn't display it.
>>
>> Example:
>> After doing a remount as recommended by the manpage...
>>
>>     mount -f --no-canonical -a -o remount
>>     
>
>  Well, --no-canonicalize assume that all paths are already
>  canonicalized and the remount updates mount options only.
>   
---
    Well my main concern has been how lvm volumes are renamed.

i.e. /dev/Vol-group/Log-vol ->
/dev/mapper/Vol--group-Log--vol

I have backup and file-system utils that use the values in fstab, and it
looks for those values in the output of mount (and df).

Also, recently, (in the "mostest latest" ;-), mount in my distro (suse),
the root dev has disappeared... I don't get /dev/sdc1 (my root partition)
I get /dev/root -- and only if I follow the symlink in /dev, will I find
/dev/sdc6.

But that's just the latest probl... the other stuff...

I've been using the mount --no-canonicalize to mount my lvm volumes --
and also going back and doing the "mount -f --nocanonicalize ..." to get the
ones mounted at boot time.

Now... programs crashing, dogs and cats living togther... heinous! 

??ideas?
Note -- I don't recall doing anything with mtab BEFORE -- BUT I may have
made sure it was a separate file years ago when I started using lvm.

Recently it was changed back to a symlink and on top of that -- whether
it is a file or a symlink, mount doesn't seem to show the "non-canon" name
(i.e. /dev/Vol/Log...)
(though oddly enough -- "df" does!)...






>
>  What exactly do you want to do? Maybe we can try to find a better
>  solution than play nasty games with mtab ;-)
>
>     Karel
>
>
>   

