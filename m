Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:46771 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbbANSFI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Jan 2015 13:05:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1YBSJU-0004aD-4g
	for util-linux@vger.kernel.org; Wed, 14 Jan 2015 19:05:04 +0100
Received: from dynamic-adsl-84-223-98-34.clienti.tiscali.it ([84.223.98.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 14 Jan 2015 19:05:04 +0100
Received: from lucio by dynamic-adsl-84-223-98-34.clienti.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 14 Jan 2015 19:05:04 +0100
To: util-linux@vger.kernel.org
From: Lucio Crusca <lucio@sulweb.org>
Subject: [BUG] losetup: support for physical devices
Date: Wed, 14 Jan 2015 18:59:58 +0100
Message-ID: <m96ard$qu8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

During a disaster recovery I found that losetup either 

1. does not support creating loop devices that target physical devices. In 
this case I think there exists a compelling reason to support them 
(http://serverfault.com/questions/659484) and this bug report is a wishlist 
bug 

or 

2. it does support physical devices, but it is an undocumented feature (at 
least in the manpage) and the warning it issues is misleading beacuse it 
makes you think it doesn't support them ("losetup: /dev/sdc2: warning: file 
smaller than 512 bytes, the loop device maybe be useless or invisible for 
system tools"). In this case this could be a documentation bug.

I haven't tested which of the two possibilities is the real situation, but 
I'm pretty sure you already know.

Thanks for your attention,
Lucio.

