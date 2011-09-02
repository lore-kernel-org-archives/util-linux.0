Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab1IBNPT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Sep 2011 09:15:19 -0400
Date: Fri, 2 Sep 2011 15:15:08 +0200
From: Karel Zak <kzak@redhat.com>
To: "Gabor Z. Papp" <gzp@papp.hu>, util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty 2.20 --noclear
Message-ID: <20110902131508.GB4117@nb.redhat.com>
References: <x662lbqvn1@gzp> <20110902104318.GA28133@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110902104318.GA28133@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 02, 2011 at 12:43:18PM +0200, Dr. Werner Fink wrote:
> On Fri, Sep 02, 2011 at 08:57:22AM +0200, Gabor Z. Papp wrote:
> > lo lo,
> > 
> > util-linux's agetty never cleared the terminal before 2.20.
> > 
> > I don't think its good idea to set clear screen to default, since
> > after upgrading from <2.20 versions, everywhere have to modify the
> > inittab with the --no-clear option.
> 
> Hmmm .. I've backported this from our mingetty due to several
> bug reports from data protection officers of our customers.

 I think the new default is better :-) The mingetty was better than
 agetty on terminals.

> > Also this Num/Caps/Scroll Lock on/off printf hint in the code looks
> > quite funny... Can't be set this optional and not printed by default?
> 
> That was backported due several bug reports from our own supporters
> as it seems to be a problem for many newbies.  Btw: AFAIK also kdm/gdm
> do such reports, don't they?

 Maybe we can add --nohints for people who prefect more acetic
 interface....

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
