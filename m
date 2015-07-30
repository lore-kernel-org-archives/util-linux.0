Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbbG3Jzo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jul 2015 05:55:44 -0400
Date: Thu, 30 Jul 2015 11:55:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] pull: minix updates
Message-ID: <20150730095542.GK6865@ws.net.home>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 24, 2015 at 09:15:07AM +0100, Sami Kerola wrote:
> The patch 0001 is not re-submitted.  It is the change Joshua Hudson sent
> to mail list couple days ago.  The rest are new changes, and they are
> also available from my remote branch 'minix'.

Merged from inbox (the stuff on github seems broken, see
https://github.com/kerolasa/lelux-utiliteetit/commit/8f15af61755fd0f2ee03f34f20ee8dccfd6f529a
where is also some bus-server.c ...).

It would be really really nice to have regression tests before
v2.27-rc2, I guess we need to test all versions (1,2,3) and all
possible namelens with mkfs.minix, fsck.minix and mount(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
