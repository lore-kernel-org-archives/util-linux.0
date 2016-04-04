Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbcDDInf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Apr 2016 04:43:35 -0400
Date: Mon, 4 Apr 2016 10:43:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.28-rc2
Message-ID: <20160404084333.noqw67mh3liqhobi@ws.net.home>
References: <20160329091012.x3qea5ga2qzxqkrw@ws.net.home>
 <20160329094308.GA3019@var.bordeaux.inria.fr>
 <201603291158.32187.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603291158.32187.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 29, 2016 at 10:58:30AM +0100, Ruediger Meier wrote:
> > -#if defined (BSD) || defined (__APPLE__)
> > +#if (defined (BSD) || defined (__APPLE__)) && defined (HAVE_SETPROGNAME)
> 
> Then I would simply use only
> #if defined (HAVE_SETPROGNAME)
> 
> or, to be 105% sure to avoid any side effects on our "normal" Linux target
> 
> #if defined (HAVE_SETPROGNAME) && ! defined __linux__

Thanks Samuel, 105% sounds good, fixed :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
