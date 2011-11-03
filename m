Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab1KCKlQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 Nov 2011 06:41:16 -0400
Date: Thu, 3 Nov 2011 11:41:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org
Subject: Re: swapon feature additions
Message-ID: <20111103104113.GA10539@nb.net.home>
References: <20111027194056.GN691@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111027194056.GN691@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 27, 2011 at 03:40:56PM -0400, Dave Reisner wrote:
> 1) Introduce optional libmount support. This involves first refactoring
> reading of /etc/fstab to remove the duplicated code and use callbacks
> instead. Breaking out the functionality into libmount-powered and
> non-libmount-powered code is then much cleaner.

 I'd like to move all swapon(8) functionality to libmount and replace
 the whole swapon(8) by a small libmount based util. Unfortunately,
 swapon/swapoff support in libmount is not implemented yet.

> 2) Teach swapon/swapoff to only look at files or partitions. The use
> case in mind is specifically for unswapping only files at shutdown, as
> partitions can remain mounted without harm.

 This is probably more important, it would be nice to have 
 
    swapoff --all --files-only

> Does this seem reasonable? Is this functionality wanted? Anything else I
> should be aware of?

 Yes, my suggestion is to start with 2) :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
