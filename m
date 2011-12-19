Return-Path: rleigh@codelibre.net
Date: Mon, 19 Dec 2011 13:40:48 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add mount option for initramfs
Message-ID: <20111219134047.GG325@codelibre.net>
References: <20111216231538.GR17458@codelibre.net>
 <20111220131440.GE22739@n.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111220131440.GE22739@n.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 02:14:40PM +0100, Karel Zak wrote:
> On Fri, Dec 16, 2011 at 11:15:38PM +0000, Roger Leigh wrote:
> >    { "nofail",	0, 0, MS_COMMENT},	/* Do not fail if ENOENT on dev */
> > +  { "initramfs", 0, 0, MS_COMMENT},     /* Mount filesystem in initramfs */
> 
>  I don't think this is the right way. We have to be very conservative
>  with new mount options, especially with options specific for any
>  use case.
> 
>  You can use comment=initramfs and in new mount(8) will be also
>  supported x-* options, then you can use x-initrd or so.

OK, no worries.  I didn't realise you could use the comment syntax
in this way, so either that or x-initramfs/x-initrd will do nicely.


Thanks,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
