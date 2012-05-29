Return-Path: util-linux-owner@vger.kernel.org
Received: from minas.ics.muni.cz ([147.251.4.40]:55813 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab2E2LwU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 07:52:20 -0400
Received: from anxur.fi.muni.cz (anxur.fi.muni.cz [147.251.48.3])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id q4TBjINn024690
	for <util-linux@vger.kernel.org>; Tue, 29 May 2012 13:45:19 +0200
Date: Tue, 29 May 2012 13:45:18 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: util-linux@vger.kernel.org
Subject: flock(1) exit code (enhancement request)
Message-ID: <20120529114518.GI1744@fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

        Hello, util-linux developers!

I use flock(1) from util-linux in my scripts, and with --wait or --nonblock
I would like to be able to distinguish between the "conflicting lock exists"
and "-c <command> exited with code 1" states.

        Of course, I can always wrap the -c argument with something like
bash -c "<original_cmd_and_args> || exit 2" with yet another level of
quoting, but I think it is really ugly.

        This problem can be solved for example by mapping the exit code 1
of the -c command to something else. I.e. to add something like

        -m <number>
        --map-exit-code-1-to <number>

where the exit code of flock(1) would be <number>, iff the -c <command> exits
with code 1.

	The alternative would be to have user-settable exit code for
the "conflicting lock exists" failure.

	What do you think about it? If you agree with the above syntax,
I can of course post a patch to flock(1).

        Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
Please don't top post and in particular don't attach entire digests to your
mail or we'll all soon be using bittorrent to read the list.     --Alan Cox
