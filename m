Return-Path: linux-kernel-owner@vger.kernel.org
From: bastien ROUCARIES <roucaries.bastien@gmail.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: /etc/fstab.d yes or not
Date: Tue, 24 Jan 2012 10:47:41 +0100
Cc: Kay Sievers <kay.sievers@vrfy.org>, Masatake YAMATO <yamato@redhat.com>,
        kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
References: <20120120140444.GC13157@x2.net.home> <CAPXgP10uUpSQzX0RzYY24uDBkNkRXM7NbR0H6P=dZ=+LxdX3Fw@mail.gmail.com> <4F1DF90C.5070108@panasas.com>
In-Reply-To: <4F1DF90C.5070108@panasas.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201201241047.42303.roucaries.bastien@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le Tuesday 24 January 2012 01:19:24, Boaz Harrosh a écrit :
> On 01/20/2012 04:56 PM, Kay Sievers wrote:
> > It's an old glibc API, and /etc/fstab is ABI, not a service config
> > file, which now can read more than one file. It's a very different
> > problem. It an ABI change, not a config extension.
> 
> Can't we have our cake and eat it too?
> 
> I mean why not have both?
> 
> The subsystem that you currently plan to parse the /etc/fstab.d/ will
> intelligently  add the /etc/fstab.d/ entries to /etc/fstab before
> actually processing and mounting /etc/fstab.
> 
> So the rpm guys have their /etc/fstab.d/ convenience and the rest
> of the  ABI is kept intact. (If you can't bit them join them)
> 
> Since /etc/fstab is hand edited as well. There are lots of smart
> things that can be done like a remark (#) marker at the end of the
> file that all /etc/fstab.d/ entries get to be added after. (And
> a comment for the user) and some smart duplicate removal of, and
> so on ... Even a marker per line added.

I agree. And moreover extensible if they want to use xml for  /etc/fstab.d/. 
> 
> Just my $0,017
> Boaz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
