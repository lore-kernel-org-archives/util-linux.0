Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:44891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbeI1TJK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 Sep 2018 15:09:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/2] unshare: add some chroot magic
Date: Fri, 28 Sep 2018 14:45:10 +0200
Message-Id: <20180928124512.13979-1-laurent@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This couple of patches merges "unshare chroot" in one command.
Parameter names are copied from nsenter.
Doing like this the /proc filesystem is correctly mounted in the
new root with "--mount-proc".

Laurent Vivier (2):
  unshare: allow to set a new root
  unshare: allows to set user ID and group ID

 bash-completion/unshare |  6 ++++-
 sys-utils/unshare.1     | 13 ++++++++++
 sys-utils/unshare.c     | 53 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.17.1
