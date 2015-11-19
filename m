Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:54476 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461AbbKSBxO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Nov 2015 20:53:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZzEPP-0001ub-4r
	for util-linux@vger.kernel.org; Thu, 19 Nov 2015 02:53:11 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 02:53:11 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 02:53:11 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: udevil - mount tool
Date: Thu, 19 Nov 2015 02:53:04 +0100
Message-ID: <n2ja20$1sf$1@ger.gmane.org>
References: <n2ibqp$ui6$1@ger.gmane.org> <564CC253.2080301@gmail.com>
 <20151119010838.GA16043@CasperVector>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151119010838.GA16043@CasperVector>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Casper Ti. Vector wrote on 11/19/2015 02:08 AM:
> Also udevil, which might be of particular interest if you happen to
> pursue a system with light dependencies:
> <https://ignorantguru.github.io/udevil/>.

Yes, I like lightweight cmdline tools with light dependencies.
I'll try it out, thx.

Do you happen to know if it has some dangerous options like "bind-mounting" 
like the standard "mount" pgm has?
Bind-mounting is a big security risk, really, and that's the sole
reason I was looking for an alternate mount tool for non-root users.

I see it's in the Debian repository; this makes things easier for me
(albeit the description is not very helpful, one could think it's an API :-) :
# aptitude search -F '%p %V %v %d' udevil
udevil  0.4.3-1  <none>  Alternative storage media interface



