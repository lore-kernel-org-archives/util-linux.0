Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab2KPJyw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Nov 2012 04:54:52 -0500
Date: Fri, 16 Nov 2012 10:54:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] umount(recursive): add a cache to the table
Message-ID: <20121116095447.GB20338@x2.net.home>
References: <1353039487-9525-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353039487-9525-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 15, 2012 at 11:18:07PM -0500, Dave Reisner wrote:
> Without this table libmount will not resolve paths, meaning that
> umounting by relative path will fail.

Oh, good catch! Applied, thanks.

It seems better too use mnt_context_get_cache() to make it sensitive
to --no-canonicalize cmdline option (it's used very rarely by some
external helpers (fuse) to make sure that the path won't be
modified.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
