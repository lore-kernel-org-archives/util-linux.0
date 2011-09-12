Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082Ab1ILMEZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Sep 2011 08:04:25 -0400
Date: Mon, 12 Sep 2011 14:04:22 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] build all and check with smatch
Message-ID: <20110912120422.GB16902@nb.net.home>
References: <CAG27Bk1tGhRf5yJaZfn7bR7ZQASmpomisUt-oATvBt223Hgn7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1tGhRf5yJaZfn7bR7ZQASmpomisUt-oATvBt223Hgn7A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 10, 2011 at 05:07:00PM +0200, Sami Kerola wrote:
> The first patch is about me being tired to write lots of --enable-* if
> I want to try to compile all programs. The smatch(1) seems to give
> valuable output where there might be problems in code. I went though

 Cool! More static analyzes, more regression tests, more reviews --
 that's what we need.

 I have added 'checksmatch' target, so if you have smatch and cgcc in
 your $PATH then you can use

    make checksmatch

 or

    make -C dir/ checksmatch

> Documentation/howto-compilation.txt which possibly should have
> separated debugging section.

 We have Documentation/howto-debug.txt

> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit smatch

 Merged, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
