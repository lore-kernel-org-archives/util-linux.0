Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47947 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbbFKJDt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Jun 2015 05:03:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id B5B5720847
	for <util-linux@vger.kernel.org>; Thu, 11 Jun 2015 05:03:48 -0400 (EDT)
Message-Id: <1434013428.75585.292665745.17FBFAD5@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Martin Steigerwald <ms@teamix.de>,
        "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20150609092412.GG1992@ws.net.home>
References: <716925135.onXIMLDpa0@merkaba> <20150609092412.GG1992@ws.net.home>
Subject: Re: chrt: inconsistency in --help
Date: Thu, 11 Jun 2015 11:03:48 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jun 9, 2015, at 11:24, Karel Zak wrote:
> On Tue, Jun 09, 2015 at 10:37:46AM +0200, Martin Steigerwald wrote:
> > Set policy:
> >   chrt [options] [-p] [<policy>] <priority> [<pid> | <command> [<arg>...]]
> 
>  Yes, I have modified --help output to this

Well, -p is just one of the possible options, so it could be simply
subsumed under [options].  Also, the brackets around "<pid> | <command>
[<arg>..." seem to say that both <pid> and <command> are optional,
but they are not when the <priority> is given.  Furthermore, <policy>
seems to suggest it is something like "WORD" or "name" or "12345",
but in fact it is a certain type of option, starting with a dash.
So I think the current synopsis is rather confusing.

The man page summarizes the command as follows:
    chrt [options] priority command [argument...]
    chrt [options] -p [priority] pid

The first line shows how to run a command with certain attributes,
the second how to query or modify the attributes of an existing process.
Quite clear.

So, to make usage synopsis clearer and correct I would suggest
rewriting it as:

Set policy:
    chrt [options] <priority> <command> [<arg>...]
    chrt [options] -p <priority> <pid>

The first of the upcoming two patches makes this change.

Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

