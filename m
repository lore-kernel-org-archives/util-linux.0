Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab2JJJdi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 05:33:38 -0400
Date: Wed, 10 Oct 2012 11:33:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Ondrej Oprala <ooprala@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg colorized output
Message-ID: <20121010093334.GH28457@x2.net.home>
References: <50752745.4020607@redhat.com>
 <20121010091926.GE28457@x2.net.home>
 <1349861169.2576.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349861169.2576.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 10, 2012 at 11:26:09AM +0200, Davidlohr Bueso wrote:
> On Wed, 2012-10-10 at 11:19 +0200, Karel Zak wrote:
> > On Wed, Oct 10, 2012 at 09:44:05AM +0200, Ondrej Oprala wrote:
> > > new file mode 100644
> 
> Hehe I actually started doing this last night.
> 
> I'm wondering if we actually need a new lib file for colors. I mean
> AFAICT, dmesg is the only place we want to use it and I don't see that

What about fdisk where we have many dialogs, warnings, hints? :-) It's
not about colors only, but also about bold, etc.

The another possibility is namei(1) where we can provide output
compatible with ls(1), or cal(1), etc.

> changing any time soon - Unix hackers don't like colors, we live oh so
> boring lives :)

All this should be optional. I guess than many people use aliases with
colors

$ alias | grep color
alias egrep='egrep --color=tty'
alias fgrep='fgrep --color=tty'
alias grep='grep --color=tty'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
