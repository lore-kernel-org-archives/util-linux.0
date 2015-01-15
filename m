Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58407 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbbAOK7N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Jan 2015 05:59:13 -0500
Date: Thu, 15 Jan 2015 11:59:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [jwilk@debian.org: Bug#775374: blkid: buffer over-read]
Message-ID: <20150115105905.GI28019@x2.net.home>
References: <20150115095722.GA13565@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150115095722.GA13565@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 15, 2015 at 10:57:22AM +0100, Andreas Henriksson wrote:
> Jakub Wilk has been performing fuzz testing and found a crash bug in
> blkid that seems to be from reading from a buffer out of bounds.
> 
> Original message quoted below. Test file attached.
> 
> Original bug report is also available at:
> http://bugs.debian.org/775374

 Fixed by commit 861b11d5e24c5db463463fb6c047e72456597a5b.

 Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
