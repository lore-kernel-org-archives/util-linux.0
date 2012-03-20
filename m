Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202Ab2CTKJ2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Mar 2012 06:09:28 -0400
Date: Tue, 20 Mar 2012 11:09:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 5/5] findmnt: add -D, --df option to imitate df(1)
Message-ID: <20120320100923.GI3956@x2.net.home>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
 <1332041793-7919-5-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332041793-7919-5-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 17, 2012 at 11:36:33PM -0400, Dave Reisner wrote:
>  misc-utils/findmnt.8 |    3 +++
>  misc-utils/findmnt.c |   20 ++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

 Applied, thanks.

 I have added built-in filter to filter out pseudo filesystems for the
 df output and new --all option to disable this filter.

    Karel

 PS. yes, we have to fix (=de-duplicate) our and df(1) output, this is
     still on TODO list.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
