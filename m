Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaJAIHB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 04:07:01 -0400
Date: Wed, 1 Oct 2014 10:06:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>, Sami Kerola <kerolasa@iki.fi>
Subject: Re: add one-line descriptions to each program usage()
Message-ID: <20141001080647.GH26272@x2.net.home>
References: <20140806132727.GI19820@x2.net.home>
 <1407341083.485189.149814161.10AFC682@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407341083.485189.149814161.10AFC682@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 06, 2014 at 06:04:43PM +0200, Benno Schulenberg wrote:
> On Wed, Aug 6, 2014, at 15:27, Karel Zak wrote:
> > https://github.com/stevenhoneyman/util-linux/commit/d5b828e418102b354025bbf7f91b2dcdfc1f4e66
> > 
> > the idea is to add one-line descriptions to each program usage().
> 
> Yes, docstrings are a good idea.
> 
> >  Anyway, the patch is not ready. I don't like the command name in the
> >  description -- it's redundant.
> 
> Furthermore, each docstring should be a full, grammatical sentence, not
> the telegram style used in the NAME section of man pages.  And each of
> them should start with a capital and end with a period.  And, if needed,
> it may also cover two lines.
> 
> >  Maybe it would be better to move the description above Options
> >  section.
> 
> Yes, that is a better place for them.  That is where coreutils puts them,
> too.
> 
> As an example, the docstring of the following three commands should
> probably be the same: "Display or manipulate a disk partition table.\n":
> 
> > fputs(_("fdisk - manipulate disk partition table\n"), out);
> > fputs(_("sfdisk - partition table manipulator for Linux\n"), out);
> > fputs(_("cfdisk - display or manipulate a disk partition table\n"), out);
> 
> Or if not, then the docstrings should make clear how these three differ.
> 
> By the way, the scripted grabbing of the first line of the man page as
> a docstring has gone wrong for the swapoff command.

 Benno, do you want to work on this task? It seems that the original
 author is no motivated enough to refresh the patch :-) I think it's
 good idea to provide more information in --help output.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
