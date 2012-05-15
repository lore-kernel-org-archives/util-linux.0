Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934Ab2EOJhq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:37:46 -0400
Date: Tue, 15 May 2012 11:37:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] blkid: use get_terminal_width() from ttyutils.h
Message-ID: <20120515093721.GL8268@x2.net.home>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
 <1337071744-7056-4-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337071744-7056-4-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 15, 2012 at 10:49:04AM +0200, Petr Uzel wrote:
>  misc-utils/blkid.c |   29 +----------------------------
>  1 files changed, 1 insertions(+), 28 deletions(-)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Applied, thanks. (I love such patches :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
