Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23620 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbaJGJvO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 05:51:14 -0400
Date: Tue, 7 Oct 2014 11:51:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Christoph Hoopmann <christophhoopmann@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug: libfdisk/dos.c: Extended partition number == 1? -> crash
Message-ID: <20141007095111.GC8057@x2.net.home>
References: <5432D698.1000903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5432D698.1000903@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 06, 2014 at 07:51:20PM +0200, Christoph Hoopmann wrote:
> seems like I discovered a crash in util-linux-2.25.1:
... 
> fdisk: libfdisk/src/dos.c:1161: add_logical: Assertion
> 'self_label(cxt)->ext_index' failed

 The assert() is nonsense, ext_index=0 is absolutely valid. Sorry.
 Fixed in master branch, will be in fixed in 2.25.2 too. Thanks!

> During testing of this bug, I noticed a second crash when writing the
> partition table to the harddisk. I'm not aware of how to reproduce it.

 hmm... 
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
