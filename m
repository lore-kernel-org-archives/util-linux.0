Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3BEJ1r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Feb 2013 04:27:47 -0500
Date: Tue, 5 Feb 2013 10:27:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Henrik Grindal Bakken <hgb@ifi.uio.no>
Cc: util-linux@vger.kernel.org
Subject: Re: Problem with telnet after upgrade of util-linux
Message-ID: <20130205092740.GB5865@x2.net.home>
References: <x2eharj9th8.fsf@smaragd.ifi.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x2eharj9th8.fsf@smaragd.ifi.uio.no>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 31, 2012 at 01:44:03PM +0200, Henrik Grindal Bakken wrote:
> 
> Hi.  I have a custom Linux distro running where we (unfortunately...)
> support telnet, using netkit-telnet-0.17.
> 
> A while ago, I upgraded util-linux from 2.20.1 to 2.22-rc2 (to get
> sulogin, since I switched to systemd).  One side-effect of this, which
> I didn't catch for some time (not frequently using telnet), was that
> telnet started chopping some characters off its output.  The changes
> appear to be related to login(1).

Probably also:
 https://bugzilla.redhat.com/show_bug.cgi?id=904182


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
