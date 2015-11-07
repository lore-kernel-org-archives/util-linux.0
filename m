Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32984 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbKGAk2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 6 Nov 2015 19:40:28 -0500
Received: by igvi2 with SMTP id i2so44304673igv.0
        for <util-linux@vger.kernel.org>; Fri, 06 Nov 2015 16:40:28 -0800 (PST)
Received: from localhost (27.34.213.162.lcy-01.canonistack.canonical.com. [162.213.34.27])
        by smtp.gmail.com with ESMTPSA id kb7sm662930igb.11.2015.11.06.16.40.26
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Nov 2015 16:40:27 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] losetup: support direct-IO to backing file
Date: Sat,  7 Nov 2015 08:40:16 +0800
Message-Id: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The loop direct I/O patches[1] have been merged to linus kernel tree
and will be released in v4.4.

So the two patches provide interfaces for using direct IO/AIO
in losetup.

 include/loopdev.h   |  4 ++++
 lib/loopdev.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 sys-utils/losetup.c | 30 +++++++++++++++++++++++++++---
 3 files changed, 71 insertions(+), 3 deletions(-)

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6

Thanks,
Ming

