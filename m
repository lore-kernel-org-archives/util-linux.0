Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421Ab2EWI02 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 04:26:28 -0400
Date: Wed, 23 May 2012 10:26:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/utils: Use binary search to compare pseudofs
Message-ID: <20120523082625.GP14560@x2.net.home>
References: <1337532472.2677.19.camel@offbook>
 <1337533047-19151-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337533047-19151-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 20, 2012 at 12:57:27PM -0400, Dave Reisner wrote:
>  libmount/src/utils.c |   69 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 25 deletions(-)

 Good idea. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
