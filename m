Return-Path: johannes@sipsolutions.net
Message-ID: <1498745040.3141.6.camel@sipsolutions.net>
Subject: Re: rfkill(8) move and improvements
From: Johannes Berg <johannes@sipsolutions.net>
To: Sami Kerola <kerolasa@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
	Tim Gardner <tim.gardner@canonical.com>, Karel Zak <kzak@redhat.com>
Cc: linux-wireless@vger.kernel.org, util-linux@vger.kernel.org
Date: Thu, 29 Jun 2017 16:04:00 +0200
In-Reply-To: <alpine.LNX.2.20.1706251339500.25762@imuri> (sfid-20170625_150452_207599_1328128A)
References: <alpine.LNX.2.20.1706251339500.25762@imuri>
	 (sfid-20170625_150452_207599_1328128A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Hi Sami, all,

> The otherday I ran powertop and it did rfkill to save battery, which
> was particularly annoying because I had not installed rfkill(8)
> package.  
> Fixing the immediate issue was relatively easy, but the ordeal made
> me wonder if this tool could be moved to a package that is installed
> by default to all systems, such as util-linux.

[...]

> What do you think, would the move and proposed updates be ok?

I can't say I mind, and most of your proposed changes seem sensible,
though I haven't reviewed them in enough detail to comment on them.
Something that caught my eye here was comparing a string to _("all")
which seems wrong, since that'd mean you'd have to type the translated
version even on the command line? That seems really awkward (to put it
charitably).

However, at the same time, I have very little desire to get involved
with util-linux as yet another project, so frankly I'd probably
continue to "maintain" the current rfkill tool - which really hasn't
changed in a very long time, and hope somebody else picks up
maintenance of rfkill included in util-linux.

johannes
