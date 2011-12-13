Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:58012 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1LMV1i (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Dec 2011 16:27:38 -0500
Date: Tue, 13 Dec 2011 21:27:36 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: sysvinit-2.88dsf-14
Message-ID: <20111213212736.GM17458@codelibre.net>
References: <20111213203001.GJ17458@codelibre.net>
 <201112131621.53521.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201112131621.53521.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 13, 2011 at 04:21:52PM -0500, Mike Frysinger wrote:
> On Tuesday 13 December 2011 15:30:01 Roger Leigh wrote:
> > I'd like to upload the following to experimental, but wanted to
> > run it past you in case there was anything you were unhappy
> > with or which you would like changing.  I've attached a patch
> > for the proposed upload, and the changelog is below.  Any
> > comments would be appreciated.
> > 
> > The main two parts are the removal of /lib/init/rw and the
> > conversion of /etc/mtab to a symlink.
> 
> what's the relation to util-linux exactly ?  just the mention of /etc/mtab ?
> -mike

Awfully sorry, wrong list!  It was intended for the debian
sysvinit list.

Apologies for the noise.

Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
