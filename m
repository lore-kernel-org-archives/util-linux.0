Return-Path: khlebnikov@parallels.com
Message-ID: <4E098E3B.5060707@openvz.org>
Date: Tue, 28 Jun 2011 12:18:03 +0400
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
MIME-Version: 1.0
To: <util-linux@vger.kernel.org>, Petr Uzel <petr.uzel@suse.cz>,
        Karel Zak
	<kzak@redhat.com>
Subject: [BUG] umount does not work for disconected nfs mounts
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <util-linux.vger.kernel.org>

commit 33cee6675edecbd27c0628f8b7c74c7d88fc02b2
http://git.kernel.org/?p=utils/util-linux/util-linux-ng.git;a=commitdiff;h=33cee6675edecbd27c0628f8b7c74c7d88fc02b2;hp=fde25e6be6e00a0998eb58b4b9d0d0b9ad65dbfd
"umount: allow unmounting loopdev specified by associated file"
broke umounting (by mountpoint) for broken nfs mounts,
because now umount always call stat() for target argument and umount hang inside nfs-rpc:

[<ffffffff8163df3f>] rpc_wait_bit_killable+0x1f/0x40
[<ffffffff8163eb85>] __rpc_execute+0xe5/0x2f0
[<ffffffff8163eebe>] rpc_execute+0x3e/0x50
[<ffffffff816372f0>] rpc_run_task+0x70/0x90
[<ffffffff816373fe>] rpc_call_sync+0x3e/0x70
[<ffffffff812228f3>] nfs3_rpc_wrapper.constprop.11+0x43/0x70
[<ffffffff81223bd2>] nfs3_proc_getattr+0x42/0x80
[<ffffffff81212955>] __nfs_revalidate_inode+0x95/0x1f0
[<ffffffff81212bf1>] nfs_revalidate_inode+0x31/0x60
[<ffffffff81212cca>] nfs_getattr+0x5a/0x110
[<ffffffff8112caea>] vfs_getattr+0x1a/0x30
[<ffffffff8112cce3>] vfs_fstatat+0x53/0x70
[<ffffffff8112cd36>] vfs_stat+0x16/0x20
[<ffffffff8112d0c5>] sys_newstat+0x15/0x30
[<ffffffff816c45bb>] tracesys+0xd9/0xde
[<ffffffffffffffff>] 0xffffffffffffffff

so mount /mnt/nfs get stuck, umounting by device is still possible.
