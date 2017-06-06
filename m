Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:38160 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdFFRMz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Jun 2017 13:12:55 -0400
Message-ID: <5936E292.4000709@tlinx.org>
Date: Tue, 06 Jun 2017 10:12:50 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Patch: ensure mount & umount are root-owned before setting SUID bit
References: <5935E44B.8000405@tlinx.org> <20170606093607.xrxel4ny4hjoe4iv@ws.net.home> <5936B8E5.8050901@tlinx.org> <5936C623.4030205@tlinx.org> <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com> <5936D40E.3040000@tlinx.org>
In-Reply-To: <5936D40E.3040000@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

L A Walsh wrote:
>
>
> Maybe the install should check to see
> if it is root before setting a SUID bit on the executable?
Maybe this can be applied to source tree sometime before nxt release?
Won't help if you are running the make as 'root', but at least
it will flag an error when you try to "make install" it...

tnx,
-l


-----
--- Makefile.in    2017-05-23 03:21:36.000000000 -0700
+++ Makefile.in    2017-06-06 10:09:12.318352218 -0700
@@ -12332,7 +12332,9 @@
 @BUILD_SETARCH_TRUE@    done
 
 @BUILD_MOUNT_TRUE@@MAKEINSTALL_DO_SETUID_TRUE@install-exec-hook-mount:
+@BUILD_MOUNT_TRUE@@MAKEINSTALL_DO_SETUID_TRUE@    chown root:root 
$(DESTDIR)$(bindir)/mount
 @BUILD_MOUNT_TRUE@@MAKEINSTALL_DO_SETUID_TRUE@    chmod 4755 
$(DESTDIR)$(bindir)/mount
+@BUILD_MOUNT_TRUE@@MAKEINSTALL_DO_SETUID_TRUE@    chown root:root 
$(DESTDIR)$(bindir)/umount
 @BUILD_MOUNT_TRUE@@MAKEINSTALL_DO_SETUID_TRUE@    chmod 4755 
$(DESTDIR)$(bindir)/umount
 
 @BUILD_BASH_COMPLETION_TRUE@@BUILD_RUNUSER_TRUE@install-data-hook-bashcomp-runuser::

