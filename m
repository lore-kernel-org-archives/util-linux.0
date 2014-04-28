Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbaD1HN1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 03:13:27 -0400
Date: Mon, 28 Apr 2014 09:13:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesper Dahl Nyerup <nyerup@one.com>
Cc: util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140428071320.GK2405@x2.net.home>
References: <20140425082133.GA3790@one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140425082133.GA3790@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 25, 2014 at 10:21:34AM +0200, Jesper Dahl Nyerup wrote:
> Firstly, script(1) is clearly and sanely designed to be invoked from the

 Well, from my point of view it current code is a bit fragile regards
 to signals. Maybe it would be nice to use signalfd() and check for
 signals together with changes on master/slave file descriptors by
 select/poll. But this is not so important for your plans.

> command line to record a limited portion of a user's session. In order
> for the user to have the logging started without manual invocation, it
> may come in handy to support config files, to supply configurable
> default values for some of the concepts normally passed in the
> environment or as command line arguments.

 OK.

> Secondly, we're considering to add functionality for script(1) to
> transmit the session transcript over the network to a collection daemon,
> to be able to store transcripts from multiple machines on one or more
> central systems.

 Hmm.. "Every program attempts to expand until it can read mail. Those
 programs which cannot so expand are replaced by ones which can."

 I like git concept: here are files and it's your problem to transfer the
 staff over the network. You can use rsync, http, ssh, ...

 Maybe all you need is to store timing and typescript data to the one
 place (e.g. /var/log/typescripts/user/<timestamp>.{session,timing})
 and use ssh or so to transfer the data to another place.

> 1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> scriptcollect(1), to be in the receiving end of the traffic, optionally
> handling the timing functionality, and finally storing data in the same
> manner script(1) would.

 Seem like overkill.

> 2. Optionally linking against some crypto library to avoid putting
> users' console data on the wire in clear text.

 Yep, but we have generic solutions like ssh, again see git.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
