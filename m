Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbbBPJSo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 04:18:44 -0500
Date: Mon, 16 Feb 2015 10:18:34 +0100
From: Karel Zak <kzak@redhat.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: kerolasa@gmail.com, P@draigbrady.com, mrmazda@earthlink.net,
        util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150216091834.GB11948@ws.net.home>
References: <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <87h9unt6qv.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h9unt6qv.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 15, 2015 at 12:38:32PM -0500, Dale R. Worley wrote:
> Bruce Dubbs <bruce.dubbs@gmail.com> writes:
> > Why not use the LS_COLORS environment variable used by coreutils' dircolors? 
> > Does util-linux need to create something different?

because it's absolutely inelegant solution

 echo $LS_COLORS | wc --bytes
 1710

> The main deficiency of terminal-colors.d is that it's system-wide.  But
> I see this in a blog:
> 
>     $HOME/.config/terminal-colors.d overrides the global setting

it's already implemented.

 http://man7.org/linux/man-pages/man5/terminal-colors.d.5.html

> You also want to define an environment variable to override *that*,
> e.g., files in $UTIL_LINUX_TERMINAL_COLORS override the ones in
> $HOME/.config/terminal-colors.d -- that allows you to set up custom
> environments for particular trees of processes by creating a suitable
> colors directory and setting UTIL_LINUX_TERMINAL_COLORS.

for now it follows 

       $XDG_CONFIG_HOME/terminal-colors.d
       $HOME/.config/terminal-colors.d
       /etc/terminal-colors.d


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
