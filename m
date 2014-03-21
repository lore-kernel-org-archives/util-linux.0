Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760120AbaCUNLS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Mar 2014 09:11:18 -0400
Date: Fri, 21 Mar 2014 14:10:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Maciej =?utf-8?Q?Ma=C5=82ecki?= <me@mmalecki.com>,
        Davidlohr Bueso <davidlohr@hp.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
Message-ID: <20140321131003.GF26374@x2.net.home>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
 <1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
 <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
 <5310B80C.7000205@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5310B80C.7000205@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 28, 2014 at 11:23:40AM -0500, Phillip Susi wrote:
> You really want to tell the user that they aren't going to be able to
> write up front.
> 
> I have to say this function was already broken.  If the caller
> requests write access and that fails, then the call should fail.  It
> should *not* automatically fall back to read-only without giving any
> indication to the caller.  If the caller wants to retry for read only,
> then it can, and print a warning letting the user know it has switched
> to ready only.

 I agree, implemented. The function does not fallback to read-only mode
 now -- all has to be controlled by caller.

 Thanks Maciej for your report!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
