Return-Path: util-linux-owner@vger.kernel.org
Received: from toccata.ens-lyon.org ([140.77.166.68]:59905 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbaC1AHO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Mar 2014 20:07:14 -0400
Date: Fri, 28 Mar 2014 00:57:47 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org
Subject: Re: tty swtch key
Message-ID: <20140327235747.GB4601@type.youpi.perso.aquilenet.fr>
References: <533320C5.7040609@ubuntu.com>
 <lh1ra8$dd7$1@ger.gmane.org>
 <53347A8E.7060608@ubuntu.com>
 <53348639.1040100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53348639.1040100@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mantas Mikulėnas, le Thu 27 Mar 2014 22:12:41 +0200, a écrit :
> On 2014-03-27 21:22, Phillip Susi wrote:
> > On 3/27/2014 2:40 PM, Mantas Mikulėnas wrote:
> > 
> >> On the other hand, there _is_ a reimplementation of shl for Linux
> >> and Solaris, as part of heirloom-toolchest
> >> <http://heirloom.sourceforge.net/tools.html> and
> >> <http://heirloom.sourceforge.net/man/shl.1.html>.
> > 
> > How so?  It has to be implemented in the kernel tty layer.
> 
> Not necessarily – remember that `screen` and `tmux` and `dtach` were
> implemented entirely in user space.

Err, no, they have to depend on some kernel features. For instance, you
want to be able to ^C a program running in a sudo shell. Only the kernel
can do that.

Samuel
