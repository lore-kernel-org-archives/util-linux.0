Return-Path: rodrigo@sdfg.com.ar
Date: Fri, 24 Jan 2014 14:04:45 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Karel Zak <kzak@redhat.com>
Cc: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: drill: Make a file sparse without using extra disk space
Message-ID: <20140124140444.GB32270@sdfg.com.ar>
References: <20140123212813.GE20054@sdfg.com.ar>
 <52E1BB47.80609@draigBrady.com>
 <20140124021602.GA28658@sdfg.com.ar>
 <20140124093448.GA24972@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140124093448.GA24972@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 24, 2014 at 10:34:48AM +0100, Karel Zak wrote:
> On Fri, Jan 24, 2014 at 02:16:02AM +0000, Rodrigo Campos wrote:
> > On Fri, Jan 24, 2014 at 01:00:55AM +0000, Pádraig Brady wrote:
> > > On 01/23/2014 09:28 PM, Rodrigo Campos wrote:
> > > > I've written a small simple tool to make a file sparse without using extra disk
> > > > space, it just digs holes on the file when possible.
> 
>  Nice idea.

Thanks! Not really original, though :)

> 
> > > > To dig the hole uses the
> > > > Linux-specific fallocate(2) syscall with FALLOC_FL_PUNCH_HOLE. So, also, it only
> > > > works on some file-systems.
> > > > 
> > > > Do you think that util-linux would be a good place for such a simple, linux-only
> > > > program ? The case I see it can be useful is to use on VM images file backed (or
> > > > I wrote it with this in mind, at least :)).
> > > > 
> > > This functionality is useful.
> > > Would it be possible to just add to fallocate with --punch-hole=sparse or something?
> > 
> > Totally, that's an option too :)
> 
>  It would be the best way for util-linux, I really don't want to add
>  another util for fallocate.

Great!

> 
>  Maybe we can use a new option --dig-holes [ --length <size> ] or so.

Sounds fine, but needs to be mutually exclusive with the options it takes now, I
think. Or maybe something can be shared...

Will try to come up with a patch during the weekend or next week. Thanks!

> > > Also dd has the conv=sparse option, so maybe this functionality can be added there.
> 
>  IMHO would be possible to add this functionality to both places ;-)

:-D





Thanks a lot,
Rodrigo
