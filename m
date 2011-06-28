Return-Path: util-linux-owner@vger.kernel.org
Received: from relay.parallels.com ([195.214.232.42]:58424 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab1F1JOs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2011 05:14:48 -0400
Received: from msk-exch1.sw.swsoft.com ([10.30.1.231] helo=mail.sw.ru)
	by relay.parallels.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74)
	(envelope-from <khlebnikov@parallels.com>)
	id 1QbUNb-0004lW-12
	for util-linux@vger.kernel.org; Tue, 28 Jun 2011 13:14:47 +0400
Message-ID: <4E099B86.1030802@parallels.com>
Date: Tue, 28 Jun 2011 13:14:46 +0400
From: Konstantin Khlebnikov <khlebnikov@parallels.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>, <khlebnikov@openvz.org>
Subject: Re: [BUG] umount does not work for disconected nfs mounts
References: <4E098E3B.5060707@openvz.org> <20110628085724.GE22770@foxbat.suse.cz>
In-Reply-To: <20110628085724.GE22770@foxbat.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Petr Uzel wrote:
> On Tue, Jun 28, 2011 at 12:18:03PM +0400, Konstantin Khlebnikov wrote:
>> commit 33cee6675edecbd27c0628f8b7c74c7d88fc02b2
>> http://git.kernel.org/?p=utils/util-linux/util-linux-ng.git;a=commitdiff;h=33cee6675edecbd27c0628f8b7c74c7d88fc02b2;hp=fde25e6be6e00a0998eb58b4b9d0d0b9ad65dbfd
>> "umount: allow unmounting loopdev specified by associated file"
>> broke umounting (by mountpoint) for broken nfs mounts,
>> because now umount always call stat() for target argument and umount hang inside nfs-rpc:
>>
>> [<ffffffff8163df3f>] rpc_wait_bit_killable+0x1f/0x40
>> [<ffffffff8163eb85>] __rpc_execute+0xe5/0x2f0
>> [<ffffffff8163eebe>] rpc_execute+0x3e/0x50
>> [<ffffffff816372f0>] rpc_run_task+0x70/0x90
>> [<ffffffff816373fe>] rpc_call_sync+0x3e/0x70
>> [<ffffffff812228f3>] nfs3_rpc_wrapper.constprop.11+0x43/0x70
>> [<ffffffff81223bd2>] nfs3_proc_getattr+0x42/0x80
>> [<ffffffff81212955>] __nfs_revalidate_inode+0x95/0x1f0
>> [<ffffffff81212bf1>] nfs_revalidate_inode+0x31/0x60
>> [<ffffffff81212cca>] nfs_getattr+0x5a/0x110
>> [<ffffffff8112caea>] vfs_getattr+0x1a/0x30
>> [<ffffffff8112cce3>] vfs_fstatat+0x53/0x70
>> [<ffffffff8112cd36>] vfs_stat+0x16/0x20
>> [<ffffffff8112d0c5>] sys_newstat+0x15/0x30
>> [<ffffffff816c45bb>] tracesys+0xd9/0xde
>> [<ffffffffffffffff>] 0xffffffffffffffff
>
> Shouldn't this be handled in the kernel? Or is stat() really
> supposed to fail in such way with broken nfs?

It depends on used mount options, IIRR in "soft" mode it by default fail with EIO after 3-6 minutes timeout,
in "hard" mode syscalls never returns EIO.

BTW linux support bindmounting for individual files,
so argument can refer to regular file not only for loop device image.

>
>>
>> so mount /mnt/nfs get stuck, umounting by device is still possible.
>
> We might first scan through mtab to check if umount arg is known
> mountpoint and only if we fail, we would look for associated loopfile.

Yes, it seems is the best solution

>
> Karel?
>
>
> Petr
>
> --
> Petr Uzel
> IRC: ptr_uzl @ freenode

