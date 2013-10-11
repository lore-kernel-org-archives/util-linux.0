Return-Path: util-linux_contact@magister.com.au
Date: Fri, 11 Oct 2013 14:45:57 +1100 (EST)
From: Craig <util-linux_contact@magister.com.au>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
In-Reply-To: <20131010111045.GA29199@x2.net.home>
Message-ID: <alpine.LFD.2.02.1310111435300.6990@trabz.zntvfgre.pbz.nh>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au> <20131009141628.GB940@x2.net.home> <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh> <20131010111045.GA29199@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Thu, 10 Oct 2013, Karel Zak <kzak@redhat.com> wrote:

> Note that in v2.24 the GPT code in fdisk does not allow to write hybrid
> GPT, the support is read-only.

Hmm; not good for the long term.  Although a hack and potentially 
disastrous if not handled carefully, hybrid MBR really is necessary under 
certain conditions.  Perhaps support should be read-only by default, with 
a means to switch to write, and dire warnings that one is likely severely 
to break things if one isn't careful?  Although it could be argued that 
those likely to be playing with fdisk (rather e.g. than Partid) might be 
expected to know what they're doing. :D To be honest, I'd like to see a 
means completely to separate GPT/MBR changes, so if necessary one could do 
absolutely anything to either without affecting the other.  If somebody is 
playing around with both, then really they should expect to understand 
what will happen if they're careless.

Craig
