Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63318 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab3I3MJK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Sep 2013 08:09:10 -0400
Date: Mon, 30 Sep 2013 14:09:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Namhyung Kim <namhyung@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: Save errno if mkostemp() failed
Message-ID: <20130930120907.GM5101@x2.net.home>
References: <1380449497-3298-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380449497-3298-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 29, 2013 at 07:11:37PM +0900, Namhyung Kim wrote:
> After mkostemp() failed, umask() and free() might alter the errno

 I don't think umask and free alter errno, but

> to another value.  Not sure those calls really changes the errno
> or not.  But let's be more conservative.

 ok, it seems more readable then the old version. Applied, thanks. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
