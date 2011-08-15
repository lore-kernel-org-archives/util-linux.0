Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1HONef (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 09:34:35 -0400
Date: Mon, 15 Aug 2011 15:34:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] small fixes to some messages and man pages, and some
	questions
Message-ID: <20110815133430.GG1843@nb.net.home>
References: <1313094127.6807.140258128661629@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313094127.6807.140258128661629@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> About the fourth patch I'm unsure.  The current description of the option
> '--no-reread' is "skip partition re-read at boot".  With "boot" is meant
> "program startup", so that needs to be corrected.  But the real effect of
> --no-reread seems to be to just check that the relevant partition is not
> in use.  Is that correct?

 Yes.

> By the way, I don't understand why the options -g (--show-geometry) and
> -G (show-pt-geometry) are listed under "Dangerous options".  How can
> they be dangerous when they just show things?

 Hmm.. not sure.

> Also I do not understand the descriptions of the new options --nested,
> --chained, and --onesector.  How is "disjoint" different from "mutually
> disjoint"?  Would the following attempts at description be correct?
>
> --nested     each logical and extended partition falls within an extended one
> --chained     each logical partition falls within an extended one
> --onesector   not any partition falls within another

The original comment from code:

/* There are two common ways to structure extended partitions:
   as nested boxes, and as a chain. Sometimes the partitions
   must be given in order. Sometimes all logical partitions
   must lie inside the outermost extended partition.
NESTED: every partition is contained in the surrounding partitions
   and is disjoint from all others.
CHAINED: every data partition is contained in the surrounding partitions
   and disjoint from all others, but extended partitions may lie outside
   (insofar as allowed by all_logicals_inside_outermost_extended).
ONESECTOR: all data partitions are mutually disjoint; extended partitions
   each use one sector only (except perhaps for the outermost one).
*/

The default is NESTED and "inside the outermost extended partition".

> The fourteenth patch adds the missing "[options]" to the usage synopsis
> of scriptreplay, and also indicates the timingfile argument as optional.
> However, I find this a bit misleading: the timingfile is only optional when
> it is specified via the -t option.  Wouldn't it be better to describe the
> command with two alternative synopses, as follows?
> 
>   Usage: scriptreplay timingfile [typescript [divisor]]
>      or: scriptreplay [options] [timingfile] [typescript] [divisor]

   scriptreplay [options] [-t] timingfile [typescript [divisor]]

 ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
