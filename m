Return-Path: andreas@infernal.debian.net
Date: Mon, 16 Oct 2017 03:12:43 +0200
From: Andreas Bombe <aeb@debian.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrius =?iso-8859-15?Q?=A6tikonas?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171012204931.tfd2bhmwu5b6rbpz@pali>
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Rohár wrote:
> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
> > On Thu, Oct 12, 2017 at 11:21:13AM +0200, Pali Rohár wrote:
> > > > The best for me is to keep blkid output backwardly compatible as much
> > > > as possible :-)
> > > 
> > > Backward compatibility is a good reason. But what with situation when
> > > interoperability with other systems (e.g. Windows) does not work as
> > > expected?
> > 
> > Then... I'm ready to do the changes to keep interoperability with the
> > rest of the universe. It's the same situation as with UDF, you know...
> 
> Apparently situation is not same as with UDF. For UDF we have
> specification and basically all known UDF implementation by me were
> compatible how to treat label except blkid (which read different think).
> 
> For FAT32 we have 3 different linux implementations (blkid, fatlabel,
> mlabel) and every one is slightly different in reading label (see
> results sent in previous emails).
> 
> What is first needed to know if implementations are willing to change to
> be more or less same. And then decide what we want to change.
> 
> Andreas, as fatlabel maintainer, what do you think about it?
> 
> If you want, I can prepare patches for blkid and fatlabel to mimic
> behavior written in proposed solution. But I think it does not make
> sense to change just one Linux tool...

I was worried that there might be some scripts or programs that expect
the "NO NAME" output for unlabeled volumes from fatlabel. At least there
does not appear anything like that judging from a few searches on
codesearch.debian.net. Not that there's a guaranteed "NO NAME" on
unlabeled filesystems, in an unlikely case the boot sector label field
might be missing altogether.

So far I think I will change fatlabel to chop off trailing white space
when printing and have it interpret no rootdir label + boot sector label
== NO NAME as no label.

The other thing is completely ignoring the boot sector label, which I
could have as a mode enabled by command line switch or environmental
variable, or just outright make it the default. I'm not decided yet.

Another problem is whether to also ignore boot sector on setting label.
Otherwise the sequence:
  "set label on Linux" (both root and boot)
  "change label on Windows" (root label is changed)
  "remove label on Windows" (root label is deleted)
  "view label on Linux" (no root label, use boot label)
resurrects an old label.
