Return-Path: bensberg@justemail.net
Message-Id: <1414151494.845163.182839433.6F9D2F03@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 4/5] hwclock: Fix --date debug messages
Date: Fri, 24 Oct 2014 13:51:34 +0200
In-Reply-To: <1414150913.842267.182835465.32A1CB8B@webmail.messagingengine.com>
References: <5449BF2E.7040604@gmx.com>
 <1414150913.842267.182835465.32A1CB8B@webmail.messagingengine.com>
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 13:41, Benno Schulenberg wrote:
> On Fri, Oct 24, 2014, at 04:53, JWP wrote:
> > -				  "unexpected results\n"
> > -				  "The command was:\n  %s\n"
> > -				  "The response was:\n  %s"),
> > -			program_invocation_short_name, date_command, date_resp);
> > +			"unexpected results\nThe response was: %s"
> > +			"The command was: %s"),
> > +		      program_invocation_short_name, date_resp, date_command);
> 
> Oh no.  If the user does not use --debug, hwclock will warn that
> a command gave an unexpected result and will print the command
> but not the actual result.  This is silly.

Sorry, I misread.  That's what you get with a \n in the middle of a line.

Benno

-- 
http://www.fastmail.fm - Same, same, but different...
