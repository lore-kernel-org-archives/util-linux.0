Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.134]:47863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJESHx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Oct 2018 14:07:53 -0400
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 0/2] unshare: add some chroot magic
Date: Fri,  5 Oct 2018 13:09:28 +0200
Message-Id: <20181005110930.14615-1-laurent@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This couple of patches merges "unshare chroot" in one command.
Parameter names are copied from nsenter.
Doing like this the /proc filesystem is correctly mounted in the
new root with "--mount-proc".

v2: allow to use --wd without --root
    fix a bug when we use --mount-proc with --root
    -> don't remount /proc to none
    fix tabulation

Laurent Vivier (2):
  unshare: allow to set a new root
  unshare: allow to set user ID and group ID

 bash-completion/unshare |  6 +++-
 sys-utils/unshare.1     | 13 +++++++++
 sys-utils/unshare.c     | 62 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 73 insertions(+), 8 deletions(-)

-- 
2.17.1
