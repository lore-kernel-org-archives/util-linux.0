Return-Path: bensberg@justemail.net
Message-Id: <1407341083.485189.149814161.10AFC682@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>, Sami Kerola <kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: add one-line descriptions to each program usage()
Date: Wed, 06 Aug 2014 18:04:43 +0200
In-Reply-To: <20140806132727.GI19820@x2.net.home>
References: <20140806132727.GI19820@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


On Wed, Aug 6, 2014, at 15:27, Karel Zak wrote:
> https://github.com/stevenhoneyman/util-linux/commit/d5b828e418102b354025bbf7f91b2dcdfc1f4e66
> 
> the idea is to add one-line descriptions to each program usage().

Yes, docstrings are a good idea.

>  Anyway, the patch is not ready. I don't like the command name in the
>  description -- it's redundant.

Furthermore, each docstring should be a full, grammatical sentence, not
the telegram style used in the NAME section of man pages.  And each of
them should start with a capital and end with a period.  And, if needed,
it may also cover two lines.

>  Maybe it would be better to move the description above Options
>  section.

Yes, that is a better place for them.  That is where coreutils puts them,
too.

As an example, the docstring of the following three commands should
probably be the same: "Display or manipulate a disk partition table.\n":

> fputs(_("fdisk - manipulate disk partition table\n"), out);
> fputs(_("sfdisk - partition table manipulator for Linux\n"), out);
> fputs(_("cfdisk - display or manipulate a disk partition table\n"), out);

Or if not, then the docstrings should make clear how these three differ.

By the way, the scripted grabbing of the first line of the man page as
a docstring has gone wrong for the swapoff command.

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own
