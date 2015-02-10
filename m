Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbbBJK0k (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 05:26:40 -0500
Date: Tue, 10 Feb 2015 11:26:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: use monotonic time to fsck run time measurement
Message-ID: <20150210102629.GA19845@ws.net.home>
References: <1422989463-906-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422989463-906-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 03, 2015 at 06:51:03PM +0000, Sami Kerola wrote:
>  disk-utils/Makemodule.am |  4 ++--
>  disk-utils/fsck.c        | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
