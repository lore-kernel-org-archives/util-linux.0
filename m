Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:34023 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab3A3LmF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Jan 2013 06:42:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1U0W3Y-0001su-Hh
	for util-linux@vger.kernel.org; Wed, 30 Jan 2013 12:42:20 +0100
Received: from diamant.ifi.uio.no ([129.240.65.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 30 Jan 2013 12:42:20 +0100
Received: from hgb by diamant.ifi.uio.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 30 Jan 2013 12:42:20 +0100
To: util-linux@vger.kernel.org
From: Henrik Grindal Bakken <hgb@ifi.uio.no>
Subject: login/telnet problems
Date: 30 Jan 2013 12:41:52 +0100
Message-ID: <x2efw1iyk1r.fsf@diamant.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi.  I'm working on a product which (sadly) requires telnet, and after
an upgrade from util-linux-2.20 to 2.22.2, telnet starts acting up by
dropping the first character (at least that's the easiest problem to
spot).

I looked around, and determined that the problem was related to
upgrading login(1).  Further, I bisected util-linux, and determined
that the problem was introduced by:

commit 2e7035646eb85851171cc2e989bfa858a4f00cd4
Author: Karel Zak <kzak@redhat.com>
Date:   Thu Jul 12 16:33:52 2012 +0200

    login: close tty before vhangup()
    
    Let's close all tty file descriptors before vhangup() call.
    
    References: https://lkml.org/lkml/2012/6/5/145
    Signed-off-by: Karel Zak <kzak@redhat.com>


I reverted that commit locally, and telnet started working nicely
again.  This is netkit-telnet-0.17, btw.

It's not a huge problem for me to keep a local revert of this commit,
but I thought perhaps you wanted to know it did actually break
something (although one can argue the very existence of telnet these
days is a bug...).


-- 
Henrik Grindal Bakken <hgb@ifi.uio.no>
PGP ID: 8D436E52
Fingerprint: 131D 9590 F0CF 47EF 7963  02AF 9236 D25A 8D43 6E52

