Return-Path: bensberg@justemail.net
Message-Id: <1313433269.27812.140258129893485@webmail.messagingengine.com>
From: "Benno Schulenberg" <bensberg@justemail.net>
To: "Karel Zak" <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110815133430.GG1843@nb.net.home>
References: <1313094127.6807.140258128661629@webmail.messagingengine.com>
 <20110815133430.GG1843@nb.net.home>
Subject: Re: [patches] small fixes to some messages and man pages, and some
 questions
Date: Mon, 15 Aug 2011 20:34:29 +0200
List-ID: <util-linux.vger.kernel.org>


> > Also I do not understand the descriptions of the new options --nested,
> > --chained, and --onesector.  [...]
> 
> The original comment from code: 
> 
> /* [...]
> NESTED: every partition is contained in the surrounding partitions
>    and is disjoint from all others.

I still fail to understand.  If "contained in the surrounding partitions"
means "contained in the containing partitions", it says nothing.  If it
means "contained in the partitions that come before and after", this
seems impossible to me.  The only way I can make sense of the
above comment is to read it as follows:

NESTED: every extended partition is contained within a surrounding
extended partition [except of course the outermost one] and is disjoint
from all other extended partitions at the same nesting level.

(Here I take "disjoint" to mean "does not overlap", but then I still fail
to understand how "mutually disjoint" is different.)

> CHAINED: every data partition is contained in the surrounding partitions
>    and disjoint from all others, but extended partitions may lie outside

Is a data partition the same as a logical partition?


> > However, I find this a bit misleading: the timingfile is only optional when
> > it is specified via the -t option.  Wouldn't it be better to describe the
> > command with two alternative synopses, as follows?
> > 
> >   Usage: scriptreplay timingfile [typescript [divisor]]
> >      or: scriptreplay [options] [timingfile] [typescript] [divisor]
> 
>    scriptreplay [options] [-t] timingfile [typescript [divisor]]

Yes, that would do.  It does not cover the possibilty of the typescript
file being passed with option -s and the divisor as a direct argument,
but it's good enough for my taste.

Regards,

Benno

-- 
http://www.fastmail.fm - Same, same, but different...
