Return-Path: kas@fi.muni.cz
Date: Tue, 5 Jun 2012 16:26:50 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: flock(1) exit code (enhancement request)
Message-ID: <20120605142650.GA19940@fi.muni.cz>
References: <20120529114518.GI1744@fi.muni.cz>
 <20120605114616.GB14536@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120605114616.GB14536@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
: On Tue, May 29, 2012 at 01:45:18PM +0200, Jan Kasprzak wrote:
: >         This problem can be solved for example by mapping the exit code 1
: > of the -c command to something else. I.e. to add something like
: > 
: >         -m <number>
: >         --map-exit-code-1-to <number>
: > 
: > where the exit code of flock(1) would be <number>, iff the -c <command> exits
: > with code 1.
: 
: Not sure if a generic remap for exit(1) is a good solution.

	OK, understood.

: > 	The alternative would be to have user-settable exit code for
: > the "conflicting lock exists" failure.
: 
: Yes, It would be nice to have user-settable exit codes, for:
: 
:     --rc-timeout <num>
:     --rc-conflict <num>

	These two states (timeout and conflict) are mutually exclusive,
so I think only one option would be sufficient. Also, I don't like the
acronym (rc) in the long option.

	I propose the "--conflict-exit-code <num>" name.

: > 	What do you think about it? If you agree with the above syntax,
: > I can of course post a patch to flock(1).
: 
: Send patch.

	The patch follows in a separate message.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
Please don't top post and in particular don't attach entire digests to your
mail or we'll all soon be using bittorrent to read the list.     --Alan Cox
