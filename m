Return-Path: tytso@thunk.org
Date: Mon, 10 Feb 2014 13:57:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: Kenny Rachuonyo <krmboya@gmail.com>, util-linux@vger.kernel.org
Subject: Re: Typo in mkfs man-page
Message-ID: <20140210185741.GF4724@thunk.org>
References: <CAFeW3TRKCNKtXv-9mQC86JM6xQNySQn=csJQFa2RqBRBnbujug@mail.gmail.com>
 <20140210173545.GK8506@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140210173545.GK8506@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 06:35:45PM +0100, Karel Zak wrote:
> On Wed, Jan 22, 2014 at 10:38:31AM +0300, Kenny Rachuonyo wrote:
> > The short form of the --verbose option should probably be -v instead of -V
> > 
> > This occurs both on the online man-page:
> > 
> > http://man7.org/linux/man-pages/man8/mkfs.8.html
> > 
> > and my local system (Ubuntu 12.04) man-page.
> 
>  I think this historical mess is well explained in the man page. 

I'll add that I've never been convinced that the mkfs front end is all
that useful.  It's probably better for people to explicitly run
/sbin/mkfs.xfs, /sbin/mkfs.ext4, etc.., so you don't have to worry
about which options get passed down to the file system specific mkfs
program, and which ones are interpreted by /sbin/mkfs --- and I don't
believe /sbin/mkfs adds enough (err, any?) value that using
"/sbin/mkfs -t xxx" vs "/sbin/mkfs.xxx" makes any sense whatsoever.

At least with /sbin/fsck it runs multiple fsck programs in parallel,
and it serves as a front-end program so you don't have to modify the
init scripts if you change your root file system from reiserfs to jfs,
while keeping some of your other file systems as minixfs.  So
/sbin/fsck adds value.

But /sbin/mkfs.xxx is generally run by system administrators, and IMHO
it's better to tell people to run the command "/sbin/mkfs.xxx" instead
of "/sbin/mkfs -t xxx".

Cheers,

					- Ted
