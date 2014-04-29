Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55048 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbaD2Qwc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 Apr 2014 12:52:32 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so447647pdb.37
        for <util-linux@vger.kernel.org>; Tue, 29 Apr 2014 09:52:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140429104640.GC24681@x2.net.home>
References: <20140429104640.GC24681@x2.net.home>
Date: Tue, 29 Apr 2014 17:52:28 +0100
Message-ID: <CAG27Bk3vrfPb2qktGDpmpNYqi7nRcTfNDOZJgzBbn2+j_6rZWw@mail.gmail.com>
Subject: Re: terminal-colors.d and termname
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2014 11:46, Karel Zak <kzak@redhat.com> wrote:
>  I'd like to support terminal names ($TERM) in terminal-colors.d,
>  because the current implementation does not care about terminal
>  types, so you can disable/enable the colors only globally for all
>  terminals. That's stupid, because xterm-256color is not the
>  same thing as vt100, etc.
>
>  possible ways:
>
>  1) add terminal name to the file names, for example
>
>     touch terminal-colors.d/dmesg@vt100.disable
>
>  The disadvantage is that there is huge number of terminals and
>  this concept does not allow to use patterns (e.g. fnmatch() patterns
>  like xterm-*). But I think the patterns are unnecessary, because people
>  usually use very small set of terminals (serial line, ssh, xterm), so
>  force users to use whole terminal names is no so big problem.
>
>  The advantage is the we can use this concept for color schemes and
>  support symlinks to reuse the same scheme for a different terminals.
>  The nice things is also that one readdir() is enough to get whole
>  configuration.
>
>    echo "error red standard" > dmesg@xterm.scheme
>    ln -s dmesg@xterm.scheme dmesg@linux.scheme
>
>  2) use sub-directory
>
>     /etc/terminal-colors/<termname>/dmesg.disable
>
>  but it's less readable (you need "ls -R" or "find") and use symlinks
>  will be nightmare.
>
>
>  3) store the terminal names (or patterns) to the files
>
>     echo "TERM vt10*" >> dmesg.disable
>
>  The same way uses coreutils DIR_COLORS. This concept means that we
>  have to always parse the files and you cannot easily create two
>  independent color schemes for the same util as there is only one
>  'dmesg.scheme', so we will need more advanced file format with
>  multiple sections, etc.
>
>  4) ?
>
>
>  I prefer 1) because it's KISS concept and we have a chance to see
>  this way supported by another projects too.

Hi Karel,

Does this image summarize the logic that you are describing?

http://ut3.org/~kerolasa/ul-bikeshed.png

What comes to proposed options (IMHO) 1 seems to better than 2 or 3 to
find yes/no answers. For matching meanings with colors some sort of
syntax is probably needed, such as "error red standard" where a color
red seems to mean an error; which leaves it to be commands problem to
determine what is an error.  I do not know what you meant with word
standard.

Over-complicating a bit, or forgetting KISS for now. There seems to be
nearly infinite colors, and possibly infinite meanings. Designing an
interface that will support such may result to be too difficult to
understand. Maybe limiting meanings to a finite set, such as what
syslog has done with levels and facilities, gives enough flexibility
without being impossible to use. Sticking to syslog definitions has
one thing favoring such decision; unixian people are already familiar
with the concept. Downside is that some syslog keywords (LOG_UUCP)
feel a bit legacy. That in mind the syntax could look something like

facility:level:#FFFFFF
facility:level:red

where the later is using the named colors there happens to be. Was
that too beoynd KISS?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
