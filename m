Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35689 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1F2Gos (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jun 2011 02:44:48 -0400
Received: by bwd5 with SMTP id 5so762068bwd.19
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2011 23:44:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E099B86.1030802@parallels.com>
References: <4E098E3B.5060707@openvz.org> <20110628085724.GE22770@foxbat.suse.cz>
 <4E099B86.1030802@parallels.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Jun 2011 02:44:27 -0400
Message-ID: <BANLkTik2i5pYy=ssmKKaUrqLdxymvDrq-A@mail.gmail.com>
Subject: Re: [BUG] umount does not work for disconected nfs mounts
To: Konstantin Khlebnikov <khlebnikov@parallels.com>
Cc: util-linux <util-linux@vger.kernel.org>, khlebnikov@openvz.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 28, 2011 at 05:14, Konstantin Khlebnikov wrote:
> Petr Uzel wrote:
>> On Tue, Jun 28, 2011 at 12:18:03PM +0400, Konstantin Khlebnikov wrote:
>>> commit 33cee6675edecbd27c0628f8b7c74c7d88fc02b2
>>>
>>> http://git.kernel.org/?p=utils/util-linux/util-linux-ng.git;a=commitdiff;h=33cee6675edecbd27c0628f8b7c74c7d88fc02b2;hp=fde25e6be6e00a0998eb58b4b9d0d0b9ad65dbfd
>>> "umount: allow unmounting loopdev specified by associated file"
>>> broke umounting (by mountpoint) for broken nfs mounts,
>>> because now umount always call stat() for target argument and umount hang
>>> inside nfs-rpc:
>>
>> Shouldn't this be handled in the kernel? Or is stat() really
>> supposed to fail in such way with broken nfs?
>
> It depends on used mount options, IIRR in "soft" mode it by default fail
> with EIO after 3-6 minutes timeout,
> in "hard" mode syscalls never returns EIO.

i noticed this recently.  one of the reasons i love `umount -lf` with
broken nfs mounts is that it works immediately.  any attempt to access
said broken mount in this situation is wrong as it inherently implies
it has to wait for a timeout (if one ever comes as Konstantin noted).

other than my personal usage on the command line, it makes shutdown
scripts obnoxiously slow to the point of being useless.
-mike
