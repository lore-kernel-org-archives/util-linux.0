Return-Path: util-linux-owner@vger.kernel.org
Received: from donald.solnet.ch ([212.101.4.210]:39194 "EHLO donald.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab3KOPNo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Nov 2013 10:13:44 -0500
Received: from apsag.com (static-212-101-19-97.adsl.solnet.ch [212.101.19.97])
	by donald.solnet.ch (Postfix) with ESMTP id 5850A27395
	for <util-linux@vger.kernel.org>; Fri, 15 Nov 2013 15:06:20 +0000 (UTC)
Received: from [192.168.100.210] ([192.168.100.210]:56937)
	by apsag.com with [XMail 1.27 ESMTP Server]
	id <S5B4809> for <util-linux@vger.kernel.org> from <scm@aps-systems.ch>;
	Fri, 15 Nov 2013 16:06:16 +0100
Message-ID: <52863868.9080806@aps-systems.ch>
Date: Fri, 15 Nov 2013 16:06:16 +0100
From: Martin Schmid <scm@aps-systems.ch>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: RFQ: changes on ldattach.c for GSM710 discipline
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello

I'm just preparing for some add-ons and wanted to check if someone else 
is working on it and if my ideas are not too far away from what is the 
intention of the tool.

I'd like to add support for N_GSM710 that comes with the kernel module 
n_gsm. Someone else ('guowenxue') has already brought a slightly patched 
version into the wild which is too restricted and specific.

The planned features are:

- setting the GSM710 discipline
- sending a configurable string out (parameter '--mux' or '-m', default 
AT+CMUX=0)
- configurable pause in seconds after the command (parameter '--pause' 
or -p)
- UUCP lock file support (-l or --lock, default none, 
'/var/lock/<devicename>' if no argument is given)

/Martin

-- 
Martin Schmid
APS systems AG, Neumatt 4, CH-4626 Niederbuchsiten
Tel direkt: +41 62 389 8891, Fax: +41 62 389 8880, Tel: +41 62 389 8888
www.aps-systems.ch

