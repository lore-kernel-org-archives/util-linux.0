Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.albyny.inoc.net ([64.22.32.72]:55611 "EHLO
	mail2.albyny.inoc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbcEBLpI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 May 2016 07:45:08 -0400
Received: from Arnold (ip-72-10-210-108.nwptny.ntcnet.net [72.10.210.108])
	by mail2.albyny.inoc.net (build v15.0.5) with ESMTP id 2215747-1941382
	for <util-linux@vger.kernel.org>; Mon, 02 May 2016 11:28:44 +0000
Message-ID: <1462188523.1328.100.camel@inanaturallight.com>
Subject: Issue with SU manpage
From: Curt Bronson <curt@inanaturallight.com>
To: util-linux@vger.kernel.org
Date: Mon, 02 May 2016 07:28:43 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Folks,
I've long been under the impression that the correct way to exit a
superuser session was to SU back to my own username and was terribly
surprised to find my terminal session return to root when I entered the
word "exit" subsequent to working in a superuser session and SUing
"back" to my own id.  After going through a couple dozen web tutorials I
found a unix (not linux) tutorial that showed an example of SU with a
subsequent "exit" which showed the return to normal user authority, no
other tutorials gave any mention of the necessity to "exit" to return to
normal authority.
Considering the security exposure that this behavior could engender with
those like me that don't understand the behavior (and I suspect I'm not
the only mistaken user), I suggest that this be pointed out on the SU
man page.
Many thanks,
Curt

