Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55352 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933351Ab1IBKnZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Sep 2011 06:43:25 -0400
Date: Fri, 2 Sep 2011 12:43:18 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty 2.20 --noclear
Message-ID: <20110902104318.GA28133@boole.suse.de>
References: <x662lbqvn1@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <x662lbqvn1@gzp>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 02, 2011 at 08:57:22AM +0200, Gabor Z. Papp wrote:
> lo lo,
> 
> util-linux's agetty never cleared the terminal before 2.20.
> 
> I don't think its good idea to set clear screen to default, since
> after upgrading from <2.20 versions, everywhere have to modify the
> inittab with the --no-clear option.

Hmmm .. I've backported this from our mingetty due to several
bug reports from data protection officers of our customers.

> Also this Num/Caps/Scroll Lock on/off printf hint in the code looks
> quite funny... Can't be set this optional and not printed by default?

That was backported due several bug reports from our own supporters
as it seems to be a problem for many newbies.  Btw: AFAIK also kdm/gdm
do such reports, don't they?

     Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
