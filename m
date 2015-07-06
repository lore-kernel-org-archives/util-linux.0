Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:59891 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbbGFVh7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jul 2015 17:37:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZCE5N-0001S9-Sj
	for util-linux@vger.kernel.org; Mon, 06 Jul 2015 23:37:58 +0200
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 06 Jul 2015 23:37:57 +0200
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 06 Jul 2015 23:37:57 +0200
To: util-linux@vger.kernel.org
From: =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Subject: lslogins --user-accs
Date: Tue, 7 Jul 2015 00:37:49 +0300
Message-ID: <mnesfe$veu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Trying out `lslogins`, noticed two problems (?) with the --user-accs option:

1) The manpage documents --user-accs[=threshold] to override the
"hardcoded" minimum of 1000, but the code doesn't actually /accept/ a
parameter (it reads the actual threshold from login.defs).

2) While not documented, --user-accs also applies the /maximum/ uid
limit. I noticed this on a system that has "UID_MAX 19999" because
LDAP-based accounts start at 20000, which means `lslogins -u` will show
local users but not LDAP ones.

~

Also the "Last logs:" output seems to have ^A / 0x01 in random places:

  00:35:14 krenew<^A>[1295]: renewing credentials

On another system:

  Feb07/00:05 sshd[3009657]: Received disconnect from 78.60.211.195: 11:
disconnected by user<^A>

-- 
Mantas Mikulėnas <grawity@gmail.com>

