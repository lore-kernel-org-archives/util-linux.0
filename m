Return-Path: serge+util-linux@vdboom.org
Date: Tue, 22 Mar 2016 17:14:36 +0100 (CET)
From: Serge van den Boom <serge+util-linux@vdboom.org>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: Subject: Multiple issues with partx
In-Reply-To: <20160322145033.l6mus2ao7s7272ll@ws.net.home>
Message-ID: <alpine.BSF.2.00.1603221648410.68855@toad.stack.nl>
References: <alpine.BSF.2.00.1603151918560.60883@toad.stack.nl> <20160322145033.l6mus2ao7s7272ll@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

Thanks. Fast resolution.

On Tue, 22 Mar 2016, Karel Zak wrote:
> On Tue, Mar 22, 2016 at 01:17:42PM +0100, Serge van den Boom wrote:
> > 
> > 4. It is possible to specify a partition by the device name of a
> >    partition on another block device.
> > 
> > The command 'partx /dev/sdb2 /dev/sda' makes no sense, but still
> > produces output, namely the second partition of /dev/sda.
> 
>  Fixed,
> 
>  # partx --show /dev/sdx1 /dev/sdc
>  partx: partition and disk name do not match

Strictly speaking, it should be the devices themselves which would need
to match, not their names. I could create a few symlinks, and
'partx x0 x' would work, even when x0 and x refer to unrelated devices:

    ln -s /dev/sda x
    ln -s /dev/sdb2 x0


Regards,

Serge
