Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbdEQVJ6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 17:09:58 -0400
Date: Wed, 17 May 2017 23:09:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: versioning
Message-ID: <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com>
 <201705172107.49456.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201705172107.49456.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 17, 2017 at 09:07:49PM +0200, Ruediger Meier wrote:
> I'm not talking about making things incompatible just to be incompatible 
> but about ugly, outdated ifdefs which probably nobody needs anymore but 
> also nobody would touch unless we actively review this.

This would be better to discuss per patch. I don't think the current
code is affected by many obscure #ifdef and if we have #ifdef then
it's usually to be compatible with some libc, non-linux systems, old
gcc, etc.

Anyway, it seems the conclusion is to continue with vX.Y.Z :-)

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
