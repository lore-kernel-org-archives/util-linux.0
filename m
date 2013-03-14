Return-Path: util-linux-owner@vger.kernel.org
Received: from toccata.ens-lyon.fr ([140.77.166.68]:41505 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932968Ab3CNCjU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Mar 2013 22:39:20 -0400
Date: Thu, 14 Mar 2013 03:39:17 +0100
From: Samuel Thibault <sthibault@debian.org>
To: Jeff Epler <jepler@unpythonic.net>
Cc: LaMont Jones <lamont@debian.org>, Roger Leigh <rleigh@codelibre.net>,
        util-linux@vger.kernel.org
Subject: Re: Enable findmnt on kfreebsd
Message-ID: <20130314023917.GJ5867@type.youpi.perso.aquilenet.fr>
References: <20130314003946.GB4068@unpythonic.net>
 <20130314010620.GI5867@type.youpi.perso.aquilenet.fr>
 <20130314020240.GC4068@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130314020240.GC4068@unpythonic.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Jeff Epler, le Wed 13 Mar 2013 21:02:41 -0500, a écrit :
> On Thu, Mar 14, 2013 at 02:06:20AM +0100, Samuel Thibault wrote:
> > Jeff Epler, le Wed 13 Mar 2013 19:39:47 -0500, a écrit :
> > > +#ifdef __FreeBSD_kernel__
> > 
> > Perhaps rather turn all these into
> > #ifdef __linux__
> 
> Fine by me, and might make e.g., hurd work too (or at least get closer).

That was the point, yes :)

Samuel
