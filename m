Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbaJUKiY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 06:38:24 -0400
Date: Tue, 21 Oct 2014 12:38:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Robert Milasan <rmilasan@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: swapon: fix -d short option
Message-ID: <20141021103817.GH8057@x2.net.home>
References: <20141021100246.3e956b6d@viper.suse.cz>
 <20141021095525.GG8057@x2.net.home>
 <20141021120741.39f63265@viper.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141021120741.39f63265@viper.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 21, 2014 at 12:07:41PM +0200, Robert Milasan wrote:
> On Tue, 21 Oct 2014 11:55:25 +0200
> "Karel Zak" <kzak@redhat.com> wrote:
> 
> > On Tue, Oct 21, 2014 at 10:02:46AM +0200, Robert Milasan wrote:
> > > When -d option is used with swapon, is expected that there is an
> > > equal '=' which at least according to the man page it doesn't make
> > > sense or it's not properly explained.
> > 
> > Well, in the man page there was incorrectly extra space between -d and
> > the optional argument. Fixed yesterday.
> > 
> > > If we use -d as we should, then swapon takes 'once' or 'pages' as an
> > > actual device:
> > > 
> > > dhcp33:~ # swapon -p -2 -d once /dev/sdb1
> > > swapon: stat failed once: No such file or directory
> > > 
> > > The short option -d, should be something like "swapon -d once ...."
> > > not "swapon -d=once ...."
> > 
> > What? The argument for -d is optional, it's reason why we care about
> > '='. I think it's obvious from the code.
> > 
> >    swapon -p -2 -d /dev/sdb1 
> > 
> > is pretty valid.
> > 
> > Note that -d,--discard has been implemented in 2010, and extended by
> > 'once' and 'pages' later in 2013.
> > 
> > > I've attached the patch to fix this small issue.
> > 
> > Sorry, but the patch does not make sense.
> > 
> >     Karel
> > 
> 
> Sorry, but the option doesn't make sense eider. First is not documented

current git tree:

-d, --discard[=policy]
      Enable  swap  discards, if the swap backing device supports the discard or trim operation.
      This may improve performance on some Solid State Devices, but often it does not.  The option
      allows  one to select between two available swap discard policies: --discard=once to perform
      a single-time discard operation for the whole swap area at  swapon;  or  --discard=pages  to
      discard  freed swap pages before they are reused, while swapping.  If no policy is selected,
      the default behavior is to enable both discard types.  The /etc/fstab mount options discard,
      discard=once, or discard=pages may also be used to enable discard flags.

Maybe we can add something like

     Note that the optional policy argument cannot be separated from the -d option by a space, 
     the correct form is for example '-d=pages'.

to make it more obvious.


> properly or at all and with my patch -d option without any argument
> still works.

You want to use 

   "-d once"

for optional arguments, but this is not compatible with libc getopt().
We use '=' on many other paces... because:

man getopt:
  Two colons mean an option takes an optional arg; if there is text in the 
  current argv-element (i.e., in the same word as the option name itself, 
                                     ^^^^^^^^^
  for example, "-oarg"), then it is returned in optarg, otherwise optarg
  is set to zero.  


for example ("once" is swapfile name):

 mkswap once
 swapon -d once

I think -d=once to specify discard policy is more robust.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
