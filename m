Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:38119 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab3FHSuF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 8 Jun 2013 14:50:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1UlODD-0001lK-Fm
	for util-linux@vger.kernel.org; Sat, 08 Jun 2013 20:50:03 +0200
Received: from piekna-gts.2a.pl ([217.153.90.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Jun 2013 20:50:03 +0200
Received: from giecrilj by piekna-gts.2a.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Jun 2013 20:50:03 +0200
To: util-linux@vger.kernel.org
From: Krzysztof =?UTF-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
Subject: Re: [PATCH] Fix typos found by misspellings
Date: Sat, 08 Jun 2013 01:49:16 +0200
Message-ID: <kotrf8$s14$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

<URL: 
http://article.gmane.org/
gmane.linux.utilities.util-linux-ng/5651/match=visable >

The
 .BR rootcontext=
 option allows you to explicitly label the root inode of a FS being mounted
-before that FS or inode because visable to userspace. This was found to be
+before that FS or inode because visible to userspace. This was found to be
 useful for things like stateless linux.

I still do not understand the first sentence.  What is that supposed to 
mean?

Chris

