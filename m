Return-Path: ssmoser2@gmail.com
Sender: Scott Moser <ssmoser2@gmail.com>
Date: Wed, 15 Jul 2015 10:56:48 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: GPT writing of unknown partition uuids
In-Reply-To: <20150715134234.GC31997@ws.net.home>
Message-ID: <alpine.DEB.2.02.1507151055540.30147@brickies>
References: <alpine.DEB.2.02.1507141610310.21273@brickies> <20150715134234.GC31997@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Wed, 15 Jul 2015, Karel Zak wrote:

> On Tue, Jul 14, 2015 at 04:16:56PM -0400, Scott Moser wrote:
> > It seems like if the user provided you with a GUID, sfdisk should trust
> > them, or at very least exit failure if it refuses to use the provided
> > GUID.
> >
> > Thoughts?
>
> It's bug, the "unknown" partition type is expected. Fixed in git tree:
>
> # sfdisk -ql /dev/sdc
> Device     Start     End Sectors  Size Type
> /dev/sdc1   2048 1023966 1021919  499M Linux filesystem
>
>
> # sfdisk --part-type /dev/sdc 1 $(uuidgen)
> ...
>
>
> # sfdisk -ql /dev/sdc
> Device     Start     End Sectors  Size Type
> /dev/sdc1   2048 1023966 1021919  499M unknown
>
>
> Thanks for your report!
Thanks for the quick fix.

Is it sane for me to assume this is fixed in any version of
  util-linux > 2.26.2 ?
