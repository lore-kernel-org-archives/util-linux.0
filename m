Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56646 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbaAIPv7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jan 2014 10:51:59 -0500
Message-ID: <1389282714.8841.109.camel@oct.suse.cz>
Subject: Re: mount: "nofail" and already mounted devices?
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Thu, 09 Jan 2014 16:51:54 +0100
In-Reply-To: <20140109100254.GD7516@x2.net.home>
References: <1389203741.8841.31.camel@oct.suse.cz>
	 <20140109100254.GD7516@x2.net.home>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Jan 08, 2014 at 06:55:41PM +0100, Stanislav Brabec wrote:
> > Attempting to mount of already mounted devices is a common situation in
> > many scripts.
> 
> What about to fix the scripts? :-)
> 
> All you need is to call
> 
>     findmnt --source <dev> --target <mountpoint>

Yes, it is an option.

The new behavior could simplify common situation and also prevent a
race:
if the device is not yet mounted
   mount it
do the work

> > Would be acceptable a patch that adds "already mounted" to "nofail"?
> 
> Maybe.

Well, It could be a straightforward solution (~2 lines change). But it
could break following script (theoretical, a bit dumb and fragile, but
still depending only on documented behavior):

... do some actions that will initiate delayed $DEVICE creation ...
while mount -o nofail $DEVICE /opt ; do
  if test -d /opt/myvendor ; then
    break
  fi
  sleep 1
done

Now imagine, that somebody previously called:
mount $DEVICE /opt

What will happen with the current mount?
The script will fail as expected.

What will happen after such patch?
The script will enter to a dead loop.

> > - Make possible to use "-a" with further arguments.
> 
>   mount -a /foo /bar [...]
> 
> Right? 

Well, it sounds interesting as well, but I was thinking about
(conflicting):
mount -a /dev/device /mountpoint

It can be done both:

mount -a /foo /bar [...]
mount -A /dev/device /mountpoint

-A Do not report errors if the mount point is already used or device is
   already mounted.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

