Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.95]:57875 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab2LHQZD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Dec 2012 11:25:03 -0500
Message-ID: <50C36967.8050109@zoho.com>
Date: Sat, 08 Dec 2012 17:23:03 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org,
        =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] Add setpriv, a tool to set privileges and such
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net> <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
In-Reply-To: <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/12/12 09:19, Andy Lutomirski wrote:
> This can set no_new_privs, uid, gid, groups, securebits, inheritable caps, the cap
> bounding set, securebits, and selinux and apparmor labels.
> 
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---

The no_new_privs can only be set with --nnp, which is not a very
self-documenting name.
I would also add a long name --no-new-privs for that option.



