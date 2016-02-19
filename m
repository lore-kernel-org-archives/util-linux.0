Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add test for loop option in fstab
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56C75E7B.60407@suse.cz>
Date: Fri, 19 Feb 2016 19:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <20160216144918.iqmvz27qggxfnjng@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On Feb 16 2016 at 15:49 Karel Zak wrote:
> On Mon, Feb 15, 2016 at 12:42:10PM +0100, Ruediger Meier wrote:
>> On Thursday 11 February 2016, Stanislav Brabec wrote:
>>> Add a new fstab tests which check loop mount of the same source
>>> multiple times in multiple steps.
>>
>> This test still fails if /etc/mtab is a regular file.
> 
> The problem should be fixed now. Thanks!
> 
Well, not for btrfs. See the new testcase below (ready for inclusion to the
GIT).

Only one volume is mounted, others report "already mounted".

Looking at dmesg, in difference to the previous tests, mount allocates more
loop devices. And only one sub-volume is mounted after mount -a.

[25047.013991] BTRFS info (device loop0): disk space caching is enabled
[25047.013995] BTRFS: has skinny extents
[25047.405435] BTRFS info (device loop0): disk space caching is enabled
[25047.405441] BTRFS: has skinny extents
[25047.752299] BTRFS info (device loop1): disk space caching is enabled
[25047.752302] BTRFS: has skinny extents

        mount: btrfs (fstab)                  ...
                : btrfs                       ... OK
                : auto                        ... OK
                : loop                        ... FAILED (mount/fstab-btrfs-loop)
           ... FAILED (1 from 3 sub-tests)
        mount: loop (fstab)                   ... OK

mount: /dev/loop2 is already mounted or /home/sbrabec/VCS-my/util-linux-btrfs-fixes-loop/tests/output/mount/fstab-btrfs-mnt-default busy
umount: /home/sbrabec/VCS-my/util-linux-btrfs-fixes-loop/tests/output/mount/fstab-btrfs-mnt-bind: not mounted
umount: /home/sbrabec/VCS-my/util-linux-btrfs-fixes-loop/tests/output/mount/fstab-btrfs-mnt-subvol: not mounted
umount: /home/sbrabec/VCS-my/util-linux-btrfs-fixes-loop/tests/output/mount/fstab-btrfs-mnt-subvolid: not mounted

Here is a new testcase:
>From 559933a158d822852f1d06db02320646f237c4b8 Mon Sep 17 00:00:00 2001
From: Stanislav Brabec <sbrabec@suse.com>
Date: Fri, 19 Feb 2016 19:02:53 +0100
Subject: [PATCH] tests: add btrfs loop mount tests

btrfs needs a special support in loop mount. Add a testcase for btrfs specific
problems.

It is a cut-and-paste of previous sub-test, just the fstab syntax is different.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/mount/fstab-btrfs-loop |  1 +
 tests/ts/mount/fstab-btrfs            | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/mount/fstab-btrfs-loop

diff --git a/tests/expected/mount/fstab-btrfs-loop b/tests/expected/mount/fstab-btrfs-loop
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/mount/fstab-btrfs-loop
@@ -0,0 +1 @@
+Success
diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
index d14ad10..f3af9f9 100755
--- a/tests/ts/mount/fstab-btrfs
+++ b/tests/ts/mount/fstab-btrfs
@@ -36,7 +36,7 @@ TS_MOUNTPOINT_SUBVOL="$TS_MOUNTPOINT-subvol"
 TS_MOUNTPOINT_SUBVOLID="$TS_MOUNTPOINT-subvolid"
 TS_MOUNTPOINT_BIND="$TS_MOUNTPOINT-bind"
 
-ts_device_init 42
+ts_device_init 42 "$TS_OUTDIR/${TS_TESTNAME}.img"
 DEVICE=$TS_LODEV
 [ -d "$TS_MOUNTPOINT_CREATE" ] || mkdir -p "$TS_MOUNTPOINT_CREATE"
 [ -d "$TS_MOUNTPOINT_DEFAULT" ] || mkdir -p "$TS_MOUNTPOINT_DEFAULT"
@@ -123,6 +123,32 @@ ts_fstab_clean
 ts_log "Success"
 ts_finalize_subtest
 
+ts_init_subtest "loop"
+# Tests with "loop" in options syntax
+# mounting default subvolume, deep in the structure, without entry in fstab
+ts_fstab_add "$TS_OUTDIR/${TS_TESTNAME}.img" "$TS_MOUNTPOINT_DEFAULT" "btrfs" "loop"
+# mounting default subvolume, deep in the structure
+ts_fstab_add "$TS_OUTDIR/${TS_TESTNAME}.img" "$TS_MOUNTPOINT_SUBVOL" "btrfs" "loop,subvol=$NON_DEFAULT_SUBVOL"
+# mounting non-default subvolume
+ts_fstab_add "$TS_OUTDIR/${TS_TESTNAME}.img" "$TS_MOUNTPOINT_SUBVOLID" "btrfs" "subvolid=$NON_DEFAULT_SUBVOLID,loop"
+# test bind mount pointing to subvolume sub-directory
+ts_fstab_add "$TS_MOUNTPOINT_SUBVOL/bind-mnt" "$TS_MOUNTPOINT_BIND" "auto" "bind"
+
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
+
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" >> $TS_OUTPUT 2>&1
+
+# check that everything was unmounted
+$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" >> $TS_OUTPUT 2>&1
+
+ts_fstab_clean
+ts_log "Success"
+ts_finalize_subtest
+
 
 ts_finalize
 
-- 
2.7.1

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
