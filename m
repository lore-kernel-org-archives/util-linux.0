Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeAVK2M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 05:28:12 -0500
Date: Mon, 22 Jan 2018 11:28:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] some build-sys cosmetics
Message-ID: <20180122102809.qrdzzj2jyknz6ryd@ws.net.home>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 20, 2018 at 07:06:19PM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> All these patches are more less just cosmetics. The first one
> "remove generated headers from dist tar ball" is the only
> one which should have a visable effect at all.
> 
> Ruediger Meier (5):
>   build-sys: remove generated headers from dist tar ball
>   build-sys: automake is able to find headers in builddir ...
>   build-sys: remove unneeded dependencies on bla.h.in
>   build-sys: avoid using prog_DEPENDENCIES
>   build-sys: remove redundant EXTRA_DIST files

 make distcheck
 make install DESTDIR=somewhere

pass, so you have to be right :-) Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
