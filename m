Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755794AbdGCOZV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 10:25:21 -0400
Date: Mon, 3 Jul 2017 16:25:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: fputs() vs puts()
Message-ID: <20170703142515.rg43rgobwfvykooz@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <201707031030.22137.sweet_f_a@gmx.de>
 <20170703120752.25fkjobw6dxgqo2w@ws.net.home>
 <201707031438.33652.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201707031438.33652.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 02:38:33PM +0200, Ruediger Meier wrote:
> On Monday 03 July 2017, Karel Zak wrote:
> >  Maybe it would be possible to convince me that coreutils way for
> >  options arguments is the right way :-))
> >
> >  I mean:
> >
> >    --output COLUMNS
> >    --length SIZE
> >    --net[=FILE]
> >
> >  ...etc. The question is how to compose the option string to minimize
> >  duplication and inform about a format, for example
> >
> >    --output COLUMNS    list of columns to display (see below)
> >
> >
> >  Note that on many places we for example for SIZE accept suffixes
> >  (MiB, GiB...) but this info is nowhere in the --help output.
> 
> Coreutils is using some of these capitalized words really as
> system-wide keywords. For example SIZE:
> 
>   The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
>   Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).
> 
> BTW this is my only coreutils patch to make the size description
> human understandable and let it fit into two 80 char columns. ;)
> 
> There was a big discussion about this here in bug#9939
> https://lists.gnu.org/archive/html/bug-coreutils/2011-11/threads.html#00002
> 
> 
> >  And note that I like the William's idea with the explicit reader
> >  redirection "(see below)".
> 
> Yep, IMO the "see below" is good *always* if the overall text is a bit
> longer. In case there are only a few lines or if obvious (like FILE), it
> *may* be skipped, I would say.

I agree. What about the section where we explain the references? I
personally prefer sentence-like way:

   Available COLUMNS:
      ...
   The SIZE argument...

More complex example (lsblk):

 now:
   -e, --exclude <list>    exclude devices by major number (default: RAM disks)
   -I, --include <list>    show only devices with specified major numbers
   -o, --output <list>     output columns
   -x, --sort <column>     sort output by <column>


 after change:
   -e, --exclude MAJOR     exclude specified devices (see below)
   -I, --include MAJOR     show only specified devices (see below)
   -o, --output COLUMNS    output columns (see below)
   -x, --sort COLUMN       sort output by column

 The MAJOR command separated list of the device major numbers. The
 ramdisk devices are excluded by default.

 Available COLUMNS:
   NAME  device name
   KNAME  internal kernel device name
   ...


Objections, comment? 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
