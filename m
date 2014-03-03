Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbaCCJEp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Mar 2014 04:04:45 -0500
Date: Mon, 3 Mar 2014 10:04:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Davidlohr Bueso <davidlohr@hp.com>,
        Maciej =?utf-8?Q?Ma=C5=82ecki?= <me@mmalecki.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
Message-ID: <20140303090438.GB2783@x2.net.home>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
 <1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
 <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
 <5310B80C.7000205@ubuntu.com>
 <1393612047.2899.31.camel@buesod1.americas.hpqcorp.net>
 <5310E100.5020405@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5310E100.5020405@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 28, 2014 at 02:18:24PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 2/28/2014 1:27 PM, Davidlohr Bueso wrote:
> >> You really want to tell the user that they aren't going to be
> >> able to write up front.
> > 
> > Sure why not, just not in a library! You can do this in the fdisk 
> > program. And if Karel doesn't agree and wants to apply this patch 
> > anyway, then it should *at least* be in DBG context.
> 
> Right, which is what I said just after that ;)

 I'll try to improve the function after libfdisk branch merge into
 master branch (this or next week). The current code is probably
 really not optimal.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
