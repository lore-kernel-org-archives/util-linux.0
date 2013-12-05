Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab3LEOYg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Dec 2013 09:24:36 -0500
Date: Thu, 5 Dec 2013 15:24:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: util-linux@vger.kernel.org, xen-devel@lists.xen.org
Subject: Re: [RFC PATCH] sgetty: Smart serial console getty
Message-ID: <20131205142431.GA16891@x2.net.home>
References: <1386196297-2398-1-git-send-email-daniel.kiper@oracle.com>
 <20131205110508.GC8058@x2.net.home>
 <20131205133707.GB17074@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131205133707.GB17074@olila.local.net-space.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 05, 2013 at 02:37:07PM +0100, Daniel Kiper wrote:
> >    agetty --detect-console [baud_rate...] [term]
> 
> Make sens.
> 
> > Note that in login-utils/sulogin-consoles.c we have code to detect
> > consoles for sulogin, for example detect_consoles_from_cmdline().
> 
> Great... I will try to use it. Should I build this file as a library
> and then link into agetty or just link ordinary object file
> (login-utils/sulogin-consoles.o) with it?

 You can move the function (or some fragment of the function) to
 the lib/ttyutils.c, the file is already used for libcommon.so (lib
 used everywhere in the package).

> > BTW, I guess that systemd does not use hardcoded console names (like
> > /etc/inittab), ... just for the record :-) (I have no problem to
> > support classic inittab.)
> 
> That is great. However, I do not know systemd (I only heard about that)
> and maybe my question is stupid but I am curious how it starts getty
> on serial console, i.e. how it gets a name of serial console and
> passes it to getty.

 from kernel command line, more details:
 http://0pointer.de/blog/projects/serial-console.html

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
