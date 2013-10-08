Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3JHNzi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Oct 2013 09:55:38 -0400
Date: Tue, 8 Oct 2013 15:55:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] various: fix mixing declarations and code compiler
 warnings [smatch]
Message-ID: <20131008135527.GE13559@x2.net.home>
References: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
 <1381183463-1297-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381183463-1297-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 07, 2013 at 11:04:23PM +0100, Sami Kerola wrote:
>  libfdisk/src/dos.c           |  6 +++---
>  libmount/python/pylibmount.c |  3 ++-
>  libmount/python/tab.c        |  3 ++-
>  term-utils/mesg.c            | 10 +++++-----
>  4 files changed, 12 insertions(+), 10 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
