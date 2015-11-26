Return-Path: util-linux-owner@vger.kernel.org
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:35077 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbbKZRzR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 26 Nov 2015 12:55:17 -0500
To: util-linux <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.com>
Subject: [PATCH?] fix mount -a on btrfs bind mount
CC: David Sterba <dsterba@suse.cz>, =?UTF-8?Q?S=c3=b8ren_Holm?= <sgh@sgh.dk>
Message-ID: <56573A99.9060009@suse.com>
Date: Thu, 26 Nov 2015 18:00:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If I have a fstab that contains:

UUID=1f976144-6c23-4622-bf6c-cd9821acc49d /var/log             btrfs      subvol=@/var/log      0 0
/var/log                /local/nfsv4/log                none    bind,private

When calling "mount -a" multiple times, it mounts the bind
mount again and again.

Here are related mountinfo entries with my kernel:
44 34 0:30 /@/var/log /var/log rw,relatime shared:27 - btrfs /dev/vda2 rw,space_cache,subvolid=269,subvol=/@/var/log
95 34 0:30 /@/var/log /local/nfsv4/log rw,relatime - btrfs /dev/vda2 rw,space_cache,subvolid=269,subvol=/@/var/log

Debugging this case, I found that the btrfs specific code in
mnt_table_get_fs_root() returns bad value:

after remove_mountpoint_from_path() root is "/"
mnt_table_find_target(tb, "/var/log", MNT_ITER_BACKWARD)
returns src_root set to "/@/var/log".
startswith() does not match and the snprintf() attempts to
construct the final root value by concatenating of both
strings:

FS root result: /@/var/log/

It looks strange, and it does not work:

Then it returns to mnt_table_is_fs_mounted(), and the iterator
while (mnt_table_next_fs(tb, &itr, &fs) == 0)
could never get a match.
In section starting with if (root)
and mnt_fs_get_root(fs) returns "/@/var/log"
This is compared with "/@/var/log/" above, and match is never
got.

Here is a possible easy fix. If it is correct, the code should
be simplified to remove string copying there.

I am not sure whether it has any side effect, but it helps in
my case.

Note that 41510d26ddd9a4c83f8589dded539e2985535dcf added a
patch to "else if" part of this if, that is also a bit
suspicious: btrfs path should not contain "//" instead of
"/{subvolume}/", at least not in a correct use.

---
 libmount/src/tab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 0df8d49..44894e9 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1252,7 +1252,7 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 
 			if (!tmp)
 				goto err;
-			snprintf(tmp, sz, "%s%s", src_root, root);
+			snprintf(tmp, sz, "%s", src_root);
 			free(root);
 			root = tmp;
 		}
-- 
2.6.3

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
