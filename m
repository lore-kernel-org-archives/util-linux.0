Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35332 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbKQOdD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Nov 2015 09:33:03 -0500
Received: by wmdw130 with SMTP id w130so157541868wmd.0
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 06:33:01 -0800 (PST)
Received: from localhost (56.34.213.162.lcy-01.canonistack.canonical.com. [162.213.34.56])
        by smtp.gmail.com with ESMTPSA id da10sm17193872wjb.22.2015.11.17.06.32.56
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Nov 2015 06:32:57 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH v1 0/2] losetup: support direct-IO to backing file
Date: Tue, 17 Nov 2015 22:32:46 +0800
Message-Id: <1447770768-15358-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The loop direct I/O patches[1] have been merged to linus kernel tree
and will be released in v4.4.

So the two patches provide interfaces for using direct IO/AIO
in losetup.

 include/loopdev.h   |  4 ++++
 lib/loopdev.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 sys-utils/losetup.c | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 75 insertions(+), 2 deletions(-)


[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6

V1:
	- support to set direct IO for 'new' device, such as 
		loseutp --direct-io 1 -f test.img


Thanks,
Ming

