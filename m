Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48448 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab3KSTtp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Nov 2013 14:49:45 -0500
Message-ID: <528BC0D7.2090006@ubuntu.com>
Date: Tue, 19 Nov 2013 14:49:43 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] setsid: don't fork
References: <1384456993-3721-1-git-send-email-psusi@ubuntu.com> <20131119132412.GG5572@x2.net.home> <528B7D4C.1030405@ubuntu.com> <20131119180556.GN5572@x2.net.home>
In-Reply-To: <20131119180556.GN5572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/19/2013 1:05 PM, Karel Zak wrote:
> but why you don't want --wait behavior? It does not change
> anything, but fix the problem with group leader.

I *do* want that behavior, I just think it was supposed to have been
that way all along and which behavior you get should NOT depend on
whether it is a group leader or not.

> IMHO we can make it (--wait) the default (you almost convinced me 
> that the default behaviour should be fixed).

Why even have the option then?  Does anyone actually want the non wait
behavior?  If they have to add a switch to get it, they may as well
just have the shell background the job.  Simpler and cleaner than a
switch.

> fork for sleep() and then kill it

Why is that worse than fork then exec?  And I thought swapping the
group leader so the parent process can call setsid() was pretty clever ;)

> I'm also not sure if remove --wait is the best way... what about 
> people who already use it? (yep, it's release few weeks ago,
> but...)

The longer it stays in, the more people will use it.  Best to get rid
of it now if it wasn't such a great idea, otherwise it will be there
forever.

> If I good understand the man page then setsid() caller is session
> and group leader of the *new* session and group. It's probably
> unwanted to make the original group orphaned (without leader),
> because processes in orphaned group get SIGCONT from kernel...
> 
> (BTW, SIGCONT is probably what will happen in your version after 
> kill(pid) as the sleeping child is group leader, right?)

I think that happens the old way too: as soon as setsid exits after
successfully forking the child, then the group is orphaned.  In other
words, both setpgrp() and exit() remove this process from being the
group leader.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSi8DXAAoJEJrBOlT6nu75N+AH/1qyxjdJ2h+nJgN6BhIQ5WfN
SaEbSmVPGFKEFKS3ltVnH+aGfS9WJiQO5DitNewrqOlek3VSvwG3T9WZRmDPjg0M
gSaTPQMVFDIAcMcaUt71AXBEMxHLZUI5rEDLwXraaDT9ISGSGjCNRpfTrwSCwiHY
jUrulunvS0z2WkqyJbHjQZK19Z0waOEvUO7KH8UK/BWqZ2ybCHvCmC1D/uq3K09A
1dmavup13NNbxF7mG80QqdWfm9nN54N1sQ8iPUrzrQyW/6b29aSfUr74JMKbbSzt
Rodimqio/sYpf7iSbMDA4+Gmswh//IANOf9235h8s5LDb1EghSdVzl5ktu+2aLU=
=ZK8O
-----END PGP SIGNATURE-----
