Return-Path: util-linux-owner@vger.kernel.org
Received: from dsl.unpythonic.net ([206.222.212.217]:53991 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755196Ab3CNCCo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Mar 2013 22:02:44 -0400
Date: Wed, 13 Mar 2013 21:02:41 -0500
From: Jeff Epler <jepler@unpythonic.net>
To: Samuel Thibault <sthibault@debian.org>, LaMont Jones <lamont@debian.org>,
        Roger Leigh <rleigh@codelibre.net>, util-linux@vger.kernel.org
Subject: Re: Enable findmnt on kfreebsd
Message-ID: <20130314020240.GC4068@unpythonic.net>
References: <20130314003946.GB4068@unpythonic.net>
 <20130314010620.GI5867@type.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130314010620.GI5867@type.youpi.perso.aquilenet.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 14, 2013 at 02:06:20AM +0100, Samuel Thibault wrote:
> Jeff Epler, le Wed 13 Mar 2013 19:39:47 -0500, a écrit :
> > +#ifdef __FreeBSD_kernel__
> 
> Perhaps rather turn all these into
> #ifdef __linux__

Fine by me, and might make e.g., hurd work too (or at least get closer).

Jeff
