Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2EOJfP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:35:15 -0400
Date: Tue, 15 May 2012 11:34:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/4] libuuid,uuidd: move read_all to include/all-io.h
Message-ID: <20120515093449.GJ8268@x2.net.home>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
 <1337071744-7056-2-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337071744-7056-2-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 15, 2012 at 10:49:02AM +0200, Petr Uzel wrote:
>  include/all-io.h       |   25 +++++++++++++++++++++++++
>  libuuid/src/gen_uuid.c |   26 +-------------------------
>  misc-utils/uuidd.c     |   24 ------------------------
>  3 files changed, 26 insertions(+), 49 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
