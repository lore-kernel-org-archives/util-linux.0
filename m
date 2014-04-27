Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.103]:8670 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbaD0UJm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:09:42 -0400
Message-ID: <535D6026.1000709@zoho.com>
Date: Sun, 27 Apr 2014 21:53:10 +0200
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: nyerup@one.com
CC: util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
References: <20140425082133.GA3790@one.com>
In-Reply-To: <20140425082133.GA3790@one.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25/04/14 10:21, Jesper Dahl Nyerup wrote:
> Hi list,
>
> We're toying with the idea of using script(1) to log all user sessions
> towards a collection of systems, as one in a number of metheds to aid
> debugging, education and auditing.
>
> In order to do so, I have a couple of questions regarding a few
> extensions we're considering to implement.
>
> Firstly, script(1) is clearly and sanely designed to be invoked from the
> command line to record a limited portion of a user's session. In order
> for the user to have the logging started without manual invocation, it
> may come in handy to support config files, to supply configurable
> default values for some of the concepts normally passed in the
> environment or as command line arguments.

You can start it from a script acting as the user shell, through sshd 
config or one of the shell init scripts. As you already need to start 
script somehow, those defaults could be passed there, too (although I 
don't see a problem with supporting config files either).


> Secondly, we're considering to add functionality for script(1) to
> transmit the session transcript over the network to a collection daemon,
> to be able to store transcripts from multiple machines on one or more
> central systems.
>
> This could involve:
>
> 1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> scriptcollect(1), to be in the receiving end of the traffic, optionally
> handling the timing functionality, and finally storing data in the same
> manner script(1) would.

I'm unsure about this bit. It may be needed. Perhaps a transfer after 
the session finishes also works.


> 2. Optionally linking against some crypto library to avoid putting
> users' console data on the wire in clear text.

Following unix philosophy, I would try to avoid reinventing crypto into 
the program, attempting instead to solve the issue by eg. using sftp to 
transfer the files and/or gpg to encrypt the data.



PS: I expect you are properly warning your users about the fascist-level 
logging done on your systems.

