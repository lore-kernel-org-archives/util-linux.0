Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:49454 "EHLO
	resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893AbbBORqq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Feb 2015 12:46:46 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: kerolasa@gmail.com
Cc: kzak@redhat.com, P@draigbrady.com, mrmazda@earthlink.net,
        util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
In-Reply-To: <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com> (kerolasa@iki.fi)
Date: Sun, 15 Feb 2015 12:38:32 -0500
Message-ID: <87h9unt6qv.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola <kerolasa@iki.fi> writes:
> Or add the needed to ncurses. Isn't that better than adding a new
> library?

That would work, but only for utilities that use ncurses.  OTOH, it
would be good if ncurses understood and provided information from the
general color configuration to programs that use it.

Bruce Dubbs <bruce.dubbs@gmail.com> writes:
> Why not use the LS_COLORS environment variable used by coreutils' dircolors? 
> Does util-linux need to create something different?

Using an environment variable is the standard Unix way of configuring
the user-oriented behavior of programs.  But the "definition" of
LS_COLORS seems to be very specific to "ls".

The /etc/terminal-colors.d system seems a bit oversized (all those
files!), but it seems unlikely that anything simpler would work for a
large set of utilities, each of which the user may want to customize.

The main deficiency of terminal-colors.d is that it's system-wide.  But
I see this in a blog:

    $HOME/.config/terminal-colors.d overrides the global setting

so that is taken care of.

You also want to define an environment variable to override *that*,
e.g., files in $UTIL_LINUX_TERMINAL_COLORS override the ones in
$HOME/.config/terminal-colors.d -- that allows you to set up custom
environments for particular trees of processes by creating a suitable
colors directory and setting UTIL_LINUX_TERMINAL_COLORS.

Dale
