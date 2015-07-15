Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbbGOOXq convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2015 10:23:46 -0400
Date: Wed, 15 Jul 2015 16:23:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: lslogins --user-accs
Message-ID: <20150715142344.GF31997@ws.net.home>
References: <mnesfe$veu$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <mnesfe$veu$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 07, 2015 at 12:37:49AM +0300, Mantas Mikulėnas wrote:
> Trying out `lslogins`, noticed two problems (?) with the --user-accs option:
> 
> 1) The manpage documents --user-accs[=threshold] to override the
> "hardcoded" minimum of 1000, but the code doesn't actually /accept/ a
> parameter (it reads the actual threshold from login.defs).
> 
> 2) While not documented, --user-accs also applies the /maximum/ uid
> limit. I noticed this on a system that has "UID_MAX 19999" because
> LDAP-based accounts start at 20000, which means `lslogins -u` will show
> local users but not LDAP ones.
 
For now I have fixed the man page and removed [=threshold] and added
hint about uids ranges specified by /etc/login.defs.

Maybe the ideal solution would be to add optional parameter

    --user-accs[=min:max]
    --system-accs[=min:max]


> Also the "Last logs:" output seems to have ^A / 0x01 in random places:
> 
>   00:35:14 krenew<^A>[1295]: renewing credentials
> 
> On another system:
> 
>   Feb07/00:05 sshd[3009657]: Received disconnect from 78.60.211.195: 11:
> disconnected by user<^A>

Hmm... we read this from systemd journal by sd_journal_get_data() and
print it without any change.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
