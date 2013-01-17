Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:37130 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567Ab3AQAdl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jan 2013 19:33:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home>
Date: Wed, 16 Jan 2013 16:33:29 -0800
In-Reply-To: <20130114082846.GA16421@x2.net.home> (Karel Zak's message of
	"Mon, 14 Jan 2013 09:28:46 +0100")
Message-ID: <87a9s8lkbq.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 0/5] nsenter review comment fixes.
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Fair enough review comments all.  Here are my tested incremental fixes.

 include/namespace.h |   43 +++++++++++++++++++++++
 sys-utils/nsenter.c |   94 +++++++++++++++++++++++----------------------------
 sys-utils/unshare.c |   29 +---------------
 3 files changed, 86 insertions(+), 80 deletions(-)

Eric W. Biederman (5):
      nsenter: Enhance waiting for a child process
      nsenter: Properly spell significant in a comment.
      nsenter: Add const to declarations where possible.
      nsenter: Replace a bare strtoul with strtoul_or_err
      unshare,nsenter:  Move the old libc handling into a common header namespace.h
