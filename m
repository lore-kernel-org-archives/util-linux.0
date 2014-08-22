Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbaHVGez (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Aug 2014 02:34:55 -0400
Date: Fri, 22 Aug 2014 08:34:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH] mountpoint: symlinks are not mount points
Message-ID: <20140822063430.GG14708@x2.net.home>
References: <1408644191-13523-1-git-send-email-kerolasa@iki.fi>
 <53F64865.4090706@bernhard-voelker.de>
 <1408656867-20472-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408656867-20472-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 22, 2014 at 12:34:27AM +0300, Sami Kerola wrote:
> On 21 August 2014 22:28, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> > On 08/21/2014 08:03 PM, Sami Kerola wrote:
> >> Earlier the mountpoint(1) followed symlinks
> >
> > IMO this is correct as symlinks only have to be treated
> > as such when explicitly not de-referencing.
> > As mountpoint(1) does not have a --no-dereference option,
> > symlinks should always be transparent for this tool.
> >
> > Furthermore, the patch would break scripts relying on existing
> > behavior:
> >
> >   $ ln -s / slink
> >
> >   $ /usr/bin/mountpoint slink
> >   slink is a mountpoint
> >
> >   $ # ~berny/util-linux/mountpoint slink
> >   slink is not a mountpoint
> 
> I don't share view symlinks are mount points.  In my mind they are
> pointers, much like street signs, giving a direction to somewhere without
> understanding what is there if anything at all.  But not breaking
> existing behavior is good point, so I changed the patch and added
> --no-dereference.

 I don't think we need the patch, it does not resolve or improve
 anything. It's over-engineering. If you don't like symlinks then you
 can use

  if [ ! -L $dir ]; then
     mountpoint $dir
  fi

> -	if (stat(spec, &st)) {
> +	if (lstat(spec, &st)) {

 btw, you want to use lstat() only when no_dereference is specified.


 Anyway, NACK. Sorry.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
