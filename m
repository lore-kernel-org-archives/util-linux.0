Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:59781 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3BFJeY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 04:34:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1U31Op-00015h-0C
	for util-linux@vger.kernel.org; Wed, 06 Feb 2013 10:34:39 +0100
Received: from diamant.ifi.uio.no ([129.240.65.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 06 Feb 2013 10:34:38 +0100
Received: from hgb by diamant.ifi.uio.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 06 Feb 2013 10:34:38 +0100
To: util-linux@vger.kernel.org
From: Henrik Grindal Bakken <hgb@ifi.uio.no>
Subject: Re: Problem with telnet after upgrade of util-linux
Date: 06 Feb 2013 10:34:09 +0100
Message-ID: <x2e4nhpair2.fsf@diamant.ifi.uio.no>
References: <x2eharj9th8.fsf@smaragd.ifi.uio.no> <20130205092740.GB5865@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Fri, Aug 31, 2012 at 01:44:03PM +0200, Henrik Grindal Bakken wrote:
> > 
> > Hi.  I have a custom Linux distro running where we (unfortunately...)
> > support telnet, using netkit-telnet-0.17.
> > 
> > A while ago, I upgraded util-linux from 2.20.1 to 2.22-rc2 (to get
> > sulogin, since I switched to systemd).  One side-effect of this, which
> > I didn't catch for some time (not frequently using telnet), was that
> > telnet started chopping some characters off its output.  The changes
> > appear to be related to login(1).
> 
> Probably also:
>  https://bugzilla.redhat.com/show_bug.cgi?id=904182

Yeah, I've seen that one.  They don't seem to be very close to a
solution, though.

-- 
Henrik Grindal Bakken <hgb@ifi.uio.no>
PGP ID: 8D436E52
Fingerprint: 131D 9590 F0CF 47EF 7963  02AF 9236 D25A 8D43 6E52

