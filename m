Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab2BVLBe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Feb 2012 06:01:34 -0500
Date: Wed, 22 Feb 2012 12:01:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH] libmount: remove teaser proto for mnt_table_get_name
Message-ID: <20120222110125.GC29970@x2.net.home>
References: <1329884194-7269-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329884194-7269-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 21, 2012 at 11:16:34PM -0500, Dave Reisner wrote:
> I want my money back! I really wanted to use this function in an error
> callback. =P

 there is parser error callback and it provides the filename

>  libmount/docs/libmount-sections.txt |    1 -
>  libmount/src/libmount.h.in          |    1 -
>  libmount/src/libmount.sym           |    1 -
>  3 files changed, 0 insertions(+), 3 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
