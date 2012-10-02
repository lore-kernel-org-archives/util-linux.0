Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21620 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2JBIRv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Oct 2012 04:17:51 -0400
Date: Tue, 2 Oct 2012 10:17:41 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        Werner Fink <werner@suse.de>, Ludwig Nussel <ludwig.nussel@suse.de>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>,
        Tobias Powalowski <tpowa@archlinux.org>
Subject: Re: [su] New su utility messes with my PATH
Message-ID: <20121002081741.GA7730@x2.net.home>
References: <50547FE7.204@archlinux.org>
 <50549411.9000302@draigBrady.com>
 <20120920094330.GC16499@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120920094330.GC16499@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 20, 2012 at 11:47:04AM +0200, Karel Zak wrote:
>         commit a6fdd3f8125be23930d955c2bc6b7a46cdaf8a12
>         Author: Werner Fink <werner@suse.de>
>         Date:   Tue Aug 17 09:09:55 2010 +0200
> 
>         make sure /sbin resp /usr/sbin are in PATH
> 
> 
> Werner, Ludwig? What about to revert the patch?

 Reverted.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
