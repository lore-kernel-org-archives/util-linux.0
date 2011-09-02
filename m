Return-Path: util-linux-owner@vger.kernel.org
Received: from odpn1.odpn.net ([212.40.96.53]:59532 "EHLO odpn1.odpn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab1IBSSD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Sep 2011 14:18:03 -0400
Received: from odpn1.odpn.net [212.40.96.53]
	by odpn1.odpn.net for util-linux@vger.kernel.org
	id 1QzYJV-0005Ac-H5; Fri, 02 Sep 2011 20:18:01 +0200
From: "Gabor Z. Papp" <gzp@papp.hu>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty 2.20 --noclear
References: <x662lbqvn1@gzp> <20110902104318.GA28133@boole.suse.de>
Date: Fri, 02 Sep 2011 20:18:01 +0200
Message-ID: <x639ge4xly@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* "Dr. Werner Fink" <werner@suse.de>:

| > Also this Num/Caps/Scroll Lock on/off printf hint in the code looks
| > quite funny... Can't be set this optional and not printed by default?

| That was backported due several bug reports from our own supporters
| as it seems to be a problem for many newbies.  Btw: AFAIK also kdm/gdm
| do such reports, don't they?

I don't know kdm/gdm, but with new agetty its annoying.
