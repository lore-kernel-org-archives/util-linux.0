Return-Path: worley@ariadne.com
Date: Mon, 24 Nov 2014 10:48:26 -0500
Message-Id: <201411241548.sAOFmQaI028880@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Phillip Susi <psusi@ubuntu.com>
CC: kzak@redhat.com, drake@dasyatidae.net, util-linux@vger.kernel.org
In-reply-to: <547343EA.6090606@ubuntu.com> (psusi@ubuntu.com)
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <20141124113733.GC926@x2.net.home> <547343EA.6090606@ubuntu.com>
List-ID: <util-linux.vger.kernel.org>

> From: Phillip Susi <psusi@ubuntu.com>
> 
> On 11/24/2014 6:37 AM, Karel Zak wrote:
> > The current trend is to use partition type to define for what
> > purpose we want to use the partition (for example "this is /home") 
> > independently on partition format.
> 
> I wouldn't call this bone headed idea of redhat's a trend.  Using
> partition table type codes to decide to auto mount in particular parts
> of the filesystem is such a brain damaged idea, those who thought it
> up need beaten with a clue-by-four and its use needs to be *strongly*
> discouraged.

I have to agree here.  Trying to use partition type codes to specify
where partitions should be mounted has many flavors of fail.  Among
others, it assumes that there is a small, fixed set of mount points
that will *work for every installation*.  If you want to know what
gets mounted where, look in /etc/fstab, like we've done for 40 years
or so.

Dale
