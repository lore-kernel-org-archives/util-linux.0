Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:45952 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FPSyE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:04 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so1780852wev.30
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/15] pull: sfdisk and dmesg resubmission, plus bits and bobs
Date: Sun, 16 Jun 2013 19:53:41 +0100
Message-Id: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

Half of the patches in this pull request are re-worked changes, which
were rejected earlier.  The sfdisk error printing is now using plain
glibc warn() and err() functions.  The dmesg time format selection is
much cleaner when done the way Karel proposed.

Unfortunately the most troubling dmesg patch is now dropped by me.  I had
a look how systemd determines boot time, and it seem very early at
execution clock_gettime() is called, and results are saved.  If dmesg
should agree with systemd when startup happen I see two possible options;

1. Make dmesg to get system startup time from systemd using dbus.

2. Make both dmesg and systemd to ask start up time from kernel.

I feel first option is not great.  The systemd boot time stamp is similar
sort of approximation as reading fstat from /proc/1.  Also asking when
system started from system itself feels more neutral than consulting a
software the system started.

If the second option is favored a kernel patch, such as the one below, is
needed and a bit coordination to make various programs to use the
boottime from kernel.  Meanwhile it migth be fine that differnt programs
using differnet time stamps for klog messages.

Any opinions about klog time stamps?


--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -157,6 +157,16 @@ static ssize_t rcu_expedited_store(struct kobject
*kobj,
 }
 KERNEL_ATTR_RW(rcu_expedited);
 
+/* High precision timestamp of the system boot. */
+static ssize_t boottime_show(struct kobject *kobj,
+                            struct kobj_attribute *attr, char *buf)
+{
+       struct timespec ts;
+       getboottime(&ts);
+       return sprintf(buf, "%ld.%ld\n", ts.tv_sec, ts.tv_nsec);
+}
+KERNEL_ATTR_RO(hp_uptime);
+
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes
  * section.
  */
@@ -197,6 +207,7 @@ static struct attribute * kernel_attrs[] = {
        &vmcoreinfo_attr.attr,
 #endif
        &rcu_expedited_attr.attr,
+       &hp_uptime_attr.attr,
        NULL
 };


And comments about & review of the patches are also highly appreciated.


The following changes since commit 76b86412c607ba47f43ef7c0535436bca2a660d2:

  fdisk: don't use ptes[] in generic code (2013-06-12 17:39:09 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk23

for you to fetch changes up to 314e07144b26e30a5bd5b0a41fb18fe3020dfe8a:

  hexdump: use simple printing functions when possible (2013-06-16 19:00:33 +0100)

----------------------------------------------------------------
Sami Kerola (15):
      renice: exit with non-zero value when arguments cause warnings
      sfdisk: use libc error printing function, and symbolic exit values
      sfdisk: clean up usage() functions
      sfdisk: use program_invocation_short_name to determine program name
      docs: correct sfdisk --activate instructions
      sfdisk: remove --unhide and related functions
      sfdisk: replace my_warn() with warnx()
      dmesg: convert time format bitfield to enum
      dmesg: add --time-format option
      dmesg: add iso-8601 time format
      docs: add --time-format option and ISO-8601 format to manual
      dmesg: regroup time related options close to each other
      sd-daemon: update files taken from systemd project
      hexdump: remove unnecessary global variables
      hexdump: use simple printing functions when possible

 fdisks/sfdisk.8        |  33 +++-
 fdisks/sfdisk.c        | 451 ++++++++++++++++++-------------------------------
 misc-utils/sd-daemon.c | 100 +++++------
 misc-utils/sd-daemon.h |  14 +-
 sys-utils/dmesg.1      |  22 +++
 sys-utils/dmesg.c      | 214 +++++++++++++----------
 sys-utils/renice.c     |   4 +-
 text-utils/display.c   |  16 +-
 text-utils/hexdump.c   |   4 +-
 text-utils/hexdump.h   |   2 -
 10 files changed, 408 insertions(+), 452 deletions(-)


