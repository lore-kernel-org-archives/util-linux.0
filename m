Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64095 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933356Ab0KQBER (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 16 Nov 2010 20:04:17 -0500
Received: by iwn35 with SMTP id 35so1492360iwn.19
        for <util-linux-ng@vger.kernel.org>; Tue, 16 Nov 2010 17:04:17 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 16 Nov 2010 17:04:16 -0800
Message-ID: <AANLkTi=vwO5sFqp=DGYUbsatAK6Hud+UvLQ8PDacs-e5@mail.gmail.com>
Subject: losetup -e 1 -p fd doesn't work
From: David Barksdale <david.barksdale@adcedosolutions.com>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>

Why does losetup use getpass() for LO_CRYPT_XOR but xgetpass()
otherwise? Is this some devious plot to compel people to stop using
XOR?

-- 
David Barksdale
Adcedo Solutions
+1-425-214-4901
