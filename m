Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbbLGLeL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Dec 2015 06:34:11 -0500
Date: Mon, 7 Dec 2015 12:34:09 +0100
From: Karel Zak <kzak@redhat.com>
To: David Wilson <dw@botanicus.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
Message-ID: <20151207113409.GC2353@ws.net.home>
References: <20151206042923.GA6570@k3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151206042923.GA6570@k3>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 06, 2015 at 04:29:23AM +0000, David Wilson wrote:
> This is just shorthand for an increasingly necessary yet cumbersome and
> error-prone "grep -v" pipe. The alternative was to extend -t to accept
> "nopseudofs", but that is tougher on the fingers.

 I don't plan to improve mount(8) list output in any way to duplicate
 findmnt(8). Please, let's use (and improve) findmnt(8). Thanks.

 Anyway,

     --real
     --net
     --pseudo
 
 sounds good for findmnt. Look forward for a patch :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
