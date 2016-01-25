Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.prgmr.com ([71.19.149.6]:45792 "EHLO mail.prgmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184AbcAYVj3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Jan 2016 16:39:29 -0500
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
To: Karel Zak <kzak@redhat.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home> <56A1596C.3060507@prgmr.com>
 <56A25241.8050000@imap.cc> <56A27F92.6020309@prgmr.com>
 <CAG27Bk1xN6RccvCKwurdftkHkvS86Mi5VnA-8UiP7Y0peuh02A@mail.gmail.com>
 <20160123162241.pwvqxyfm4qv2apgo@ws.net.home>
Cc: "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
From: Sarah Newman <srn@prgmr.com>
Message-ID: <56A6960F.4070404@prgmr.com>
Date: Mon, 25 Jan 2016 13:39:27 -0800
MIME-Version: 1.0
In-Reply-To: <20160123162241.pwvqxyfm4qv2apgo@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/23/2016 08:22 AM, Karel Zak wrote:
> On Fri, Jan 22, 2016 at 10:03:47PM +0000, Sami Kerola wrote:
>> Alternatively one could make swapon to get rid of all permission bits
>> and set ownership to UID 0 by default when ever it activates a
>> swapfile. How about that.
> 
> Not sure if want to change any permissions on the fly, it would be
> better to reject files (by swapon) with insecure permissions and
> require something like --force for crazy users who wants to ignore
> this problem.

Rejecting insecure permissions in swapon will make warnings in mkswap even more important. Are there any further changes required to Wayne's latest
patch to mkswap.c https://marc.info/?l=util-linux-ng&m=145327019508709&w=2 before it is merged?

Thanks, Sarah

