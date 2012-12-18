Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab2LRPGK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Dec 2012 10:06:10 -0500
Date: Tue, 18 Dec 2012 16:05:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] sulogin: use the linked lists from list.h for
 consoles list
Message-ID: <20121218150527.GA11679@x2.net.home>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354867258-14206-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 09:00:54AM +0100, Werner Fink wrote:
>  include/consoles.h |    6 ++--
>  lib/consoles.c     |   77 ++++++++++++++++++++++++++++++++--------------------
>  2 files changed, 51 insertions(+), 32 deletions(-)

 Applied, thanks. I have added list_last_entry() to avoid
 consoles->prev usage in the code.o

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
