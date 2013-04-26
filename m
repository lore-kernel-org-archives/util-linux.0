Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3DZLi7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Apr 2013 07:38:59 -0400
Date: Fri, 26 Apr 2013 13:38:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 05/33] bash-completion: prefer bash 3.x 'here string'
 syntax
Message-ID: <20130426113849.GE4839@x2.net.home>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
 <1365882901-11429-6-git-send-email-kerolasa@iki.fi>
 <20130413215913.GF11968@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130413215913.GF11968@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 13, 2013 at 05:59:13PM -0400, Dave Reisner wrote:
> On Sat, Apr 13, 2013 at 08:54:33PM +0100, Sami Kerola wrote:
> > The '< <' syntax is bash 2.x trick, and <<< does the same job when bash
> > 3.x is in use.  For some unknown reason my bash 4.2.45(2)-release became
> > allergic to old syntax today(?).
> 
> I don't follow this. The syntax is <(commands), which is a process
> substitution. It creates a temporary file descriptor which can be
> redirected via <. It still very much works, and I don't expect this to
> break any time soon. It's likely more memory efficient since there's no
> need to expand the output in place -- it can just be read off of the
> file descriptor.
> 
> I think you should figure out what's wrong with your shell instead of
> doing this.

 Sami?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
