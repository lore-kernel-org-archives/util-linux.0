Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:47817 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3CRWim (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Mar 2013 18:38:42 -0400
Date: Mon, 18 Mar 2013 22:38:40 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: Re: newgrp(1) and sg(1)
Message-ID: <20130318223840.GW23093@codelibre.net>
References: <20130318154225.GF2172@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130318154225.GF2172@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 18, 2013 at 04:42:25PM +0100, Karel Zak wrote:
> Do we really need passwords for groups [newgrp(1) and /etc/gshadow]?
> Seems like a nice over-engineering.
> 
> By the way, I have fixed newgrp(1) in util-linux and shadow-utils 5
> years ago. The password verification was pretty useless for years...

It's only with the newer glibcs that it's supported by NSS and
the standard library properly (and getent).  So while it's not
as widely used as other system databases, it does have its place
and has really only recently become properly usable.

Looking at the newgrp(1) implementation, it's not using glibc
NSS.  On a current system, it could certainly switch to using
the standard getsgent (or related fgetsgent_r etc.) calls.

> IMHO it would be better to mark whole /etc/gshadow as deprecated and
> reuse "su --group <group> [--supp-group <group> ...]" code to switch
> between groups, then we don't have to maintain separate newgrp code.
> 
> Note that newgrp(1) is available in shadow-utils and util-linux, sg(1)
> is alias in shadow-utils. We have been successful with login(1), now
> I'd like to consolidate newgrp(1) :-)

I don't think that deprecation is really appropriate--the system
interface, NSS and /etc/gshadow are not really the purview of
util-linux, though tools using the interfaces certainly are.

newgrp(1) is specified by POSIX/SUS, so I think this is worth
retaining for compatibility reasons.  Making it use NSS would be
a good improvement though, since it's currently limited to flat
files.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux    http://people.debian.org/~rleigh/
 `. `'   schroot and sbuild  http://alioth.debian.org/projects/buildd-tools
   `-    GPG Public Key      F33D 281D 470A B443 6756 147C 07B3 C8BC 4083 E800
