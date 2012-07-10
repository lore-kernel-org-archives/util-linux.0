Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338Ab2GJL4K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jul 2012 07:56:10 -0400
Date: Tue, 10 Jul 2012 13:56:06 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] /run directory and swapon
Message-ID: <20120710115606.GG5281@x2.net.home>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 27, 2012 at 11:33:25PM +0200, Sami Kerola wrote:
> Sami Kerola (8):
>       build-sys: change --localstatedir to /run
>       libuuid: use run configured state directory
>       agetty: use configured run state directory
>       uuidd: use configured run state directory in manual etc

>       libuuid: make pseudo random file save path configurable

 this one is not applied

>       swapon: add --show option
>       swapon: make --show size to be human readable by default
>       swapon: fix --summary output regression

 the rest is in master branch (with some minor changes).

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
